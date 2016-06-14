//
//  ShoppingCartViewController.m
//  MetroPay
//
//  Created by Leoxu on 13-5-14.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//


#import "ShoppingCartViewController.h"
#import "ShopCartNode.h"
#import "ShopCartCell.h"
#import "SnatchPayViewController.h"

// 正文 1 商品标题
#define COLOR_CONTENT           [UIColor colorWithRed:52.0/255.0f green:52.0/255.0f blue:52.0/255.0f alpha:1.0]
// 价格
#define COLOR_PRICE             [UIColor colorWithRed:236.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0]
// 单价
#define COLOR_DJ             [UIColor colorWithRed:117.0/255.0f green:117.0/255.0f blue:117.0/255.0f alpha:1.0]

#define CELL_HIGHT 140

@interface Item : NSObject

@property (retain, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation Item

@end

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 初始化
//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"购物车";
    
    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = backBtn;
    
    //编辑
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 50, 50);
    editBtn.backgroundColor = [UIColor clearColor];
    [editBtn addTarget:self action:@selector(tableViewEdit) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = editBtn;
    [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    self.rightBtn.titleLabel.textColor = UIColorWithRGB(252, 81, 0, 1);
    [self.rightBtn setTitleColor: UIColorWithRGB(204, 35, 67, 0.8) forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    isEdit = NO;
    isAllSelect = NO;
    _contacts = [NSMutableArray array];
    _listArr = [NSMutableArray array];
    
    //初始化界面
    _myTadleView = [[UITableView alloc] initWithFrame:CGRectMake(0, setHeight, iPhoneWidth, iPhoneHeight - setHeight - 50)];
    _myTadleView.backgroundColor = [UIColor clearColor];
    _myTadleView.delegate = self;
    _myTadleView.dataSource = self;
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    backView.backgroundColor = [UIColor clearColor];
    _myTadleView.tableFooterView = backView;

   
    [self.view addSubview:_myTadleView];
//    _myTadleView
    // 设置tableView可删除
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, iPhoneHeight-61, iPhoneWidth, 1)];
    imageView.backgroundColor = UIColorWithRGB(231, 232, 232, 1);
    [self.view addSubview:imageView];
    
    
    // 底部界面
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, iPhoneHeight - 60, iPhoneWidth, 90)];
    _footView.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [self.view addSubview:_footView];
    
    // 全选
    _allSelectBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10  , 30, 30 )];
    _allSelectBtn.backgroundColor = [UIColor clearColor];
    [_allSelectBtn addTarget:self action:@selector(setAllSelectPressed) forControlEvents:UIControlEventTouchUpInside];
    [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];
    [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"] forState:UIControlStateSelected];
    [_footView addSubview:_allSelectBtn];
    _allSelectBtn.hidden = YES;
    
    // 展示数据
    _showNLab = [[UILabel alloc] initWithFrame:CGRectMake(10, -10, 130, 50)];
    _showNLab.backgroundColor = [UIColor clearColor];
    _showNLab.textColor = [UIColor grayColor];
    _showNLab.textAlignment = NSTextAlignmentLeft;
    _showNLab.font = defaultFontSize(15);
    [_footView addSubview:_showNLab];
    
    // 总计
    _showAPLab = [[UILabel alloc] initWithFrame:CGRectMake(120,-10, 120, 50)];
    _showAPLab.backgroundColor = [UIColor clearColor];
     _showAPLab.textColor = UIColorWithRGB(204, 35, 67, 1);
    _showAPLab.textAlignment = NSTextAlignmentLeft;
    _showAPLab.font = defaultFontSize(15);
    [_footView addSubview:_showAPLab];
    
    _conLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 30)];
    _conLab.text = @"夺宝有风险，参与需谨慎";
    _conLab.textColor = UIColorWithRGB(146, 147, 148, 1);
    _conLab.font = [UIFont systemFontOfSize:13];
    [_footView addSubview:_conLab];
    

    
    // 显示全选
    _showASLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 120, 25)];
    _showASLab.backgroundColor = [UIColor clearColor];
    _showASLab.textColor = [UIColor grayColor];
    _showASLab.textAlignment = NSTextAlignmentLeft;
    _showASLab.font = defaultFontSize(15);
    _showASLab.text = @"全选";
    [_footView addSubview:_showASLab];
    _showASLab.hidden = YES;
    
    // 显示选择个数
    _showSNLab = [[UILabel alloc] initWithFrame:CGRectMake(50,25, 120, 25)];
    _showSNLab.backgroundColor = [UIColor clearColor];
    _showSNLab.textColor = [UIColor grayColor];
    _showSNLab.textAlignment = NSTextAlignmentLeft;
    _showSNLab.font = defaultFontSize(15);
//    _showSNLab.text = @"共选中0件奖品";
    [_footView addSubview:_showSNLab];
    _showSNLab.hidden = YES;
    
    // 结算
    _payBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 100, 10  , 90, 35 )];
    [_payBtn setTitle:@"结算" forState:UIControlStateNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ _payBtn.layer setMasksToBounds:YES];
    [ _payBtn.layer setCornerRadius:5.0];
    [ _payBtn.layer setBackgroundColor: UIColorWithRGB(204, 35, 67, 1).CGColor];
    [_payBtn addTarget:self action:@selector(payPressed) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_payBtn];

//    [_payBtn setImage:[UIImage imageNamed:@"ShoppingCart_PayBtn.png"] forState:UIControlStateNormal];
    [self reqHttpCartList];// 请求数据
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.exclusiveTouch = YES;
        }
    }
    
    _noImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth- 85)/ 2,  (iPhoneHeight - 77 )/2 , 85, 77 )];
    _noImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noImgView];
    _noImgView.hidden = YES;
    [_noImgView setImage:[UIImage imageNamed:@"cart_empty.png"]];
    
    _noDataLab = [[UILabel alloc] initWithFrame:CGRectMake((iPhoneWidth- 185)/ 2, (iPhoneHeight - 77 )/2 + 85, 185, 30)];
    _noDataLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noDataLab];
    _noDataLab.text = @"您的清单空空如也!";
    _noDataLab.textColor = [UIColor lightGrayColor];
    _noDataLab.textAlignment = NSTextAlignmentCenter;
    _noDataLab.font = defaultFontSize(18);
    _noDataLab.hidden = YES;
    
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"ShopCartCell";
    
   ShopCartCell *cell = (ShopCartCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    cell = [[ShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
   
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
  
    ShopCartNode *cartNode = [self.listArr objectAtIndex:indexPath.row];
    cell.node = cartNode;
    NSLog(@"indexPath.row is %ld",(long)indexPath.row);
    cell.lessBtn.tag = indexPath.row;
    cell.addBtn.tag = indexPath.row;
    cell.secBtn.tag = indexPath.row;
    
    
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [_contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    
    UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 1, iPhoneWidth, 1)];
    lineImgView.backgroundColor = UIColorWithRGB(231, 232, 232, 1);
    [cell addSubview:lineImgView];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
 
  
  }

#pragma mark - 代理方法
#pragma mark 设置Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    
 
}


#pragma mark 决定tableview的编辑模式
// 是否需要删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewCellEditingStyleDelete;

    
}

#pragma mark - 公共方法
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TOOD:编辑
- (void)tableViewEdit{
    if (_listArr.count == 0 && !isEdit){
        [self showProgressWithString:@"暂无奖品" hiddenAfterDelay:1];
        return;
    }
    isEdit = !isEdit;

    
    if (isEdit) {
        [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        _allSelectBtn.hidden = NO;
       
        _showSNLab.hidden = NO;
        _showASLab.hidden = NO;
        _showNLab.hidden = YES;
        _showAPLab.hidden = YES;
        _conLab.hidden = YES;
        [_payBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_payBtn setTitleColor: UIColorWithRGB(204, 35, 67, 1)forState:UIControlStateNormal];
        [ _payBtn.layer setMasksToBounds:YES];
        [ _payBtn.layer setCornerRadius:5.0];
        [_payBtn.layer setBorderWidth:1.0f];
        [ _payBtn.layer setBorderColor: UIColorWithRGB(204, 35, 67, 1).CGColor];
        [_payBtn.layer setBackgroundColor:[UIColor whiteColor].CGColor];
        [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];


//         [_payBtn setImage:[UIImage imageNamed:@"ShoppingCart_DeleteBtn.png"] forState:UIControlStateNormal];
        
    }else{
        [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
       isAllSelect = NO;
        [self allSelect:isAllSelect];
        _allSelectBtn.hidden = YES;
        _showSNLab.hidden = YES;
        _showASLab.hidden = YES;
        _showNLab.hidden = NO;
        _showAPLab.hidden = NO;
        _conLab.hidden = NO;
        [_payBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [ _payBtn.layer setMasksToBounds:YES];
        [ _payBtn.layer setCornerRadius:5.0];
        [ _payBtn.layer setBackgroundColor: UIColorWithRGB(204, 35, 67, 1).CGColor];

       
//        [_payBtn setImage:[UIImage imageNamed:@"ShoppingCart_PayBtn.png"] forState:UIControlStateNormal];
    }

   [_myTadleView setEditing:isEdit animated:YES];// 动画效果
    
    [_myTadleView reloadData];
}

//TODO:选择
- (void)getchecheerPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
    ShopCartCell *cell = [self.myTadleView cellForRowAtIndexPath:indexPath];
    NSMutableDictionary *dic = [_contacts objectAtIndex:tag];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {

        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        
        [cell setChecked:NO];
        isAllSelect = NO;
        [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];

    }
}

//TODO:全选
- (void)setAllSelectPressed{
    isAllSelect = !isAllSelect;
    if (isAllSelect) {
        [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"] forState:UIControlStateNormal];

    }else{
        
        [_allSelectBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];

    }
    
    [self allSelect:isAllSelect];
    
    [self.myTadleView reloadData];
}

//TODO:全选OR全不选
- (void)allSelect:(BOOL )isS{
    
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_myTadleView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        ShopCartCell *cell = (ShopCartCell*)[_myTadleView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];

        NSMutableDictionary *dic = [_contacts objectAtIndex:row];
        if (isS) {
            [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    if (isS){
        for (NSDictionary *dic in _contacts) {
            [dic setValue:@"YES" forKey:@"checked"];
            
        }
    }else{
        for (NSDictionary *dic in _contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
    }
}

//TODO:弹出提示
- (void)showAlertMsgPressed:(NSString *)msg{
    [self showProgressWithString:msg hiddenAfterDelay:1];
 
}

//TODO:网络请求 列表数据
- (void)reqHttpCartList{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_LIST] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:减少购物车请求
- (void)lessGoodsPressed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    ShopCartNode *cartNode = [self.listArr objectAtIndex:tag];
    NSInteger count = [cartNode.count integerValue] - [cartNode.step integerValue];
    if (count > 0) {
        getGcount = count;
        selectRow = tag;
        [self addCartReq:count setGid:cartNode.gid];
    }else{
        [self showProgressWithString:@"已经是最小数量" hiddenAfterDelay:1];
    }
}

//TODO:加入购物车请求
- (void)addGoodsPressed:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    ShopCartNode *cartNode = [self.listArr objectAtIndex:tag];
    NSInteger count = [cartNode.count integerValue] + [cartNode.step integerValue];
   
    getGcount = count;
    selectRow = tag;
    
    [self addCartReq:count setGid:cartNode.gid];
    

}

//TODO:网络请求增减数据
- (void)addCartReq:(NSInteger )count setGid:(NSString *)gid{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_ADD] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:gid forKey:@"gid"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"count"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
}

//TODO:删除单个请求
- (void)deleteReq:(NSInteger )row{
    
    deleteRow = row;
    ShopCartNode *cartNode = [self.listArr objectAtIndex:deleteRow];
 
    [self.listArr removeObjectAtIndex:deleteRow];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:deleteRow inSection:0];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [_myTadleView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_LESS] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:cartNode.gid forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
   


    [_myTadleView reloadData];
}

//TODO:删除多个请求
- (void)deleteMoreReq{
    NSMutableString *deleteArrStr ;
    deleteArrStr = [NSMutableString stringWithCapacity:400];
    
    for (int i = 0 ; i < _contacts.count; i++) {
        NSMutableDictionary *dic = [_contacts objectAtIndex:i];

        BOOL checked = [[dic objectForKey:@"checked"] boolValue];
        if (checked) {
            ShopCartNode *cartNode = [self.listArr objectAtIndex:i];
            NSString *str = [NSString stringWithFormat:@",%@",cartNode.Sid];
            [deleteArrStr appendString:str];
        }
    }
     NSString *deleStr = [deleteArrStr substringFromIndex:1];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_CART_LESS] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:deleStr forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    [self.progressView show:YES];
    
    [_myTadleView reloadData];
}

//TODO:结算 || 删除
- (void)payPressed{
    if (isEdit){
        // 删除
        [self deleteMoreReq];
       
    }else{
        NSMutableDictionary *goodDict = [NSMutableDictionary dictionary];
        
        [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
        NSMutableString *gidArrStr ;
        NSMutableString *countArrStr ;
        gidArrStr = [NSMutableString stringWithCapacity:400];
        countArrStr = [NSMutableString stringWithCapacity:400];
        NSInteger pice = 0;
        for (int i = 0 ; i < _listArr.count; i++) {
            
            ShopCartNode *cartNode = [self.listArr objectAtIndex:i];
            NSString *str = [NSString stringWithFormat:@",%@",cartNode.gid];
            [gidArrStr appendString:str];
            
            NSString *costr = [NSString stringWithFormat:@",%@",cartNode.count];
            pice = [cartNode.count integerValue] + pice;
            [countArrStr appendString:costr];
        }
        NSString *gidStr = [gidArrStr substringFromIndex:1];
        NSString *countStr = [countArrStr substringFromIndex:1];
        [goodDict setObject:gidStr forKey:@"gid"];
        
        //            [_goodDiC setObject:_moneyLab.text forKey:@"pice"];
        [goodDict setObject:countStr forKey:@"count"];
        [goodDict setObject:[NSString stringWithFormat:@"%ld",(long)pice * 100] forKey:@"pice"];
        
        SnatchPayViewController *snatchPayViewController = [[SnatchPayViewController alloc] init];
        snatchPayViewController.payStyle = publicPayStyle;
        snatchPayViewController.payDict = goodDict;
        [self.navigationController pushViewController:snatchPayViewController animated:YES];

    }
    
}

#pragma mark -
#pragma mark ===============网络回调 - ================
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 列表
        case REQ_SNATCH_CART_LIST:
        {
            _listArr = [resultDict objectForKey:RESP_CONTENT];
            if (_listArr.count == 0 && isEdit) {
                [self tableViewEdit];
            }
            if (_contacts)
            {
                [_contacts removeAllObjects];
            }
            for (int i = 0; i <_listArr.count; i++) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:@"NO" forKey:@"checked"];
                [_contacts addObject:dic];
            }
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            if (arr.count == 0){
                _noImgView.hidden = NO;
                _noDataLab.hidden = NO;
            
            }else{
                _noImgView.hidden = YES;
                _noDataLab.hidden = YES;

            }
            
            
            _showNLab.text = [NSString stringWithFormat:@"共%lu件奖品,总计:",(unsigned long)_listArr.count];
            NSInteger pice = 0;
            for (ShopCartNode *node in _listArr) {
                pice = pice + [node.count integerValue];
                
                 _showSNLab.text = [NSString stringWithFormat:@"共选中%@件奖品",node.luck_code];
            }
           _showNLab.text = [NSString stringWithFormat:@"共%lu件奖品,总计:",(unsigned long)_listArr.count];
            _showAPLab.text = [NSString stringWithFormat:@"%ld 元",(long)pice];
          

//            _myTadleView.dataSource = self.listArr;
            [_myTadleView reloadData];
        
            
        }
            break;
            // 添加成功
        case REQ_SNATCH_CART_ADD:{
//            [self showProgressWithString:@"添加购物车成功" hiddenAfterDelay:1];
            [self reqHttpCartList];
        }
            break;
            // 删除成功
        case REQ_SNATCH_CART_LESS:{
            [self showProgressWithString:@"删除成功" hiddenAfterDelay:1];
          
            [self reqHttpCartList];

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

            // 首页列表
        case REQ_SNATCH_CART_LIST:           // 添加成功
        case REQ_SNATCH_CART_ADD:
        case REQ_SNATCH_CART_LESS:{
            
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];
    
}

@end