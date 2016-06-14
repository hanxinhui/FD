//
//  PropertyDetailViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:资产详情

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PropertyListNode.h"



@interface PropertyDetailViewController : BaseViewController
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) UILabel   *numLab;// 账号

@property (nonatomic, strong) UILabel   *comLab;// 备注

@property (nonatomic, strong) UILabel   *moneyLab;// 金额

@property (nonatomic, strong) UILabel   *timeLab;// 时间
@property (nonatomic, strong) PropertyListNode   *pnode;// 数据

@end

