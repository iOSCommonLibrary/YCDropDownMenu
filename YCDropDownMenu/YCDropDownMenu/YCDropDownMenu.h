//
//  YCDropDownMenu.h
//  YCDropDownMenu
//
//  Created by xiaochong on 16/6/26.
//  Copyright © 2016年 尹冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCDropDownMenu;

@protocol YCDropDownMenuDelegate <NSObject>

@optional

- (void)dropDownMenu:(YCDropDownMenu *)menu didClickedText:(NSString *)text;

- (void)dropDownMenuDidClickMenu:(YCDropDownMenu *)menu;

@end

@interface YCDropDownMenu : UIView

/**
 *  下拉显示的数据
 */
@property (nonatomic,strong) NSArray *lists;

//-----------------------------------------------------------左边标题
/**
 *  左边的标题
 */
@property (nonatomic,copy) NSString *leftTitle;
/**
 *  左边标题的文字大小
 */
@property (nonatomic,strong) UIFont *leftTitleFont;
/**
 *  左边标题的文字颜色
 */
@property (nonatomic,strong) UIColor *leftTitleColor;

//-----------------------------------------------------------中间内容
/**
 *  中间的内容的字体大小
 */
@property (nonatomic,strong) UIFont *contentFont;
/**
 *  中间的内容的文字的颜色
 */
@property (nonatomic,strong) UIColor *contentColor;
/**
 *  当前选中的文字
 */
@property (nonatomic,copy) NSString *currtentContent;


/**
 *  代理
 */
@property (nonatomic,weak) id<YCDropDownMenuDelegate> delegate;

/**
 *   下拉菜单的宽度
 */
@property (nonatomic,assign) CGFloat listTableViewWidth;

/**
 *  自动显示和隐藏下拉列表
 */
- (void)autoHideOrDisplay;

/**
 *  是否向下
 */
@property (nonatomic,assign,readonly) BOOL arrowIsDown;

@end
