//
//  WHQRCodePaymentView.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//二维码支付

#import "WHQRCodePaymentView.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "WHWeakTimer.h"

#define TimeLimit 2
#define AutoRefreshTimeLimit 60
@interface WHQRCodePaymentView (){
    
}
//二维码对准机具扫码口
@property (nonatomic, strong) UILabel *titleLabel;
//二维码
@property (nonatomic, strong) UIImageView *qRCodeImageView;
//云卡刷新状态
@property (nonatomic, strong) UILabel *refreshStatusLabel;
//电子票提示
@property (nonatomic, strong) UILabel *eTicketReminderLabel;
//支付方式
@property (nonatomic, strong) UILabel *paymentMethodLabel;

@property (nonatomic, assign) CGFloat timeNumber;
//定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WHQRCodePaymentView

- (id) init
{
    self = [super init];
    if(self) {
        
        [self basicInit];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        [self basicInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self basicInit];
    }
    return self;
}

-(void)basicInit{
    
    self.backgroundColor = [UIColor whiteColor];
    ESWeakSelf
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"二维码对准机具扫码口";
        _titleLabel.textColor = [UIColor convertHexColorToUIColor:0xBFBFBF];
        _titleLabel.font = [UIFont fontWithName:kFontPingFangRegular size:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20*kScreen_Proportion);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(14);
        }];
    }
    
    if (!_qRCodeImageView) {
        _qRCodeImageView = [[UIImageView alloc] init];
        _qRCodeImageView.image = [UIImage imageNamed:@"qRCode"];
        [self addSubview:_qRCodeImageView];
        [_qRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(54*kScreen_Proportion);
            make.width.height.mas_equalTo(208*kScreen_Proportion);
            make.centerX.equalTo(__weakSelf.mas_centerX).offset(0);
        }];
    }
    
    if (!_refreshStatusLabel) {
        _refreshStatusLabel = [[UILabel alloc] init];
        _refreshStatusLabel.hidden = YES;
        _refreshStatusLabel.attributedText = [WHConfig getAttributeWith:@" 刷新" string:@"乘车码自动刷新 刷新" orginFont:[UIFont fontWithName:kFontPingFangRegular size:14] orginColor:[UIColor convertHexColorToUIColor:0xBFBFBF] attributeFont:[UIFont fontWithName:kFontPingFangRegular size:18] attributeColor:kAllPagesCustomeColor];
        [_refreshStatusLabel yb_addAttributeTapActionWithStrings:@[@" 刷新"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
            NSLog(@"%@",string);
            [__weakSelf refreshAction];
        }];
        
        _refreshStatusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_refreshStatusLabel];
        [_refreshStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.qRCodeImageView.mas_bottom).offset(18*kScreen_Proportion);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(14);
        }];
    }
    
    if (!_eTicketReminderLabel) {
        _eTicketReminderLabel = [[UILabel alloc] init];
        _eTicketReminderLabel.text = @"已刷新";
        _eTicketReminderLabel.textColor = [UIColor convertHexColorToUIColor:0xBFBFBF];
        _eTicketReminderLabel.font = [UIFont fontWithName:kFontPingFangRegular size:14];
        _eTicketReminderLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_eTicketReminderLabel];
        [_eTicketReminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.qRCodeImageView.mas_bottom).offset(18*kScreen_Proportion);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(14);
        }];
    }
    
    if (!_paymentMethodLabel) {
        _paymentMethodLabel = [[UILabel alloc] init];
        _paymentMethodLabel.text = @"云卡支付";
        _paymentMethodLabel.textColor = [UIColor convertHexColorToUIColor:0x787878];
        _paymentMethodLabel.font = [UIFont fontWithName:kFontPingFangRegular size:14];
        _paymentMethodLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_paymentMethodLabel];
        [_paymentMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.refreshStatusLabel.mas_bottom).offset(15*kScreen_Proportion);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(14);
        }];
    }
    
    
}

-(void)startTimer{
    if (self.paymentMethod == 1) {
        //启动定时器
        [self refreshAction];
        if (_timer == nil) {
            _timer = [WHWeakTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:@"QRCode" repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [_timer fire];
        }
        
    }
    
}

-(void)invalidate{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/**
 支付二维码
 */
-(void)setQRCodeImage:(UIImage *)qRCodeImage{
    _qRCodeImage = qRCodeImage;
    _qRCodeImageView.image = qRCodeImage;
}
/**
 支付方式 1:云卡支付 2：电子票支付
 */
-(void)setPaymentMethod:(NSInteger)paymentMethod{
    _paymentMethod = paymentMethod;
    if (paymentMethod == 1) {  //云卡支付
        [self startTimer];
        _paymentMethodLabel.text = @"云卡支付";
        _eTicketReminderLabel.text = @"已刷新";
        
    }else if (paymentMethod == 2){  //电子票支付
        [self invalidate];
        _refreshStatusLabel.hidden = YES;
        _eTicketReminderLabel.hidden = NO;
        _eTicketReminderLabel.text = @"自动刷新 请勿泄露";
        _paymentMethodLabel.text = @"电子票支付";
    }
}

-(void)refreshAction{
    _refreshStatusLabel.hidden = YES;
    _eTicketReminderLabel.hidden = NO;
    _eTicketReminderLabel.text = @"已刷新";
    self.timeNumber = 0;
}

-(void)levelTimer:(NSTimer*)timer_{
    
    self.timeNumber += 0.1;
    NSLog(@"%.f",self.timeNumber);
    if (self.paymentMethod == 2) {
        _refreshStatusLabel.hidden = YES;
        _eTicketReminderLabel.hidden = NO;
        _eTicketReminderLabel.text = @"自动刷新 请勿泄露";
        _paymentMethodLabel.text = @"电子票支付";
    }else {
        
        if (self.timeNumber > TimeLimit && self.timeNumber < AutoRefreshTimeLimit) {
            
            _refreshStatusLabel.hidden = NO;
            _eTicketReminderLabel.hidden = YES;
            _eTicketReminderLabel.text = @"自动刷新 请勿泄露";
            
        }else if (self.timeNumber > AutoRefreshTimeLimit) {
            _refreshStatusLabel.hidden = YES;
            _eTicketReminderLabel.hidden = NO;
            _eTicketReminderLabel.text = @"已刷新";
            self.timeNumber = 0;
        }
        
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
