//
//  KLGetCodeViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:领取抽奖码

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface KLGetCodeViewController : BaseViewController
{
    float setHeight;//设置高度
   
    NSInteger selectCand;// 选择分类
}

@property (nonatomic, strong) NSString   *codeStr;// 口令号
@property (nonatomic, strong) UIImageView *headImgView;// 头像
@property (nonatomic, strong) UILabel   *phoneLab;// 手机号码
@property (nonatomic, strong) UILabel   *conLab;// 说明
@property (nonatomic, strong) UIImageView *goodsImgView;// 商品头像
@property (nonatomic, strong) UILabel   *goodsLab;// 商品说明
@property (nonatomic, strong) UILabel   *goodsfLab;// 商品说明
@property (nonatomic, strong) UIButton   *getCodebtn;// 显示列表
@property (nonatomic, strong) NSDictionary   *infoDict;// 数据字典
@property (nonatomic, strong) NSDictionary   *codeinfoDict;// 数据字典
@property (nonatomic, assign) BOOL      isFull;// 是否已满


@end

