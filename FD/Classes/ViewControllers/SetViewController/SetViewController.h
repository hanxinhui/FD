//
//  SetViewController.h
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

//TODO:设置

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface SetViewController : BaseViewController<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic , strong) UIScrollView     *mainScrollView;//
@property (nonatomic , strong) UIImageView      *headImageView;//头像
@property (nonatomic , strong) UILabel          *nameLab;//

@end

