//
//  WHBusCodeViewController.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import "WHBusCodeViewController.h"
#import "WHBusCodeView.h"
#import "UIRangeExpansionButton.h"

@interface WHBusCodeViewController (){
    
}

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIRangeExpansionButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) WHBusCodeView *busCodeView;

@end

@implementation WHBusCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubView];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [_busCodeView startTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
    [_busCodeView invalidate];
}

-(void)createSubView{
    ESWeakSelf
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = kAllPagesBackgroundColor;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_contentScrollView];
        [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
    }
    
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = kAllPagesBackgroundColor;
        [_contentScrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(__weakSelf.contentScrollView); //此处必填 - 关键点
            make.edges.equalTo(__weakSelf.contentScrollView);
        }];
    }
    
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"busCodeHeader.png"]];
        [_contentView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(352*kScreen_Proportion);
        }];
    }
    
    if (!_backButton) {
        _backButton = [[UIRangeExpansionButton alloc] init];
        [_backButton setImage:[UIImage imageNamed:@"close_white"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(35+JF_TOP_ACTIVE_SPACE);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(18);
            
        }];
    }
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"乘车码";
        _titleLabel.font = [UIFont fontWithName:kFontPingFangMedium size:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor convertHexColorToUIColor:0xFFFFFF];
        [_contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(__weakSelf.backButton.mas_centerY).offset(0);
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-60);
            make.height.mas_equalTo(16);
        }];
        
    }
    
    if (!_busCodeView) {
        _busCodeView = [[WHBusCodeView alloc] init];
        _busCodeView.layer.masksToBounds = YES;
        _busCodeView.layer.cornerRadius = 10.f;
        _busCodeView.busCodeStatus = 1;
        [_contentView addSubview:_busCodeView];
        [_busCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(88 + JF_TOP_ACTIVE_SPACE);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(471*kScreen_Proportion);
        }];
    }
    
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(__weakSelf.busCodeView.mas_bottom).offset(80);
    }];
    
}


-(void)backButtonAction{
    [self backAction];
}

- (void)backAction
{
    UIViewController* popVC = [self.navigationController popViewControllerAnimated:YES];
    if (popVC == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
