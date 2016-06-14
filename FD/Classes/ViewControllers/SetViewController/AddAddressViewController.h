//
//  AddAddressViewController.h
//  FD
//
//  Created by Leo xu on 14-10-21.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CustomTextField.h"
#import "SelectDataView.h"
#import "AddressNode.h"

@interface AddAddressViewController : BaseViewController<UITextViewDelegate,UITextFieldDelegate,SelectDataViewDelegate>
{
    float   setHight;// 设置高度
    float   moreHigh;//移动的高度
    BOOL    isMore;// 是否移动
    
    BOOL isdef;

}
@property (nonatomic, strong) CustomTextField   *nameTextField;// 收获人姓名
@property (nonatomic, strong) CustomTextField   *phoneTextField;// 收货人联系方式
@property (nonatomic, strong) CustomTextField    *betterAddressTextField;// 详细地址

@property (nonatomic, strong) UILabel       *addressLab;// 选择后的地址
@property (nonatomic, strong) NSString       *cidyID;// 选择后的地址id
//@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@property (strong, nonatomic) UIButton      *areaBtn;// 选择地区

@property (strong, nonatomic) NSString      *areaValue;
@property (assign, nonatomic) BOOL           isEdit;// 编辑
@property (nonatomic, strong) SelectDataView   *addressView;// 选择地址

@property (nonatomic, assign) BOOL   isAdd;// 选择新增地址
@property (nonatomic, strong) UISwitch      *defSwitch;// 选择是否默认
@property (nonatomic, strong) AddressNode      *addressNode;// 收货地址node


@end
