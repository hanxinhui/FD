//
//  MyFavViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:生成口令

#import <UIKit/UIKit.h>
#import "BaseViewController.h"



@interface KLCreateViewController : BaseViewController
{
    float setHeight;//设置高度
    float fsetHeight;//设置截屏起始高度
   
    float setJPX;//设置截屏x轴
    float setJPY;//设置截屏y轴
    float setJPW;//设置截屏宽度
    float setJPH;//设置截屏高度
    
}
@property (nonatomic, strong) UIImageView   *mybgImgView;//我的背景
@property (nonatomic, strong) UILabel *codeLab;// 口令
@property (nonatomic, strong) UIImageView *goodImgView;// 商品img
@property (nonatomic, strong) UILabel *goodsLab;// 商品名称
@property (nonatomic, strong) UILabel *goodsubLab;// 商品副标题

@property (nonatomic, strong) UIImageView   *screenshotImgView;//截图
@property (nonatomic, strong) NSDictionary   *codeDict;// 数据字典

@end

