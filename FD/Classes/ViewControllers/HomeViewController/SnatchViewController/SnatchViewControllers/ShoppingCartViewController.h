//
//  ShoppingCartViewController.h
//  MetroPay
//
//  Created by Leoxu on 13-5-14.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartCell.h"
#import "BaseViewController.h"



@interface ShoppingCartViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ShopCartDelegate>
{
    float setHeight;//设置高度
    // 当前的编辑模式
    UITableViewCellEditingStyle _editingStyle;
    BOOL isEdit;// 是否编辑
    BOOL isAllSelect;// 是否全选
    NSInteger selectRow;// 当前选择行
    NSInteger getGcount;// 获取个数
    NSInteger deleteRow;
    

}

@property (nonatomic, strong) UIImageView      *noImgView;// 无内容图片
@property (nonatomic, strong) UILabel      *noDataLab;// 无内容提示
@property (nonatomic, strong) UITableView      *myTadleView;// 显示内容

@property (nonatomic, strong) UIView           *footView;// 底部View
@property (nonatomic, strong) UIButton         *allSelectBtn;// 全选Btn
@property (nonatomic, strong) UILabel          *showNLab;// 展示个数
@property (nonatomic, strong) UILabel         *showAPLab;// 显示金额
@property (nonatomic, strong) UILabel          *showASLab;// 显示全选
@property (nonatomic, strong) UILabel         *showSNLab;// 显示选择个数
@property (nonatomic, strong) UILabel         *conLab;// 说明

@property (nonatomic, strong) UIButton         *payBtn;// 结算按钮

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *contacts;



@end
