//
//  WHPurchaseTicketsView.h
//  ScanCode
//
//  Created by wangheng on 2019/12/12.
//  Copyright © 2019年 wangheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHPurchaseTicketsView : UIView{
    
}
/**
 状态 1:未开通云卡 2：云卡余额不足
 */
@property (nonatomic, assign) NSInteger stutas;
/**
 立即开通云卡
 */
@property (nonatomic, copy) void (^openCloudCardImmediatelyClickBlock)(void);
/**
 云卡余额不足，立即充值
 */
@property (nonatomic, copy) void (^insufficientCloudCardBalanceClickBlock)(void);
/**
 立即购买电子票
 */
@property (nonatomic, copy) void (^buyAnETicketNowClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
