//
//  GroupGetViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:群抢宝

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"
#import "SnatchHomeListNode.h"


@interface GroupGetViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate>
{
    float setHeight;//设置高度
    BOOL  isCanSet;// 可以生成
    
    BOOL isFirst;// 第一次进入
}

@property (nonatomic, strong) UILabel       *goodsNameLab;// 商品名称
@property (nonatomic, strong) UITextView    *showTextView;// 说明
@property (nonatomic, strong) UILabel       *moneyLab;// 说明
@property (nonatomic, strong) SnatchHomeListNode       *listNode;// 说明
@property (nonatomic, strong) NSMutableDictionary       *goodDiC;// 商品数据
@property (nonatomic, strong) NSMutableDictionary       *codeDiC;// 口令数据

@end

