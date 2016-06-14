//
//  GoodsListCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartNode.h"


@protocol ShopCartDelegate <NSObject>
@optional

- (void)getchecheerPressed:(id)sender;// 选择
- (void)lessGoodsPressed:(id)sender;// 减少
- (void)addGoodsPressed:(id)sender;// 增加
//TODO:弹出提示
- (void)showAlertMsgPressed:(NSString *)msg;
@end

@interface ShopCartCell : UITableViewCell<UITextFieldDelegate>
{
    BOOL			m_checked;

}

@property (nonatomic, strong) UIView        *diView;//底部View

@property (nonatomic, strong) UIImageView   *m_checkImageView;//图标
@property (nonatomic, strong) UIButton      *secBtn;//选中

@property (nonatomic, strong) UIImageView   *headImgView;//图标
@property (nonatomic, strong) UILabel       *titleLab;//标题
@property (nonatomic, strong) UILabel       *allnumLab;//总需人次
@property (nonatomic, strong) UILabel       *surplusNumLab;//剩余人次
@property (nonatomic, strong) UITextField       *innumTextField;//参加人次
@property (nonatomic, strong) UIButton         *lessBtn;// 减少按钮
@property (nonatomic, strong) UIButton         *addBtn;// 增加按钮
@property (nonatomic, strong) UILabel           *showLab;//提示

@property (nonatomic, strong) ShopCartNode      *node;// 数据
@property (nonatomic, assign) id<ShopCartDelegate>  delegate;

// 是否选中
- (void) setChecked:(BOOL)checked;
@end


