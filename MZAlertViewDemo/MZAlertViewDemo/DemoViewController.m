//
//  ViewController.m
//  MZAlertViewDemo
//
//  Created by 麦子 on 16/8/10.
//  Copyright © 2016年 麦子. All rights reserved.
//

#import "DemoViewController.h"
#import "MZAlertView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self createUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initViewController {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"视图弹出" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender {
    MZAlertView *alertView = [[MZAlertView alloc] initWithTitle:@"这是标题" cancel:@"取消" confirm:@"确认" cancelClick:^{
        NSLog(@"取消按钮点击了");
    } confirmClick:^{
        NSLog(@"确认按钮点击了");
    }];
    alertView.titleColor = [UIColor redColor];
    alertView.titleFont = [UIFont systemFontOfSize:18];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
