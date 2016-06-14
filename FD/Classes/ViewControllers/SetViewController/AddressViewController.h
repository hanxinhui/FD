//
//  AddressViewController.h
//  FD
//
//  Created by Leo xu on 14-10-21.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddressNode.h"

typedef enum {
    buyAddress,// 兑换商品设置地址
    winnerAddress, // 中奖地址设置
    setAddress, // 设置中地址
} setAddressStyle;

@interface AddressViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    float setHight;// 设置高度
    NSInteger  arrCount;// 数据个数
    
    BOOL  isEdit;// 是否编辑
    
    NSInteger  deleteRow;//  删除的row
    NSInteger nowSelectRow;// 当前选择row
}

@property (nonatomic, assign) NSString    *winnerGoodsID;// 中奖商品id

@property (nonatomic, strong) UITableView       *addressTableView;//
@property (nonatomic, strong) NSMutableArray    *addressArr;// 地址数组(最多三个)
@property (nonatomic, strong) UIButton          *addBtn;// 添加
@property (nonatomic, strong) UILabel           *emarkLab;// 备注
@property (nonatomic, strong) UIView            *noArrView;// 没有数据
@property (nonatomic, strong) UIButton          *editBtn;// 编辑按钮
@property (nonatomic, assign) BOOL              isBuyIn;//购买时进入
@property (nonatomic) setAddressStyle       addressStyle;// 请求类型

@end
