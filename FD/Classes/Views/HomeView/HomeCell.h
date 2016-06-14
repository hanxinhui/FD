//
//  HomeCell.h
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNode.h"
#import "VICMAImageView.h"

@interface HomeCell : UITableViewCell{

}


@property (nonatomic , strong) HomeNode *homeNode;// 数据
@property (nonatomic , strong) VICMAImageView *VICimgView;// 图片
@property (nonatomic , strong) UIImageView  *imgView;// 图片
@property (nonatomic , assign) BOOL     canAim;// 可以动画


@end


