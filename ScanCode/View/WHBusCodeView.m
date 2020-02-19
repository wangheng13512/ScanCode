//
//  WHBusCodeView.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import "WHBusCodeView.h"
#import "WHQRCodePaymentView.h"
#import "WHPurchaseTicketsView.h"
#import "WHRightImageButton.h"

@interface WHBusCodeView (){
    
}
@property (nonatomic, strong) UIImageView *backImageView;
//云卡卡号
@property (nonatomic, strong) UILabel *cloudNumberLabel;
//支付方式
@property (nonatomic, strong) UILabel *paymentMethodLabel;
//二维码支付
@property (nonatomic, strong) WHQRCodePaymentView *qRCodePaymentView;
//购票支付
@property (nonatomic, strong) WHPurchaseTicketsView *purchaseTicketsView;
//切换支付方式
@property (nonatomic, strong) WHRightImageButton *switchPayMetButton;

@end

@implementation WHBusCodeView

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
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"busCode_haining.png"]];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(__weakSelf);
        }];
    }
    
    if (!_cloudNumberLabel) {
        _cloudNumberLabel = [[UILabel alloc] init];
        _cloudNumberLabel.text = @"NO.5532 0165 50";
        _cloudNumberLabel.textColor = UIColor.whiteColor;
        _cloudNumberLabel.font = [UIFont fontWithName:kFontPingFangMedium size:12];
        _cloudNumberLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_cloudNumberLabel];
        [_cloudNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-9);
            make.left.mas_equalTo(100);
            make.height.mas_equalTo(12);
        }];
    }
    
    if (!_paymentMethodLabel) {
        _paymentMethodLabel = [[UILabel alloc] init];
        _paymentMethodLabel.text = @"云卡支付";
        _paymentMethodLabel.textColor = UIColor.whiteColor;
        _paymentMethodLabel.font = [UIFont fontWithName:kFontPingFangMedium size:18];
        _paymentMethodLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_paymentMethodLabel];
        [_paymentMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(61*kScreen_Proportion);
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(11);
            make.height.mas_equalTo(17);
        }];
    }
    
    if (!_switchPayMetButton) {
        _switchPayMetButton = [[WHRightImageButton alloc] init];
        _switchPayMetButton.name = @"切换为电子票支付";
        _switchPayMetButton.rightImage = [UIImage imageNamed:@"right_blue.png"];
        _switchPayMetButton.textColor = kAllPagesCustomeColor;
        _switchPayMetButton.textFont = [UIFont fontWithName:kFontPingFangRegular size:14];
        [_switchPayMetButton addTarget:self action:@selector(switchPayMetButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_switchPayMetButton];
        [_switchPayMetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5*kScreen_Proportion);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(34*kScreen_Proportion);
        }];
    }
    
    if (!_qRCodePaymentView) {
        _qRCodePaymentView = [[WHQRCodePaymentView alloc] init];
        _qRCodePaymentView.hidden = YES;
        [self addSubview:_qRCodePaymentView];
        [_qRCodePaymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(88*kScreen_Proportion);
            make.bottom.mas_equalTo(-45*kScreen_Proportion);
        }];
    }
    
    if (!_purchaseTicketsView) {
        _purchaseTicketsView = [[WHPurchaseTicketsView alloc] init];
        _purchaseTicketsView.hidden = YES;
        _purchaseTicketsView.openCloudCardImmediatelyClickBlock = ^{  //立即开通云卡
            
        };
        _purchaseTicketsView.insufficientCloudCardBalanceClickBlock = ^{  //云卡余额不足，立即充值
            
        };
        _purchaseTicketsView.buyAnETicketNowClickBlock = ^{  //立即购买电子票
            
        };
        [self addSubview:_purchaseTicketsView];
        [_purchaseTicketsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(88*kScreen_Proportion);
            make.bottom.mas_equalTo(-45*kScreen_Proportion);
        }];
    }
    
    
    
    
}

//切换卡片
-(void)switchPayMetButtonAction{
    self.qRCodePaymentView.paymentMethod = self.qRCodePaymentView.paymentMethod == 1 ? 2 : 1;
    self.paymentMethodLabel.text = self.qRCodePaymentView.paymentMethod == 1 ? @"云卡支付" : @"电子票支付";
    _switchPayMetButton.name = self.qRCodePaymentView.paymentMethod == 1 ? @"切换为电子票支付" : @"切换为云卡支付";
}

/**
 乘车码装状态 0:加载中 1：云卡支付 2：电子票支付 3：未开通云卡 4：云卡余额不足。请充值
 */
-(void)setBusCodeStatus:(NSInteger)busCodeStatus{
    _busCodeStatus = busCodeStatus;
    if (busCodeStatus == 0) {
        self.qRCodePaymentView.hidden = YES;
        self.purchaseTicketsView.hidden = YES;
        self.cloudNumberLabel.hidden = YES;
        self.paymentMethodLabel.hidden = YES;
        self.switchPayMetButton.hidden = YES;
    }else if (busCodeStatus == 1 || busCodeStatus == 2) {
        self.qRCodePaymentView.hidden = NO;
        self.purchaseTicketsView.hidden = YES;
        self.cloudNumberLabel.hidden = NO;
        self.paymentMethodLabel.hidden = NO;
        self.switchPayMetButton.hidden = NO;
        if (busCodeStatus == 1) {
            self.qRCodePaymentView.paymentMethod = 1;
        }else{
            self.qRCodePaymentView.paymentMethod = 2;
        }
    }else if (busCodeStatus == 3 || busCodeStatus == 4) {
        self.qRCodePaymentView.hidden = YES;
        self.purchaseTicketsView.hidden = NO;
        self.cloudNumberLabel.hidden = YES;
        self.paymentMethodLabel.hidden = YES;
        self.switchPayMetButton.hidden = YES;
        if (busCodeStatus == 3) {
            self.purchaseTicketsView.stutas = 1;
        }else{
            self.purchaseTicketsView.stutas = 2;
        }
    }
}

-(void)startTimer{
    [_qRCodePaymentView startTimer];
}

-(void)invalidate{
    [_qRCodePaymentView invalidate];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
