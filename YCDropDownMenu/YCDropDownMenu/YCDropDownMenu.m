//
//  YCDropDownMenu.m
//  YCDropDownMenu
//
//  Created by xiaochong on 16/6/26.
//  Copyright © 2016年 尹冲. All rights reserved.
//

#import "YCDropDownMenu.h"
#import "UIView+AutoLayout.h"

#define MenuBoardColor [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]
//最多展示多少行
#define MaxDisplayRows 3

@interface YCDropDownMenu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) UILabel *leftLabel;

@property (nonatomic,weak) UIView *rightView;

@property (nonatomic,weak) UIImageView *iconView;

@property (nonatomic,weak) UILabel *contentLabel;

@property (nonatomic,strong) UITableView *listTableView;

@property (nonatomic,assign) CGRect newF;

/**
 *  菜单的superView
 */
@property (nonatomic,strong) UIView *menuSuperView;

@property (nonatomic,strong) UIView *cover;

@end

@implementation YCDropDownMenu

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
    }
    return _listTableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    // 设置自己的边框
    self.layer.borderWidth = 1;
    self.layer.borderColor = MenuBoardColor.CGColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3;
    
    // 添加一个左边的标签
    UILabel *leftLabel = [[UILabel alloc] init];
    [self addSubview:leftLabel];
    self.leftLabel = leftLabel;
    
    // 添加右边的整体的父控件
    UIView *rightView = [[UIView alloc] init];
    [self addSubview:rightView];
    self.rightView = rightView;
    
    // 给右边的整体的父控件添加一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
    [rightView addGestureRecognizer:tap];
    
    // 添加向下的箭头
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    iconView.userInteractionEnabled = YES;
    iconView.contentMode = UIViewContentModeCenter;
    [self.rightView addSubview:iconView];
    self.iconView = iconView;
    
    // 添加一个显示选择的内容的Label
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    _arrowIsDown = YES;

    // 设置自己的背景
    self.backgroundColor = [UIColor whiteColor];
    
}

/**
 *  转圈并显示或隐藏listTableView
 */
- (void)tapMenu:(UITapGestureRecognizer *)tap {
    
    // 优先调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidClickMenu:)]) {
        [self.delegate dropDownMenuDidClickMenu:self];
    }
    
    [self autoHideOrDisplay];

}

- (void)autoHideOrDisplay {
    if (self.arrowIsDown) {
        [UIView animateWithDuration:0.3 animations:^{
            self.iconView.transform = CGAffineTransformMakeRotation(M_PI);
            self.listTableView.frame = CGRectMake(self.newF.origin.x, CGRectGetMaxY(self.newF), self.newF.size.width, self.lists.count >= MaxDisplayRows ? self.newF.size.height * MaxDisplayRows : self.newF.size.height * self.lists.count);
            // 添加一个遮盖，点击这个遮盖可以隐藏listTableView
            self.cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.cover.backgroundColor = [UIColor lightGrayColor];
            self.cover.alpha = 0.5;
            [self.cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenListTableView)]];
            [self.superview insertSubview:self.cover atIndex:0];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.iconView.transform = CGAffineTransformIdentity;
            self.listTableView.frame = CGRectMake(self.newF.origin.x, CGRectGetMaxY(self.newF), self.newF.size.width, 0);
            [self.cover removeFromSuperview];
        }];
    }
    
    // 修改箭头的状态
    _arrowIsDown = !self.arrowIsDown;
}

/**
 *  点击了遮盖
 */
- (void)hiddenListTableView {
    for (UIView *subView in self.menuSuperView.subviews) {
        if([subView isKindOfClass:[YCDropDownMenu class]]) {
            YCDropDownMenu *menu = (YCDropDownMenu *)subView;
            if (menu.arrowIsDown == NO) {
                [menu autoHideOrDisplay];
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    CGSize menuSize = self.frame.size;
    
    // 设置Label的位置
    if (self.leftTitle.length != 0) {
        if (self.leftTitleFont != nil) {
            CGSize leftTitleSize = [self.leftTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, menuSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.leftTitleFont} context:nil].size;
            [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
            [self.leftLabel autoSetDimensionsToSize:CGSizeMake(leftTitleSize.width, menuSize.height)];
        } else {
            CGSize leftTitleSize = [self.leftTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, menuSize.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.leftLabel.font} context:nil].size;
            [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
            [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
            [self.leftLabel autoSetDimensionsToSize:CGSizeMake(leftTitleSize.width, menuSize.height)];
        }
    }
    
    // 设置右边整个view的位置
    [self.rightView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 5, 0, 0) excludingEdge:ALEdgeLeft];
    [self.rightView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.leftLabel withOffset:0];
    
    // 设置右边的箭头的位置
    [self.iconView autoSetDimensionsToSize:CGSizeMake(menuSize.height * 0.6, menuSize.height * 0.6)];
    [self.iconView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.rightView withOffset:0];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:menuSize.height * 0.4 / 2];
    
    // 设置当前contentLabel的位置
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.leftLabel withOffset:15];
    [self.contentLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.iconView withOffset:0];
    
    // 设置tableView的位置
    [newSuperview addSubview:self.listTableView];
    
    // 记录父View
    self.menuSuperView = newSuperview;
    
    // 强制更新布局
    [self layoutIfNeeded];
    CGRect newF = [newSuperview convertRect:self.rightView.frame fromView:self];
    if (self.listTableViewWidth != 0) {
        newF.size.width = self.listTableViewWidth;
        newF.origin.x = 0;
    }
    self.listTableView.frame = CGRectMake(newF.origin.x, CGRectGetMaxY(newF), newF.size.width, 0);
    self.newF = newF;
    
    self.contentLabel.text = self.currtentContent;

}

- (void)setLists:(NSArray *)lists {
    _lists = lists;
    self.currtentContent = [lists firstObject];
}

#pragma mark - 标题相关设置
- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    self.leftLabel.text = leftTitle;
}

- (void)setLeftTitleFont:(UIFont *)leftTitleFont {
    _leftTitleFont = leftTitleFont;
    self.leftLabel.font = leftTitleFont;
}

- (void)setLeftTitleColor:(UIColor *)leftTitleColor {
    _leftTitleColor = leftTitleColor;
    [self.leftLabel setTextColor:leftTitleColor];
}

#pragma mark - 中间内容相关设置
- (void)setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    self.contentLabel.font = contentFont;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    [self.contentLabel setTextColor:contentColor];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"dropDownMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    }
    
    // 2.设置cel的数据
    cell.textLabel.text = self.lists[indexPath.row];
    cell.textLabel.font = self.contentFont;
    cell.textLabel.textColor = self.contentColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.currtentContent = cell.textLabel.text;
    self.contentLabel.text = cell.textLabel.text;
    [self autoHideOrDisplay];
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:didClickedText:)]) {
        [self.delegate dropDownMenu:self didClickedText:cell.textLabel.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.newF.size.height;
}

@end
