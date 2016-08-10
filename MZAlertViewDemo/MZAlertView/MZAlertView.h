//
//  MZAlertView.h
//  MZAlertViewDemo
//
//  Created by 麦子 on 16/8/10.
//  Copyright © 2016年 麦子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelClick)();
typedef void (^ConfirmClick)();

@interface MZAlertView : UIView

@property (nonatomic, strong)UIColor *cancelColor;          // 取消按钮的颜色
@property (nonatomic, strong)UIColor *confirmColor;         // 确认按钮的颜色
@property (nonatomic, strong)UIColor *titleColor;           // 标题颜色
@property (nonatomic, strong)UIFont *cancelFont;            // 取消按钮的字体
@property (nonatomic, strong)UIFont *confirmFont;           // 确认按钮的字体
@property (nonatomic, strong)UIFont *titleFont;             // 标题的字体

/**
 *  AlertView初始化
 *
 *  @param title        标题
 *  @param cancelTitle  取消标题
 *  @param confirmTitle 确认标题
 *  @param cancelClick  取消按钮点击事件
 *  @param confirmClick 确认按钮点击事件
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)title
                       cancel:(NSString *)cancelTitle
                      confirm:(NSString *)confirmTitle
                  cancelClick:(CancelClick)cancelClick
                 confirmClick:(ConfirmClick)confirmClick;

/**
 *  ActionSheet显示
 */
- (void)show;

@end
