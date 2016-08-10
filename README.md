# MZActionSheetDemo

一个简洁的iOS弹出框，类似系统的AlertView，但是这个类已经被废弃了，出于苹果UIAlertController自身限制的原因，于是自定了以下弹出框。

以下是效果图：

![](https://github.com/MrWheat/MZAlertViewDemo/blob/master/MZAlertViewDemoImage.gif?raw=true)

使用步骤如下：

首先调用以下方法对AlertView初始化。

```Objective-c
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
```

初始化完成后，修改控件属性，这里预留了一些可能用到的属性，可以根据需要更改。

```Objective-c
@property (nonatomic, strong)UIColor *cancelColor;          // 取消按钮的颜色
@property (nonatomic, strong)UIColor *confirmColor;         // 确认按钮的颜色
@property (nonatomic, strong)UIColor *titleColor;           // 标题颜色
@property (nonatomic, strong)UIFont *cancelFont;            // 取消按钮的字体
@property (nonatomic, strong)UIFont *confirmFont;           // 确认按钮的字体
@property (nonatomic, strong)UIFont *titleFont;             // 标题的字体
```

最后调用以下方法将弹框显示到屏幕上。

```Objective-c
/**
 *  AlertView显示
 */
- (void)show;
```

例：

```Objective-c
MZAlertView *alertView = [[MZAlertView alloc] initWithTitle:@"这是标题" cancel:@"取消" confirm:@"确认" cancelClick:^{
    NSLog(@"取消按钮点击了");
} confirmClick:^{
    NSLog(@"确认按钮点击了");
}];
alertView.titleColor = [UIColor redColor];
alertView.titleFont = [UIFont systemFontOfSize:18];
[alertView show];
```
