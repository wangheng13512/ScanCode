//
//  WHRightImageButton.m
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import "WHRightImageButton.h"
@interface WHRightImageButton () {
    
}

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation WHRightImageButton

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
    self.backgroundColor = [UIColor clearColor];
    ESWeakSelf
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor convertHexColorToUIColor:0x8C8C8C];
        _nameLabel.font = [UIFont fontWithName:kFontPingFangMedium size:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"";
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.equalTo(__weakSelf.mas_centerX).offset(0);
            make.width.greaterThanOrEqualTo(@20);
            make.bottom.mas_equalTo(0);
        }];
    }
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_blue.png"]];
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(__weakSelf.nameLabel.mas_right).offset(5);
        }];
        
    }
    
    //    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
    //       make.centerX.equalTo(__weakSelf.mas_centerX).offset(__weakSelf.rightImageView.frame.size.width / 2);
    //    }];
    
}

-(void)setName:(NSString *)name{
    _name = name;
    _nameLabel.text = name == nil ? @"" : name;
}

-(void)setIsrShowRightImage:(BOOL)isrShowRightImage{
    _isrShowRightImage = isrShowRightImage;
    _rightImageView.hidden = !isrShowRightImage;
}
/**
 右边图片
 */
-(void)setRightImage:(UIImage *)rightImage{
    _rightImage = rightImage;
    _rightImageView.image = rightImage;
}
/**
 名称颜色
 */
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _nameLabel.textColor = textColor;
}
/**
 名称字体样式
 */
-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    _nameLabel.font = textFont;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
