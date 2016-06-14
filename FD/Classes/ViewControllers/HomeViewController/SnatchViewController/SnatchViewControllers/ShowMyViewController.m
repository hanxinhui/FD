//
//  ShowMyViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "ShowMyViewController.h"
#import "ShowMeCell.h"
#import "ShowMeNode.h"


#define CELL_HIGHT         250  // 底部高度

@interface ShowMyViewController ()


@end

@implementation ShowMyViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    if ([_goodsid integerValue] == 0){
        self.titleLable.text = @"我的晒单";

    }else{
        self.titleLable.text = @"晒单";

    }
  
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    _listDataArr = [NSMutableArray array];
    _page = 1;
    //初始化列表
    _conTabView = [[FHTableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight)];
    _conTabView.delegate = self;
    _conTabView.canDelete = YES;
    _conTabView.hasReloadView = NO;
    [self.view addSubview:_conTabView];
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 100)/ 2,  (iPhoneHeight - 100 )/2 , 100, 100 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"Public_No_Data.png"]];
    
    _page = 1;
    
    [self reqShaiDan:_page];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}


//TODO:获取id
- (void)setGoodsid:(NSString *)goodsid{
    _goodsid = goodsid;
}

#pragma mark -
#pragma mark FHTable Delegate
-(void)reloadTableViewDataSource:(FHTableView *)table
{
    _isReLoad = YES;
    _page = 1;
    [self reqShaiDan:_page];
}
-(void)loadMoreTableViewDataSource:(FHTableView *)table
{
    _isReLoad = NO;
    _page = _page + 1;
    [self reqShaiDan:_page];
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
//    HomeNode *lnode = [_listDataArr objectAtIndex:indexPath.row];
//    DetailsViewController *detailsViewController = [[DetailsViewController alloc] init];
//    detailsViewController.detailID = lnode.Hid;
//    [self.navigationController pushViewController:detailsViewController animated:YES];
}

-(CGFloat)fhtable:(FHTableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float setCellHeight = 180;
    ShowMeNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    CGSize detailSize = [self labelAutoCalculateRectWith:hnode.subject FontSize:13 MaxSize:CGSizeMake(iPhoneWidth -130, MAXFLOAT)];
    if (detailSize.height < 60) {
        setCellHeight = setCellHeight + detailSize.height ;
 
    }else{
        setCellHeight = setCellHeight + 60;

    }
    // 是否有图片
    if ([hnode.src isEqualToString:@""] || hnode.src == nil || hnode.src.length == 0) {
        setCellHeight = setCellHeight;

    }else{
    
        setCellHeight = setCellHeight + 60;
    }
    
    return setCellHeight;
}
-(NSInteger)fhtable:(FHTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)fhtable:(FHTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ShowMeCell";
    ShowMeCell *cell = (ShowMeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[ShowMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    ShowMeNode *hnode =  [_listDataArr objectAtIndex:indexPath.section];
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(218, 218, 218, 1);
//    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.snode = hnode;
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
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 网络请求
//TODO:获取晒单列表
- (void)reqShaiDan:(NSInteger)page{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_SHAIDAN_LIST] forKey:REQ_CODE];
    [dict setObject:_goodsid forKey:@"gid"];
    [dict setObject:[NSString stringWithFormat:@"%d",_page] forKey:@"p"];

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
            case REQ_SNATCH_SHAIDAN_LIST:
            {
                NSInteger pages = [[resultDict objectForKey:RESP_PAGENUM] integerValue];//获得页数
                NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
                if (arr.count == 0){
                    _noImgView.hidden = NO;
                    _conTabView.hidden = YES;
                    
                    //                isHaveData = NO;
                }else{
                    _noImgView.hidden = YES;
                    //                isHaveData = YES;
                    _conTabView.hidden = NO;
                }
                if (_page == 1) {
                    
                    [self.listDataArr removeAllObjects];
                    self.listDataArr = [NSMutableArray arrayWithArray:arr];
                    [_conTabView.table scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
                    
                }else{
                    
                    [self.listDataArr addObjectsFromArray:[resultDict objectForKey:RESP_CONTENT]];
                    
                    
                }
                [self.conTabView doneLoadingTableViewData];
                _conTabView.dataArray = self.listDataArr;
                [_conTabView.table reloadData];
                
                if (pages > _page) {
                    _conTabView.hasMoreData  = YES;
                    [self doneLoadMoreTableViewData:_conTabView];
                    
                }else{
                    _conTabView.hasMoreData  = NO;
                    
                }
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
            case REQ_SNATCH_SHAIDAN_LIST:        {
                [self.conTabView doneLoadingTableViewData];
                
            }
                break;
            default:
                break;
        }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}
@end
