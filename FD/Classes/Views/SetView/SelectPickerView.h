//
//  SelectPickerView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PickerWithSex,// 性别
    PickerWithIncome, // 月收入
    PickerWithDraw // 月收入
} ModifyPickerStyle;

@protocol SelectPickerViewDelegate <NSObject>
- (void)cancelSelectDataView;//取消选择
- (void)sureSelectStyle:(ModifyPickerStyle )style dataStr:(NSString *)str;// 确定传入
@end

@interface SelectPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    
}

@property (nonatomic, assign) id<SelectPickerViewDelegate>          delegate;//
@property (strong, nonatomic) NSMutableArray    *dataArr;// 传人数据
@property (strong, nonatomic) UIPickerView      *selectPicker;
@property (strong, nonatomic) NSString          *selectData;// 选中的数据
@property (nonatomic) ModifyPickerStyle pickerStyle;

- (void)showInView:(UIView *)view;
- (void)cancelPicker;
@end
