//
//  WHQRCodePaymentView.h
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHQRCodePaymentView : UIView{
    
}
/**
 支付二维码
 */
@property (nonatomic, strong) UIImage *qRCodeImage;
/**
 支付方式 1:云卡支付 2：电子票支付
 */
@property (nonatomic, assign) NSInteger paymentMethod;

-(void)startTimer;

-(void)invalidate;

@end

NS_ASSUME_NONNULL_END
