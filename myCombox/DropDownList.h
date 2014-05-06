//
//  DropDownList.h
//  myCombox
//
//  Created by ChenHao on 5/5/14.
//  Copyright (c) 2014 ChenHao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownList : UIView<UITableViewDataSource, UITableViewDelegate>
{
    CGRect oldFrame,newFrame;//整个控件（包括下拉前和下拉后）的矩形
    UIColor *lineColor,*listBgColor;//下拉框的边框色、背景色
    CGFloat lineWidth;//下拉框边框粗细
    UITextBorderStyle borderStyle;//文本框边框style
}

@property (strong ,nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *buttonDropDown;
@property (copy, nonatomic) NSArray *list;
@property (copy, nonatomic) NSArray *filterlist;
@property (assign, nonatomic) BOOL showList;
@property (strong, nonatomic) UITableView *listView;

@property (assign, nonatomic) NSInteger selectedInter;

- (id)initWithFrame:(CGRect)frame withData:(NSArray *)data;
- (id)initWithFrame:(CGRect)frame withData:(NSArray *)data withSelectedInter:(NSInteger )selectedNum;

- (void)setNewListFrame:(BOOL)b;
- (void)dropDown;
@end
