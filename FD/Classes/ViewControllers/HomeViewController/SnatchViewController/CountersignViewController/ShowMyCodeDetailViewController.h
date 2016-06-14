//
//  ShowMyCodeDetailViewController.h
//  FD
//
//  Created by Leoxu on 16-1-20.
//  Copyright (c) 2016年 Leo xu. All rights reserved.
//

//TODO:我的抢宝参与号码详情

#import "FontDefine.h"
#import "BaseViewController.h"
#import "MyBagDetailListNode.h"

@interface ShowMyCodeDetailViewController : BaseViewController<UIScrollViewDelegate>
{
    float setHeight;//设置高度
   
}

@property (nonatomic, strong) MyBagDetailListNode  *cellNode;
@property (nonatomic, strong) NSString      *allNum;// 总人次
@property (nonatomic, strong) UIScrollView      *mainScrollView;// 主界面

@end

