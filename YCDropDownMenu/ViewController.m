//
//  ViewController.m
//  YCDropDownMenu
//
//  Created by xiaochong on 16/6/26.
//  Copyright © 2016年 尹冲. All rights reserved.
//

#import "ViewController.h"
#import "YCDropDownMenu.h"
#import "UIView+AutoLayout.h"

@interface ViewController () <YCDropDownMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
#pragma mark - 例子一，有左边标题
    YCDropDownMenu *menu1 = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    // 设置数据
    NSArray *listArray1 = @[ @"身份证", @"驾驶证", @"身份证", @"驾驶证", @"身份证", @"驾驶证"];
    // 设置代理
    menu1.delegate = self;
    menu1.leftTitle = @"证件类型：";
    menu1.lists = listArray1;
    [self.view addSubview:menu1];
    
#pragma mark - 例子二，没有左边标题
    YCDropDownMenu *menu2 = [[YCDropDownMenu alloc] init];
    menu2.frame = CGRectMake(0, 50, self.view.frame.size.width, 45);
    // 设置数据
    NSArray *listArray2 = @[ @"身份证", @"驾驶证", @"身份证", @"驾驶证", @"身份证", @"驾驶证"];
    // 设置代理
    menu2.delegate = self;
    menu2.lists = listArray2;
    [self.view addSubview:menu2];
    
#pragma mark - 例子三
    int cols = 3;
    CGFloat menuY = 100;
    CGFloat menuW = self.view.frame.size.width / cols;
    CGFloat menuH = 45;
    for (int i = 0; i < cols; i++) {
        CGFloat menuX = i % cols * menuW;
        YCDropDownMenu *deopDownMenu = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(menuX, menuY, menuW, menuH)];
        NSArray *listArray2 = @[ @"身份证", @"驾驶证", @"身份证", @"驾驶证", @"身份证", @"驾驶证"];
        // 设置代理
        deopDownMenu.delegate = self;
        deopDownMenu.lists = listArray2;
        [self.view addSubview:deopDownMenu];
        
    }
    
    
}

#pragma mark - YCDropDownMenuDelegate
- (void)dropDownMenu:(YCDropDownMenu *)menu didClickedText:(NSString *)text {
    NSLog(@"%@", text);
}

@end
