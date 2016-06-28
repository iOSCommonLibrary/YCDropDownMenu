//
//  Item1ViewController.m
//  YCDropDownMenu
//
//  Created by xiaochong on 16/6/26.
//  Copyright © 2016年 尹冲. All rights reserved.
//

#import "Item1ViewController.h"
#import "YCDropDownMenu.h"
#import "UIView+AutoLayout.h"

@interface Item1ViewController () <YCDropDownMenuDelegate>

@end

@implementation Item1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
#pragma mark - 例子一，有左边标题
    YCDropDownMenu *menu1 = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 45)];
    // 设置数据
    NSArray *listArray1 = @[ @"身份证", @"驾驶证", @"身份证", @"驾驶证", @"身份证", @"驾驶证"];
    // 设置代理
    menu1.delegate = self;
    menu1.leftTitle = @"证件类型：";
    menu1.lists = listArray1;
    [self.view insertSubview:menu1 atIndex:0];
    
#pragma mark - 例子二，没有左边标题

    YCDropDownMenu *menu2 = [[YCDropDownMenu alloc] init];
    menu2.frame = CGRectMake(0, 124, self.view.frame.size.width, 45);
    // 设置数据
    NSArray *listArray2 = @[ @"身份证", @"驾驶证"];
    // 设置代理
    menu2.delegate = self;
    menu2.lists = listArray2;
    [self.view insertSubview:menu2 atIndex:0];

    
    
}

#pragma mark - YCDropDownMenuDelegate
- (void)dropDownMenu:(YCDropDownMenu *)menu didClickedText:(NSString *)text {
    NSLog(@"%@", text);
}


@end
