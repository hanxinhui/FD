//
//  GoodsDetilView.h
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailNode.h"
#import "SkuBtnScrollView.h"
#import "CustomTextField.h"
@protocol GoodsDetilViewDelegate <NSObject>
- (void)cancelBuyView;//取消
- (void)sureBuyView;// 确定
- (void)toAddressView;// 进入地址界面
- (void)selectSku:(NSInteger )sku;// 传入属性id
@end

@interface GoodsDetilView : UIView<SkuBtnScrollViewDelegate,UITextFieldDelegate>
{
    
    
}
@property (nonatomic, assign) id<GoodsDetilViewDelegate>          delegate;//

@property (nonatomic, strong) GoodsDetailNode *dnode;// 数据
@property (nonatomic, strong) UILabel   *addressLab;// 地址
@property (nonatomic, strong) UILabel   *piceLab;// 兑换价格
@property (nonatomic, strong) UIButton   *addressBtn;// 地址
@property (nonatomic, strong) SkuBtnScrollView *btnScrollView;
@property (nonatomic, strong) CustomTextField   *pTextField;
@property (nonatomic, assign) BOOL   isShowKeyP;// 是否显示键盘

- (void)showInView:(UIView *)view;
- (void)cancelPicker;

@end
