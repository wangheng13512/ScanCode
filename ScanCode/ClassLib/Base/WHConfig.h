//
//  WHConfig.h
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHConfig : NSObject

/**
 一串字符串改变某些字不同颜色和样式
 
 @param sender 需要改变的字体和字体数组
 @param string 一串完整字符串
 @param orginFont 原来样式
 @param orginColor 原来字体颜色
 @param attributeFont 修改的字体样式
 @param attributeColor 修改的字体颜色
 @return 修改后的字符串 NSAttributedString
 */
+ (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(UIFont*)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(UIFont*)attributeFont
                          attributeColor:(UIColor *)attributeColor;

@end

NS_ASSUME_NONNULL_END
