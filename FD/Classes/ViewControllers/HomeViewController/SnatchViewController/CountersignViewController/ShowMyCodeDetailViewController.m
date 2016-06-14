//
//  ShowMyCodeDetailViewController.m
//  FD
//
//  Created by Leoxu on 16-1-20.
//  Copyright (c) 2016年 Leo xu. All rights reserved.
//

#import "ShowMyCodeDetailViewController.h"


@interface ShowMyCodeDetailViewController ()


@end

@implementation ShowMyCodeDetailViewController




//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"抢宝详情";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.dlineImgView.hidden = YES;
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
}

//TODO:传入数据
- (void)setCellNode:(MyBagDetailListNode *)cellNode{
    _cellNode = cellNode;
    
}

//TODO:传入总人次
- (void)setAllNum:(NSString *)allNum{
    _allNum = allNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = UIColorWithRGB(241, 241, 241, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    // 主界面
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置indicator风格
    _mainScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.view addSubview:_mainScrollView];
    setHeight = 0;
    // 发起人
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 50) bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(10, setHeight, 80, 50) textColor:[UIColor blackColor] labText:@"发起人:" setFont:14 setRight:NO];
    [self setTheLab:CGRectMake(70, setHeight, iPhoneWidth - 80, 50) textColor:[UIColor blackColor] labText:_cellNode.nickname setFont:14 setRight:NO];
    setHeight = setHeight + 50;
    
     //总人次
    [self setTheLab:CGRectMake(10, setHeight, 80, 50) textColor:[UIColor blackColor] labText:@"总人次:" setFont:14 setRight:NO];
    [self setTheLab:CGRectMake(70, setHeight, iPhoneWidth - 80, 50) textColor:[UIColor blackColor] labText:[NSString stringWithFormat:@"%@人次",_allNum] setFont:14 setRight:NO];

    setHeight = setHeight + 50;
    
    // 抢宝时间
    [self setTheImg:CGRectMake(0, setHeight, iPhoneWidth, 50) bgColor:[UIColor whiteColor]];
    [self setTheLab:CGRectMake(10, setHeight, 90, 50) textColor:[UIColor blackColor] labText:@"抢宝时间:" setFont:14 setRight:NO];
    [self setTheLab:CGRectMake(100, setHeight, iPhoneWidth - 110, 50) textColor:[UIColor blackColor] labText:_cellNode.time setFont:14 setRight:YES];
    setHeight = setHeight + 50;
    
    // 本次参与人次
    [self setTheLab:CGRectMake(10, setHeight, 120, 50) textColor:[UIColor blackColor] labText:@"本次参与人次:" setFont:14 setRight:NO];
    [self setTheLab:CGRectMake(130, setHeight, iPhoneWidth - 140, 50) textColor:[UIColor blackColor] labText:[NSString stringWithFormat:@"%@人次",_cellNode.count] setFont:14 setRight:YES];
    setHeight = setHeight + 50;
    
    // 抢宝号码
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, 50)];
    imgView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:imgView];
    
    [self setTheLab:CGRectMake(10, setHeight, 100, 50) textColor:[UIColor blackColor] labText:@"抢宝号码:" setFont:14 setRight:NO];

    UILabel *codeLab = [[UILabel alloc] initWithFrame:CGRectMake(85, setHeight, iPhoneWidth - 95, 50)];
    codeLab.backgroundColor = [UIColor clearColor];
    codeLab.text = _cellNode.code;
    codeLab.text = @"12345678,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011,12312312,10000011";
    codeLab.textColor = [UIColor blackColor];
    codeLab.textAlignment = NSTextAlignmentLeft;
    codeLab.font = [UIFont systemFontOfSize:11];
    codeLab.numberOfLines = 0;
    [_mainScrollView addSubview:codeLab];
    float setHi = 50;
    CGSize detailSize = [self labelAutoCalculateRectWith:codeLab.text FontSize:11 MaxSize:CGSizeMake(iPhoneWidth - 95, MAXFLOAT)];
    if (detailSize.height > 50){
        setHi = detailSize.height;
    }
    imgView.frame = CGRectMake(0, setHeight, iPhoneWidth, setHi + 4);
    codeLab.frame = CGRectMake(85, setHeight + 2, iPhoneWidth-95, setHi);
  
        
    _mainScrollView.contentSize = CGSizeMake(iPhoneWidth, setHeight + setHi + 4);

}

//TODO:计算字符串高度
- (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    //    [paragraphStyle release];
    
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    
    return labelSize;
    
}


//TODO:设置图片
- (void)setTheImg:(CGRect )rect bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [_mainScrollView addSubview:imgView];
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setRight:(BOOL )right{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (right) {
        lab.textAlignment = NSTextAlignmentRight;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [_mainScrollView addSubview:lab];
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}




@end



