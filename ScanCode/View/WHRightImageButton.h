//
//  WHRightImageButton.h
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHRightImageButton : UIButton{
    
}

/**
 名称
 */
@property (nonatomic, strong) NSString *name;
/**
 名称颜色
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 名称字体样式
 */
@property (nonatomic, strong) UIFont *textFont;
/**
 是否显示右边图片
 */
@property (nonatomic, assign) BOOL isrShowRightImage;
/**
 右边图片
 */
@property (nonatomic, strong) UIImage *rightImage;

@end

NS_ASSUME_NONNULL_END
