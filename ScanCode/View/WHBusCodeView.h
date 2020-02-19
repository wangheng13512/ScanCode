//
//  WHBusCodeView.h
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHBusCodeView : UIView{
    
}
/**
 乘车码装状态 0:加载中 1：云卡支付 2：电子票支付 3：未开通云卡 4：云卡余额不足。请充值
 */
@property (nonatomic, assign) NSInteger busCodeStatus;
//开启定时器
-(void)startTimer;
//关闭定时器
-(void)invalidate;

@end

NS_ASSUME_NONNULL_END
