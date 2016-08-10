//
//  MZAlertView.m
//  MZAlertViewDemo
//
//  Created by 麦子 on 16/8/10.
//  Copyright © 2016年 麦子. All rights reserved.
//

#import "MZAlertView.h"

#define LineWidth 1.0f

@interface MZAlertView ()

{
    CancelClick _cancelClick;
    ConfirmClick _confirmClick;
    NSString *_titleString;     // title
    NSString *_cancelString;    // 取消title
    NSString *_confirmString;   // 确认title
    UIView *_blackBgV;          // 遮罩视图
    UIView *_alertV;            // 提示视图
}


@end

@implementation MZAlertView

- (instancetype)initWithTitle:(NSString *)title cancel:(NSString *)cancelTitle confirm:(NSString *)confirmTitle cancelClick:(CancelClick)cancelClick confirmClick:(ConfirmClick)confirmClick {
    if (self = [super init]) {
        _titleString = title;
        _cancelString = cancelTitle;
        _confirmString = confirmTitle;
        _cancelClick = cancelClick;
        _confirmClick = confirmClick;
        
        //初始化子视图
    }
    return self;
}

- (void)installSubViews {
    self.frame = [UIScreen mainScreen].bounds;
    
    // 初始化遮罩视图
    _blackBgV = [[UIView alloc]initWithFrame:self.bounds];
    _blackBgV.backgroundColor = [UIColor grayColor];
    _blackBgV.alpha = 0;
    [self addSubview:_blackBgV];
    
    // 初始化actionSheetView
    _alertV = [[UIView alloc] initWithFrame:CGRectMake(35,self.bounds.size.height/2-70, self.bounds.size.width - 70, 140)];
    _alertV.backgroundColor = [UIColor whiteColor];
    _alertV.layer.cornerRadius = 5;
    _alertV.layer.masksToBounds = YES;
    _alertV.alpha = 0;
    [self addSubview:_alertV];
    
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, _alertV.bounds.size.width, 25)];
    if (_titleString && _titleString.length>0) {
        headLabel.text = _titleString;
    }
    if (self.titleColor) {
        headLabel.textColor = self.titleColor;
    } else {
        headLabel.textColor = [UIColor blackColor];
    }
    headLabel.textAlignment = NSTextAlignmentCenter;
    if (self.titleFont) {
        headLabel.font = self.titleFont;
    } else {
        headLabel.font = [UIFont systemFontOfSize:15];
    }
    [_alertV addSubview:headLabel];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, headLabel.frame.size.height+headLabel.frame.origin.y+40, _alertV.bounds.size.width, LineWidth)];
    line.backgroundColor = [UIColor colorWithRed:0xdc/256.0 green:0xdc/256.0 blue:0xdc/256.0 alpha:1];
    [_alertV addSubview:line];
    
    UILabel *line0 = [[UILabel alloc] initWithFrame:CGRectMake(_alertV.frame.size.width/2, line.frame.origin.y+LineWidth, LineWidth, _alertV.frame.size.height-line.frame.origin.y-1)];
    line0.backgroundColor = [UIColor colorWithRed:0xdc/256.0 green:0xdc/256.0 blue:0xdc/256.0 alpha:1];
    [_alertV addSubview:line0];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, line.frame.origin.y+LineWidth, line0.frame.origin.x, line0.frame.size.height);
    if (self.cancelFont) {
        [cancelButton.titleLabel setFont:self.cancelFont];
    } else {
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    if (_cancelString) {
        [cancelButton setTitle:_cancelString forState:UIControlStateNormal];
    } else {
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    }
    if (self.cancelColor) {
        [cancelButton setTitleColor:self.cancelColor forState:UIControlStateNormal];
    } else {
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertV addSubview:cancelButton];
    
    
    UIButton *confimButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confimButton.frame = CGRectMake(line0.frame.origin.x+LineWidth, line.frame.origin.y+LineWidth, line0.frame.origin.x, line0.frame.size.height);
    if (self.confirmFont) {
        [confimButton.titleLabel setFont:self.confirmFont];
    } else {
        [confimButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    if (_confirmString) {
        [confimButton setTitle:_confirmString forState:UIControlStateNormal];
    } else {
        [confimButton setTitle:@"确认" forState:UIControlStateNormal];
    }
    if (self.confirmColor) {
        [confimButton setTitleColor:self.confirmColor forState:UIControlStateNormal];
    } else {
        [confimButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [confimButton addTarget:self action:@selector(confimButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertV addSubview:confimButton];
    
    // 遮罩加上手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [_blackBgV addGestureRecognizer:tap];
    self.hidden = YES;
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)show {
    [self installSubViews];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _alertV.alpha = 1;
        _blackBgV.alpha = 0.5;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidden {
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _alertV.alpha = 0;
        _blackBgV.alpha = 0;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark -- 点击事件
- (void)confimButtonClick:(UIButton *)sender {
    if (_confirmClick) {
        _confirmClick();
    }
    [self hidden];
}

- (void)cancelButtonClick:(UIButton *)sender {
    if(_cancelClick) {
        _cancelClick();
    }
    [self hidden];
}

#pragma mark -- 遮罩视图点击
- (void)tapClick:(UIGestureRecognizer *)tap {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
