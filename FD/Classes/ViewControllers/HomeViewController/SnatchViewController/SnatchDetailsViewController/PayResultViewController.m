//
//  PayResultViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "PayResultViewController.h"
#import "PayResultCell.h"
#import "SnatchPayNode.h"
#import "SnatchRecordListViewController.h"

#define CELL_HIGHT     90

@interface PayResultViewController ()


@end

@implementation PayResultViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"支付结果";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(243, 244, 245, 1);
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
- (void)setListDic:(NSDictionary *)listDic{
    _listDic = [NSDictionary dictionaryWithDictionary:listDic];
    _listDataArr = [NSMutableArray array];
    _listDataArr = [_listDic objectForKey:RESP_LIST];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
//    _listDataArr = [NSMutableArray array];
    
    // 初始化主界面table
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight )];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.backgroundColor = [UIColor clearColor];
    _conTabView.table.showsVerticalScrollIndicator = NO;
  
    _conTabView.dataArray = _listDataArr;
    
    PayResultHeadView *headView = [[PayResultHeadView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 180)];
    headView.backgroundColor = [UIColor clearColor];
    NSDictionary *detailDic = [_listDic objectForKey:@"detail"];
    NSString *jians = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"jianshu"]];
    NSString *renc = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"renci"]];

    headView.delegate = self;
    NSString *tStr;

    if ([jians integerValue] == 0) {
        tStr = @"本次抽疯您没有抢到任何宝贝，您支付的金额已放入您的爱葫芦账户";

    }else{
        tStr = [NSString stringWithFormat:@"您成功参与了%@件商品共%@人次夺宝,信息如下:",jians,renc];
        headView.footLab.text = tStr;
        headView.footLab.keyWord = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"jianshu"]];
        headView.footLab.keyWord = [NSString stringWithFormat:@"%@",[detailDic objectForKey:@"renci"]];
        headView.footLab.keyWordColor = UIColorWithRGB(237, 102, 26, 1);
    }


    _conTabView.table.tableHeaderView = headView;
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];

}

#pragma mark -
#pragma mark ======刷新或显示更多获取数据后手动调用完成函数======

-(void)doneLoadMoreTableViewData:(FHTableView *)table
{
    [table doneLoadMoreTableViewData];
}

-(void)doneLoadingTableViewData:(FHTableView *)table
{
    [table doneLoadingTableViewData];
    [table doneLoadMoreTableViewData];
}

//Section 段数
- (NSInteger)numberOfSectionsInTableView:(FHTableView *)ftableView
{
    
    return _listDataArr.count;
}
-(CGFloat)fhtable:(FHTableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSString *)fhtable:(FHTableView *)table titleForHeaderInSection:(NSInteger)section{
    
    return nil;
    
}
- (UIView *)fhtable:(FHTableView *)table viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath node:(id)node
{

    
}

-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HIGHT;
}
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PayResultCell";
    PayResultCell *cell = (PayResultCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[PayResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (_listDataArr.count == 0) {
        return cell;
        
    }
    //    [cell setNeedsUpdateConstraints];
    //    [cell updateConstraintsIfNeeded];
    SnatchPayNode *snode = [_listDataArr objectAtIndex:indexPath.section];
//    NSInteger tag = _listDataArr.count - indexPath.section - 1;
//    cell.titleLab.text = [_listDataArr objectAtIndex:tag];
    cell.snode = snode;
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT-1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//TODO:是否超过滑动高度 隐藏
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}
//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}
//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
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

#pragma mark -
#pragma mark ============ 响应事件 ============
//TODO:返回
- (void)backPressed{
//    [self.navigationController popViewControllerAnimated:YES];
    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
}

//TODO:继续夺宝
- (void)goonSnatchPressed{
    // 返回
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[ctrlArray objectAtIndex:ctrlArray.count - 3] animated:YES];
    
}

//TODO:查看夺宝记录
- (void)toSnatchRecordPressed{
    SnatchRecordListViewController *recode = [[SnatchRecordListViewController alloc]init];
    
    [self.navigationController pushViewController: recode animated:YES];
}


@end
