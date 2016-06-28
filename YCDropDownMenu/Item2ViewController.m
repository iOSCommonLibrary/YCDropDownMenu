//
//  Item2ViewController.m
//  YCDropDownMenu
//
//  Created by xiaochong on 16/6/28.
//  Copyright © 2016年 尹冲. All rights reserved.
//

#import "Item2ViewController.h"
#import "YCDropDownMenu.h"

@interface Item2ViewController () <YCDropDownMenuDelegate>

@property (nonatomic,strong) YCDropDownMenu *lastDropDownMenu;

@end

@implementation Item2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    int cols = 3;
    CGFloat menuY = 64;
    CGFloat menuW = self.view.frame.size.width / cols;
    CGFloat menuH = 45;
    for (int i = 0; i < cols; i++) {
        CGFloat menuX = i % cols * menuW;
        YCDropDownMenu *deopDownMenu = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(menuX, menuY, menuW, menuH)];
#pragma mrak 设置了宽度
        deopDownMenu.listTableViewWidth = self.view.frame.size.width;
        NSString *one = [NSString stringWithFormat:@"身份证%d", i];
        NSString *two = [NSString stringWithFormat:@"驾驶证%d", i];
        NSArray *listArray2 = @[ one, two];
        // 设置代理
        deopDownMenu.delegate = self;
        deopDownMenu.lists = listArray2;
        [self.view insertSubview:deopDownMenu atIndex:0];
        
    }
    
    for (int i = 0; i < cols; i++) {
        CGFloat menuX = i % cols * menuW;
        YCDropDownMenu *deopDownMenu = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(menuX, 110, menuW, menuH)];
#pragma mrak 没有设置宽度
//        deopDownMenu.listTableViewWidth = self.view.frame.size.width;
        NSString *one = [NSString stringWithFormat:@"身份证%d", i];
        NSString *two = [NSString stringWithFormat:@"驾驶证%d", i];
        NSArray *listArray2 = @[ one, two];
        // 设置代理
        deopDownMenu.delegate = self;
        deopDownMenu.lists = listArray2;
        [self.view insertSubview:deopDownMenu atIndex:0];
        
    }
}

#pragma mark - YCDropDownMenuDelegate
/**
 *  点击的menu,不是menu的tableView
 */
- (void)dropDownMenuDidClickMenu:(YCDropDownMenu *)menu {
    if (menu != self.lastDropDownMenu && self.lastDropDownMenu.arrowIsDown == NO) {
        [self.lastDropDownMenu autoHideOrDisplay];
    }
    
    self.lastDropDownMenu = menu;
}


@end
