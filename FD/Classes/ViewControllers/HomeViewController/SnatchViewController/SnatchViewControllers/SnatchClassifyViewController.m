//
//  MyConViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "SnatchClassifyViewController.h"
#import "SnatchClassifyNode.h"
#import "SnatchClassifyListViewController.h"
#import "WelfareClassifyListViewController.h"


#define CELL_HIGHT         50  // 底部高度

@interface SnatchClassifyViewController ()


@end

@implementation SnatchClassifyViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"分类浏览";
    if(_classifyStyle == ClassifyCountersign){
        self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
//        self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    }
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    
    _listDataArr = [NSMutableArray array];
    
    isLoading = NO;
    
    
    // 全部商品
    [self setTheBtn:CGRectMake(0, setHeight, iPhoneWidth, 66) btnTag:10001 imgStr:nil];
    [self setTheImg:CGRectMake(20, setHeight+10, 40,40) imgStr:@"Snatch_Home_Classify.png" bgColor:[UIColor clearColor]];
    [self setTheLab:CGRectMake(80, setHeight, iPhoneWidth - 80, 66) textColor:[UIColor blackColor] labText:@"全部商品" setFont:25];
    setHeight = setHeight + 60;
    
    //分类浏览
    UILabel *namelab = [[UILabel alloc] initWithFrame:CGRectMake(15, setHeight+10, iPhoneWidth, 20)];
    namelab.backgroundColor = [UIColor whiteColor];
    namelab.text = @"分类浏览";
    namelab.textColor = [UIColor blackColor];
    namelab.textAlignment = NSTextAlignmentLeft;
    namelab.font = defaultFontSize(20);
    namelab.alpha = 0.5;
    [self.view addSubview:namelab];
    setHeight = setHeight + 30;


    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.hasReloadView = YES;
//     _conTabView.canMove = YES;
    [self.view addSubview:_conTabView];
    _conTabView.canDelete = NO;
    _conTabView.table.showsVerticalScrollIndicator = NO;
    
  
    [self reqGetList];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

///TODO:设置按钮
- (void)setTheBtn:(CGRect )rect btnTag:(NSInteger )tag imgStr:(NSString *)name{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self.view addSubview:btn];
    
    
}

//TODO:设置图片
- (void)setTheImg:(CGRect )rect imgStr:(NSString *)name bgColor:(UIColor *)color{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    imgView.backgroundColor = color;
    [imgView setImage:[UIImage imageNamed:name]];
    [self.view addSubview:imgView];
}
//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  {
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    
    lab.font = [UIFont systemFontOfSize:font];
    [self.view addSubview:lab];
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    
    
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
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


#pragma mark -
#pragma mark ====== 列表 ======
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
    SnatchClassifyNode *lnode = [_listDataArr objectAtIndex:indexPath.section];
    if (self.classifyStyle == ClassifySnatch) {
        SnatchClassifyListViewController *listViewController = [[SnatchClassifyListViewController alloc] init];
        listViewController.getClassifyId = lnode.Cid;
        [self.navigationController pushViewController:listViewController animated:YES];
    }else{
       
        WelfareClassifyListViewController *welfareClassifyListViewController = [[WelfareClassifyListViewController alloc] init];
        welfareClassifyListViewController.listStyle = ClassifyListWelfare;
        welfareClassifyListViewController.getClassifyId = lnode.Cid;
        [self.navigationController pushViewController:welfareClassifyListViewController animated:YES];
    }

    
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
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    SnatchClassifyNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    cell.textLabel.text = hnode.name;
    cell.textLabel.textColor = UIColorWithRGB(91, 91, 91, 1);
    cell.textLabel.font = defaultFontSize(15);
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
    [cell addSubview:lineImgView];
     cell.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor whiteColor];
    
//    cell.homeNode = hnode;
    return cell;
    
}


//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)fhtable:(FHTableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //        [self reqDeleteBank:indexPath.row];
    }
}
- (void )isSurpassOriginY:(CGFloat )surpassOriginY{
    
}

//TODO:移动
- (void)isBeginMove:(BOOL)isMove{
    
}

//TODO:点击事件
- (void)toBtnPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 全部
        case 10001:
        {
            if (self.classifyStyle == ClassifySnatch) {
                SnatchClassifyListViewController *listViewController = [[SnatchClassifyListViewController alloc] init];
                listViewController.getClassifyId = @"0";
                [self.navigationController pushViewController:listViewController animated:YES];
            }else{
                
                WelfareClassifyListViewController *welfareClassifyListViewController = [[WelfareClassifyListViewController alloc] init];
                welfareClassifyListViewController.listStyle = ClassifyListWelfare;
                welfareClassifyListViewController.getClassifyId = @"0";
                [self.navigationController pushViewController:welfareClassifyListViewController animated:YES];
            }
            
 
        }
            break;
        default:
            break;
    }
    
    
    
}

#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 网络请求
//TODO:获取列表
- (void)reqGetList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CLASSIFY] forKey:REQ_CODE];

    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}


#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
        switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
                // 列表
            case REQ_SNATCH_CLASSIFY:
            {
                _listDataArr = [resultDict objectForKey:RESP_CONTENT];
                _conTabView.dataArray = _listDataArr;
                [_conTabView.table reloadData];
            }
                break;
    
            default:
                break;
        }
    
}


// 网络回调失败
- (void)requestFailed:(NSDictionary *)errorDict
{
    [self.progressView hide:YES];
    NSString *msg = [errorDict objectForKey:RESP_MSG];
    if([ShareDataManager getText:msg]){
        msg = @"请求出错";
    }
    
        switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
                // 列表
            case REQ_SNATCH_CLASSIFY:        {

                
            }
                break;
            default:
                break;
        }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
@end
