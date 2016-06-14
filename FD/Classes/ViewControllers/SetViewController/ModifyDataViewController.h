//
//  ModifyDataViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:修改资料

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectDataView.h"
#import "SelectBrithView.h"
#import "SelectPickerView.h"

typedef enum {
    ModifyWithSex,// 性别
    ModifyWithBrith, // 生日
    ModifyWithAddress, // 地址
    ModifyWithIncome // 月收入
} HttpModifyDataStyle;

@interface ModifyDataViewController : BaseViewController<SelectDataViewDelegate,SelectBrithViewDelegate,SelectPickerViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) UILabel  *nikeLab;// 昵称
@property (nonatomic, strong) UILabel  *sexLab;// 性别
@property (nonatomic, strong) UILabel  *realNameLab;// 真实姓名
@property (nonatomic, strong) UILabel  *brithLab;// 生日
@property (nonatomic, strong) UILabel  *cityLab;// 所在省市
@property (nonatomic, strong) NSString  *cidyID;// 所在城市id
@property (nonatomic, strong) UILabel  *incomeLab;// 月收入
@property (nonatomic, strong) UILabel  *hobbyLab;// 兴趣爱好

@property (nonatomic, strong) SelectBrithView   *brithView;// 选择日期
@property (nonatomic, strong) SelectDataView   *dataView;// 选择地址
@property (nonatomic, strong) SelectPickerView   *selectPickerView;// 选择性别或月收入
@property (nonatomic) HttpModifyDataStyle       dataStyle;// 请求类型



@end

