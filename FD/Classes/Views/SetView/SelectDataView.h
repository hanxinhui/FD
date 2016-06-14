//
//  SelectDataView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

typedef enum {
    PickerWithCity,// 只选到城市
    PickerWithCityArea // 全选
} SelectPickerStyle;

@protocol SelectDataViewDelegate <NSObject>

- (void)cancelDataView;//取消选择
- (void)sureData:(NSString *)dataS dataID:(NSString *)ddID;// 确定传入地址
@end

@interface SelectDataView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{

  
}

@property (nonatomic, assign) id<SelectDataViewDelegate>          delegate;//
@property (strong, nonatomic) UIPickerView *locatePicker;
@property (strong, nonatomic) HZLocation *locate;
@property (nonatomic, strong)  NSString *dataStr;
@property (nonatomic, strong)  NSString *provinceStr;
@property (nonatomic, strong)  NSString *cityStr;
@property (nonatomic, strong)  NSString *dataIDStr;
@property (nonatomic)  SelectPickerStyle pickerStyle;

- (void)showInView:(UIView *)view;
- (void)cancelPicker;


@end
