//
//  WHPurchaseTicketsView.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import "WHPurchaseTicketsView.h"
@interface WHPurchaseTicketsView (){
    
}
@property (nonatomic, strong) UIImageView *imageView;
//提示信息
@property (nonatomic, strong) UILabel *promptLabel;
//云卡
@property (nonatomic, strong) UIButton *cloudCardButton;
//购买电子票
@property (nonatomic, strong) UIButton *buyETicketButton;

@end

@implementation WHPurchaseTicketsView

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
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"promptInformation.png"]];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(__weakSelf.mas_centerX).offset(0);
            make.top.mas_equalTo(kDevice_Is_iPhone5 ? 14 : 27*kScreen_Proportion);
            make.width.height.mas_equalTo(48);
        }];
    }
    
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = @"请开通公交云卡\n或购买公交电子票";
        _promptLabel.textColor = [UIColor convertHexColorToUIColor:0x242424];
        _promptLabel.font = [UIFont fontWithName:kFontPingFangRegular size:20];
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.numberOfLines = 0;
        [self addSubview:_promptLabel];
        [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.imageView.mas_bottom).offset(kDevice_Is_iPhone5 ? 14 : 22*kScreen_Proportion);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(62);
        }];
    }
    
    if (!_cloudCardButton) {
        _cloudCardButton = [[UIButton alloc] init];
        [_cloudCardButton setTitle:@"立即开通云卡" forState:UIControlStateNormal];
        [_cloudCardButton setTitleColor:[UIColor convertHexColorToUIColor:0x408CE2] forState:UIControlStateNormal];
        _cloudCardButton.titleLabel.font = [UIFont fontWithName:kFontPingFangRegular size:21];
        _cloudCardButton.layer.borderColor = [UIColor convertHexColorToUIColor:0x408CE2].CGColor;
        _cloudCardButton.layer.borderWidth = 1.f;
        _cloudCardButton.layer.cornerRadius = 3.f;
        [_cloudCardButton addTarget:self action:@selector(cloudCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cloudCardButton];
        [_cloudCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.promptLabel.mas_bottom).offset(kDevice_Is_iPhone5 ? 14 : 25*kScreen_Proportion);
            make.width.mas_equalTo(250);
            make.height.mas_equalTo(50);
            make.centerX.equalTo(__weakSelf.mas_centerX).offset(0);
        }];
    }
    
    if (!_buyETicketButton) {
        _buyETicketButton = [[UIButton alloc] init];
        [_buyETicketButton setTitle:@"立即购买电子票" forState:UIControlStateNormal];
        [_buyETicketButton setTitleColor:[UIColor convertHexColorToUIColor:0x408CE2] forState:UIControlStateNormal];
        _buyETicketButton.titleLabel.font = [UIFont fontWithName:kFontPingFangRegular size:21];
        _buyETicketButton.layer.borderColor = [UIColor convertHexColorToUIColor:0x408CE2].CGColor;
        _buyETicketButton.layer.borderWidth = 1.f;
        _buyETicketButton.layer.cornerRadius = 3.f;
        [_cloudCardButton addTarget:self action:@selector(buyETicketButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buyETicketButton];
        [_buyETicketButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(__weakSelf.cloudCardButton.mas_bottom).offset(13);
            make.width.mas_equalTo(187);
            make.height.mas_equalTo(55);
            make.centerX.equalTo(__weakSelf.mas_centerX).offset(0);
        }];
    }
    
}
/**
 状态 1:未开通云卡 2：云卡余额不足
 */
-(void)setStutas:(NSInteger)stutas{
    _stutas = stutas;
    if (stutas == 1) {
        _promptLabel.text = @"请开通公交云卡\n或购买公交电子票";
        [_cloudCardButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(187);
        }];
        [_buyETicketButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(187);
        }];
        [_cloudCardButton setTitle:@"立即开通云卡" forState:UIControlStateNormal];
    }else if (stutas == 2) {
        _promptLabel.text = @"请充值公交云卡\n或购买公交电子票";
        [_cloudCardButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(250);
        }];
        [_buyETicketButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(250);
        }];
        [_cloudCardButton setTitle:@"云卡余额不足，立即充值" forState:UIControlStateNormal];
    }
}
//云卡
-(void)cloudCardButtonAction{
    if (_stutas == 1) {  //未开通云卡
        if (_openCloudCardImmediatelyClickBlock) {
            _openCloudCardImmediatelyClickBlock();
        }
    }else if (_stutas == 2) {  //云卡余额不足
        if (_insufficientCloudCardBalanceClickBlock) {
            _insufficientCloudCardBalanceClickBlock();
        }
    }
}
//立即购买电子票
-(void)buyETicketButtonAction{
    if (_buyAnETicketNowClickBlock) {
        _buyAnETicketNowClickBlock();
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
