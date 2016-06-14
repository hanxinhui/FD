//
//  AddressViewController.m
//  FD
//
//  Created by Leo xu on 14-10-21.
//  Copyright (c) 2014年 Leo xu. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "SystemStateManager.h"

#define CELL_HIGHT      130   //cell的高度


@interface AddressViewController ()


@end

@implementation AddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//TODO:传入中奖商品id
- (void)setWinnerGoodsID:(NSString *)winnerGoodsID{
    _winnerGoodsID = winnerGoodsID;
}
#pragma mark -
#pragma mark ============ 初始化 ============
-(void)initNavBar
{
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.titleLable.text = @"地址管理";
    
    self.titleLable.textColor = [UIColor blackColor];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, setHight, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back_B.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [UIColor clearColor];
    self.leftBtn = leftBtn;
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(0, 0, 50, 50);
    [_editBtn setImage:[UIImage imageNamed:@"universal_nav_left.png"] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    _editBtn.backgroundColor = [UIColor clearColor];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _editBtn.titleLabel.font = defaultFontSize(14);
    [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.rightBtn = _editBtn;
    
}

//TODO:是否购买进入
- (void)setIsBuyIn:(BOOL)isBuyIn{
    _isBuyIn = isBuyIn;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    setHight = IOS7?20:0;
    isEdit = NO;
    nowSelectRow = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSuccess) name:ADD_ADDRESS_SUCCESS object:nil];// 添加地址成功

    [self initNavBar];
    
    setHight = setHight + NVARBAR_HIGHT ;
    // 初始化数据
    _addressArr = [NSMutableArray array];

    // 没有数据显示
    _noArrView = [[UIView alloc] initWithFrame:CGRectMake(0, setHight, iPhoneWidth, 40)];
    _noArrView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_noArrView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, iPhoneWidth- 40, 40)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = @"您还没有收货地址，请添加!";
    lab.textColor = [UIColor blackColor];
    lab.font = defaultFontSize(13);
    [_noArrView addSubview:lab];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,  39, iPhoneWidth - 20, 1)];
    imgView.backgroundColor = [UIColor grayColor];
    [imgView setImage:[UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@""]]];
    [_noArrView addSubview:imgView];
    _noArrView.hidden = YES;

    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, setHight, iPhoneWidth, iPhoneHeight-setHight-40)];
    _addressTableView.backgroundColor = [UIColor clearColor];
//    [_addressTableView setEditing:YES animated:YES];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.separatorColor = UIColorWithRGB(239, 239, 244, 1);
    _addressTableView.showsVerticalScrollIndicator = NO;
//    _addressTableView.scrollsToTop = YES;

    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    footView.backgroundColor = [UIColor clearColor];
    _addressTableView.tableFooterView = footView;
    
//    self.addressTableView.editing = YES;
    [self.view addSubview:_addressTableView];

    if (_addressArr && _addressArr.count > 0) {
        float hgh = _addressArr.count * CELL_HIGHT;
        if (iPhoneHeight - _addressArr.count * CELL_HIGHT - setHight - 60 < 0) {
            hgh = iPhoneHeight - setHight - 40;
        }
        _addressTableView.frame = CGRectMake(0, setHight, iPhoneWidth,hgh);
        
    }else{
        _addressTableView.frame = CGRectMake(0, setHight, iPhoneWidth,  iPhoneHeight);
    }
    
    setHight = _addressTableView.frame.size.height + setHight + 20;

    // 添加
    _addBtn = [[UIButton alloc] init];
    _addBtn.backgroundColor = UIColorWithRGB(252, 132, 37, 1);
//    [_addBtn setImage:[UIImage imageNamed:@"myLogin_loginBg.png"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addPressed) forControlEvents:UIControlEventTouchUpInside];
//    [_addBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    _addBtn.titleLabel.font = defaultFontSize(13);
//    [_addBtn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    _addBtn.frame = CGRectMake(0, iPhoneHeight - 50 , iPhoneWidth, 50);

    [self.view addSubview:_addBtn];
    UILabel *alab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 50)];
    alab.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    alab.textAlignment = NSTextAlignmentCenter;
    alab.textColor = [UIColor whiteColor];
    [_addBtn addSubview:alab];
    alab.font = defaultFontSize(15);
    alab.text = @"添加地址";

    
    // 获取地址
    [self httpAddressListRequest];

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
    [_addressTableView reloadData];

}

//TODO:重新设置界面
- (void)reSetViewFarme{
    setHight = IOS7?20:0;
    setHight = setHight + NVARBAR_HIGHT+10 ;
//    
    if (arrCount == 0) {
        
        
        _noArrView.hidden = NO;
        
        _noArrView.frame = CGRectMake(0, setHight , iPhoneWidth , 40);
        setHight = setHight + 50;
        _addressTableView.hidden = YES;

    }else{
        self.view.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
        _noArrView.hidden = YES;
        _addressTableView.hidden = NO;

//       _addressTableView.frame = CGRectMake( 0, _addressTableView.frame.origin.y, iPhoneWidth, CELL_HIGHT * arrCount);
//     setHight = setHight + CELL_HIGHT * arrCount;
//     float hgh = _addressArr.count * CELL_HIGHT;
//      if (iPhoneHeight - _addressArr.count * CELL_HIGHT - setHight - 50 < 0) {
//            hgh = iPhoneHeight - setHight - 50;
//      }
     _addressTableView.frame = CGRectMake(0, setHight, iPhoneWidth,iPhoneHeight - setHight-40 );
    }
   setHight = setHight + 30;
    
//    _addBtn.frame = CGRectMake((iPhoneWidth - 120 )/2, iPhoneHeight - 50 , 120, 40);
//

}

#pragma mark -
#pragma mark ==============网络请求==============
//TODO:请求地址列表
-(void)httpAddressListRequest
{
    [self.progressView show:YES];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSNumber numberWithInt:REQ_ADDRESS_LIST] forKey:REQ_CODE];
    
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    
    [self.httpManager sendReqWithDict:dict];
}

//TODO:请求删除地址
-(void)httpAddressDeleteRequest:(NSInteger )row
{
    [self.progressView show:YES];

    deleteRow = row;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    AddressNode *node = [_addressArr objectAtIndex:row];
    
    [dict setObject:[NSNumber numberWithInt:REQ_ADDRESS_DELETE] forKey:REQ_CODE];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
    [dict setObject:node.AID forKey:@"id"];
    [self.httpManager sendReqWithDict:dict];
    
    [_addressTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ============ UITableView ============
//返回有多少个Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//这个方法返回   对应的section有多少个元素，也就是多少行。
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_addressArr && _addressArr.count > 0) {
        return _addressArr.count;

    }else{
        return 0;
    }
}

//这个方法返回指定的 row 的高度。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath;{
    return CELL_HIGHT;
}


static NSInteger deleteI;
// cell 内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [_addressTableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell )
    {
        cell = nil;
    }
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:showUserInfoCellIdentifier];

    //cell被选中后的颜色改变为Blue
 
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

      deleteI =indexPath.row;
    if (arrCount != 0) {
        
     AddressNode *node= [_addressArr objectAtIndex:indexPath.row];
    
        // 姓名
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 60, 20)];
        nameLab.backgroundColor = [UIColor clearColor];
        nameLab.text = node.consignee;
        nameLab.textColor = [UIColor blackColor];
        nameLab.font = [UIFont systemFontOfSize:18];
        nameLab.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:nameLab];
        
        // 电话
        UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 150, 20)];
        phoneLab.backgroundColor = [UIColor clearColor];
//        phoneLab.text = node.mobile;
        phoneLab.text = [node.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        phoneLab.textColor = [UIColor blackColor];
        phoneLab.font = [UIFont systemFontOfSize:18];
        phoneLab.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:phoneLab];
        
        NSString *address = [NSString stringWithFormat:@"%@%@",node.region,node.addr];
//        address = [address stringByAppendingString:node.Aaddress];
        
        // 地址
        UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, iPhoneWidth-30, 50)];
        addressLab.backgroundColor = [UIColor clearColor];
        address = [address stringByReplacingOccurrencesOfString:@"，" withString:@""];
        addressLab.text = address;
        addressLab.textColor = [UIColor grayColor];
        addressLab.font = [UIFont systemFontOfSize:15];
        addressLab.textAlignment = NSTextAlignmentLeft;
        addressLab.numberOfLines = 0;
    
        [cell addSubview:addressLab];
        
        UIImageView *lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88, iPhoneWidth, 1)];
        lineImgView.backgroundColor = UIColorWithRGB(239, 239, 244, 1);
        
        [cell addSubview:lineImgView];
        cell.backgroundColor = [UIColor clearColor];
        
        // 编辑按钮
        UIButton *editBtn = [[UIButton alloc] init];
        editBtn.frame = CGRectMake(iPhoneWidth - 150, 90, 90, 30);
        [editBtn setImage:[UIImage imageNamed:@"Address_edit.png"] forState:UIControlStateNormal];
        editBtn.backgroundColor = [UIColor clearColor];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:editBtn];
        editBtn.tag = indexPath.row;
        
        
        // 删除按钮
       UIButton *deltelBtn = [[UIButton alloc] init];
        deltelBtn.frame = CGRectMake(iPhoneWidth - 70, 90, 70, 30);
        [deltelBtn setImage:[UIImage imageNamed:@"Address_delegate.png"] forState:UIControlStateNormal];
        [deltelBtn addTarget:self action:@selector(deltelBtnAction:event:) forControlEvents:UIControlEventTouchUpInside];
        [deltelBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deltelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cell addSubview:deltelBtn];
        deltelBtn.tag = indexPath.row;
        deltelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        UIImageView *lineImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT - 10, iPhoneWidth, 10)];
        lineImgView1.backgroundColor = UIColorWithRGB(223, 223, 226, 0.5);
        [cell addSubview:lineImgView1];
        cell.backgroundColor = [UIColor whiteColor];

    }

    
   

    
    return cell;
}

//打开编辑模式后，默认情况下每行左边会出现红的删除按钮，这个方法就是关闭这些按钮的
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//这个方法用来告诉表格 这一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUInteger row = [indexPath row];
        deleteRow = row;
        [self httpAddressDeleteRequest:row];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (_addressStyle == buyAddress) {
        
        AddressNode *node = [_addressArr objectAtIndex:indexPath.row];
        NSString *address = [NSString stringWithFormat:@"%@%@",node.region,node.addr];
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:GOODSBUY_ADDRESS];
        [[NSUserDefaults standardUserDefaults] setObject:node.AID forKey:GOODSBUY_ADDRESSID];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (_addressStyle == winnerAddress) {
        nowSelectRow = indexPath.row;
        
        UIAlertView *showAlert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认选择此地址为收货地址？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [showAlert show];
        


    }
    

}





#pragma mark - 网络回调
// 网络回调成功
- (void)requestFinished:(NSDictionary *)resultDict
{
    [self.progressView hide:YES];
    
    switch ([[resultDict objectForKey:REQ_CODE] integerValue]) {
            // 地址列表
        case REQ_ADDRESS_LIST:
        {
            NSArray *arr = [resultDict objectForKey:RESP_CONTENT];
            _addressArr = [NSMutableArray arrayWithArray:arr];
            arrCount = _addressArr.count;
            [_addressTableView reloadData];
            if (arrCount > 0) {
                AddressNode *anode = [_addressArr objectAtIndex:0];
                NSString *address = [NSString stringWithFormat:@"%@%@",anode.region,anode.addr];

                [[NSUserDefaults standardUserDefaults] setObject:anode.consignee forKey:SAVE_ADDRESS_NAME];
                [[NSUserDefaults standardUserDefaults] setObject:anode.mobile forKey:SAVE_ADDRESS_PHONE];
                [[NSUserDefaults standardUserDefaults] setObject:address forKey:SAVE_ADDRESS_ADDR];
                [[NSUserDefaults standardUserDefaults] setObject:anode.province forKey:SAVE_ADDRESS_PROVINCES_ID];
                [[NSUserDefaults standardUserDefaults] setObject:anode.city forKey:SAVE_ADDRESS_CITY_ID];
                [[NSUserDefaults standardUserDefaults] setObject:anode.area forKey:SAVE_ADDRESS_COUNTY_ID];
            }
            [self reSetViewFarme];
        }
            break;
            // 删除地址
        case REQ_ADDRESS_DELETE:
        {
            
            [self.addressArr removeObjectAtIndex:deleteRow];
            arrCount  = self.addressArr.count;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:deleteRow inSection:0];

            NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
            if (arrCount == 0) {
                _addressTableView.hidden = YES;
            }else{
                [_addressTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                
            }
//            [self reSetViewFarme];
            

        }
            break;
            // 设置中奖收货地址
        case REQ_SNATCH_MYWINNER_ADDRESS:{
            [[NSNotificationCenter defaultCenter] postNotificationName:SETADDRSSS_WINNER_DETAIL object:nil];
            [self.navigationController popViewControllerAnimated:YES];
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

    switch ([[errorDict objectForKey:REQ_CODE] integerValue]) {
        case REQ_ADDRESS_LIST:
        {
//            [[SystemStateManager sharedSystemStateManager] showProgressWithString:@"获取地址失败" hiddenAfterDelay:1];
            [self showProgressWithString:@"获取地址失败" hiddenAfterDelay:1];

        }
            break;
            
        case REQ_ADDRESS_DELETE:
        {
//            [[SystemStateManager sharedSystemStateManager] showProgressWithString:@"地址删除失败" hiddenAfterDelay:1];
            [self showProgressWithString:@"地址删除失败" hiddenAfterDelay:1];

        }
            break;
            // 设置中奖收货地址
        case REQ_SNATCH_MYWINNER_ADDRESS:{
            [self showProgressWithString:@"设置失败" hiddenAfterDelay:1];

        }
            break;
        default:
            break;
    }
}




#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//TODO:进入编辑 界面
- (void)editBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    AddressNode *node = [_addressArr objectAtIndex:tag];

    AddAddressViewController *addViewController = [[AddAddressViewController alloc] init];
    addViewController.isAdd = NO;
    addViewController.addressNode = node;
    [self.navigationController pushViewController:addViewController animated:YES];
}
//TODO:删除地址
- (void)deltelBtnAction:(id)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_addressTableView];
    NSIndexPath *indexPath= [_addressTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        // do something
        deleteI = indexPath.row;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否确认删除该地址" message:@"" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert show];
    }
}

//TODO:警告提示响应
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
    
     
     NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
         
     
     if ([str isEqualToString:@"是"]) {
             
         [self httpAddressDeleteRequest:deleteI];
  
         }
     
     if ([str isEqualToString:@"确定"]) {
         [self.progressView show:YES];
         NSMutableDictionary *dict = [NSMutableDictionary dictionary];
         
         [dict setObject:[NSNumber numberWithInt:REQ_SNATCH_MYWINNER_ADDRESS] forKey:REQ_CODE];
         
         [dict setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
         AddressNode *node = [_addressArr objectAtIndex:nowSelectRow];
         NSString *address = [NSString stringWithFormat:@"%@%@",node.region,node.addr];

         [dict setObject:node.consignee forKey:@"consignee"];
         [dict setObject:_winnerGoodsID forKey:@"id"];
         [dict setObject:node.mobile forKey:@"mobile"];
         [dict setObject:address forKey:@"addr"];


         [self.httpManager sendReqWithDict:dict];
     }
}
//TODO:添加地址
- (void)addPressed{
    AddAddressViewController *addViewController = [[AddAddressViewController alloc] init];
    addViewController.isAdd = YES;
    [self.navigationController pushViewController:addViewController animated:YES];
}

//TODO:添加地址成功
- (void)addSuccess{
    [self httpAddressListRequest];
}


//TODO:编辑地址
- (void)editAction:(id)sender{

    isEdit = !isEdit;
    if (isEdit) {
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.addressTableView setEditing:YES animated:YES];

    }else{
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.addressTableView setEditing:NO animated:YES];

    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADD_ADDRESS_SUCCESS object:nil];
    
}

@end
