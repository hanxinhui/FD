//
//  WelfareGetViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "WelfareGetViewController.h"
#import "WelfareGetSearchListViewController.h"
#import "CountersignPayViewController.h"

#define SELECTGOODS_TAG    10001  // 选择商品
#define SHAREGOODS_TAG    10002  // 发福利

@interface WelfareGetViewController ()<WelfareGetSearchDelegate>


@end

@implementation WelfareGetViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"土豪抽疯";
    self.headerView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.statusBarView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
    self.view.backgroundColor = UIColorWithRGB(245, 246, 250, 1);
    self.dlineImgView.hidden = YES;

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
    isCanSet = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // 取消兑换成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGoodFinished) name:SELECTGOODS_SUCCESS object:nil];
    
    _goodDiC =  [NSMutableDictionary dictionary];
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
    setHeight = setHeight + 20;
    
    // 选择商品
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:@"WelfareGetView_Bg.png"];
    [self setLabel:CGRectMake(10, setHeight, 100, 50) labFont:16 labText:@"选择商品" textC:[UIColor blackColor]];
    
    // 商品名称
    _goodsNameLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setHeight, iPhoneWidth - 120, 50)];
    _goodsNameLab.backgroundColor = [UIColor clearColor];
    _goodsNameLab.textColor = [UIColor lightGrayColor];
    _goodsNameLab.textAlignment = NSTextAlignmentRight;
    _goodsNameLab.text = @"选择福利商品";
    _goodsNameLab.font = defaultFontSize(15);
    [self.view addSubview:_goodsNameLab];
    
    
    [self setBgImgView:CGRectMake(iPhoneWidth-20, setHeight + 16, 10, 17) imageName:@"My_right.png"];
    
    [self setBtn:CGRectMake(0, setHeight+10, iPhoneWidth, 50) imageName:nil btnTag:SELECTGOODS_TAG Color:[UIColor clearColor]];
    
    
    setHeight = setHeight + 65;
    
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 50) imageName:@"WelfareGetView_Bg.png"];
    
    [self setLabel:CGRectMake(10, setHeight, 100, 50) labFont:15 labText:@"抢宝人数" textC:[UIColor blackColor]];
    
    // 商品个数
    _codeNumTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(iPhoneWidth-282, setHeight , 260, 50)];
    _codeNumTextField.backgroundColor = [UIColor clearColor];
    _codeNumTextField.font = defaultFontSize(15);
    [self.view addSubview:_codeNumTextField];
    _codeNumTextField.textAlignment = NSTextAlignmentRight;
//    _codeNumTextField.placeholder = @"填写人数";
//    _codeNumTextField.placeHoldColor = [UIColor lightGrayColor];
//    _codeNumTextField.placeHoldFont = defaultFontSize(15);
    _codeNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    _codeNumTextField.delegate = self;
    _codeNumTextField.textColor = [UIColor grayColor];
    
    // 总金额
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth-82, setHeight, 60, 50)];
    _numLab.backgroundColor = [UIColor clearColor];
    _numLab.textColor = [UIColor lightGrayColor];
    _numLab.textAlignment = NSTextAlignmentRight;
    _numLab.text = @"填写人数";
    _numLab.font = defaultFontSize(15);
    [self.view addSubview:_numLab];
    
    [self setLabel:CGRectMake(iPhoneWidth - 20, setHeight, 20, 50) labFont:15 labText:@"个" textC:[UIColor blackColor]];
    
    setHeight = setHeight + 65;
    
    [self setBgImgView:CGRectMake(0, setHeight, iPhoneWidth, 90) imageName:@"WelfareGetView_Bg.png"];
    
    // 说明文字
    _showTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, setHeight, iPhoneWidth-20, 90)];
    _showTextView.backgroundColor = [UIColor clearColor];
    _showTextView.text = @"小小心意,祝大家生活愉快!";
    _showTextView.textColor =  [UIColor lightGrayColor];
    _showTextView.font = defaultFontSize(15);
    _showTextView.delegate = self;
    _showTextView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_showTextView];
    
    setHeight = setHeight + 90 + 40;
    
    // 总金额
    _moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(50, iPhoneHeight-180, iPhoneWidth - 100, 45)];
    _moneyLab.backgroundColor = [UIColor clearColor];
    _moneyLab.textColor = [UIColor blackColor];
    _moneyLab.textAlignment = NSTextAlignmentCenter;
    _moneyLab.text = @"￥0.00";
    _moneyLab.font = defaultFontSize(45);
    [self.view addSubview:_moneyLab];
    
    setHeight = setHeight + 55;
    
    //发福利
    UIButton    *sharebtn = [[UIButton alloc] initWithFrame:CGRectMake(40, iPhoneHeight-100, iPhoneWidth - 80, 50)];
    sharebtn.backgroundColor = UIColorWithRGB(255, 213, 110, 1);
    [sharebtn setTitle:@"发福利" forState:UIControlStateNormal];
    [sharebtn setTitleColor:UIColorWithRGB(122, 62, 42, 1) forState:UIControlStateNormal];
    sharebtn.titleLabel.font = defaultFontSize(19);
    sharebtn.tag = SHAREGOODS_TAG;
    [sharebtn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sharebtn];
    
    isFirst = YES;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, iPhoneHeight - 45, iPhoneWidth - 40, 45)];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor lightGrayColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"24小时内未被领完，商品金额将退回";
    lab.font = defaultFontSize(14);
    [self.view addSubview:lab];
    

    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
}

//TODO:取消键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_codeNumTextField resignFirstResponder];
    [_showTextView resignFirstResponder];
}

//TODO:设置图片背景
- (void)setBgImgView:(CGRect )rect imageName:(NSString *)imgname{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:imgname];
    [self.view addSubview:imageView];
}

//TODO:设置提示文字
- (void)setLabel:(CGRect )rect  labFont:(float )labfont labText:(NSString *)text textC:(UIColor *)color{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = color;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = text;
    lab.font = defaultFontSize(labfont);
    [self.view addSubview:lab];
}

//TODO:设置按钮
- (void)setBtn:(CGRect )rect imageName:(NSString *)imgname btnTag:(NSInteger )tag Color:(UIColor *)color{
    UIButton    *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = color;
    //    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnPassed:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    
    [self.view addSubview:btn];
}

#pragma mark ============ UITextView ============
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    if (isFirst) {
        _showTextView.text=@"";
        isFirst = NO;
    }
    
    
    _showTextView.textColor = [UIColor blackColor];
    
    return YES;
    
}

//TODO:设置取消
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    _codeNumTextField.text = @"";
    _numLab.hidden = YES;
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        _numLab.hidden = NO;

    }

}

#pragma mark -
#pragma mark ============ 响应事件 ============
//TODO:返回
- (void)backPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO:点击事件
- (void)btnPassed:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 选择商品
        case SELECTGOODS_TAG:
        {
            WelfareGetSearchListViewController *welfareGetSearchListViewController = [[WelfareGetSearchListViewController alloc] init];
            welfareGetSearchListViewController.delegate = self;
            [self.navigationController pushViewController:welfareGetSearchListViewController animated:YES];
        }
            break;
            // 发福利
        case SHAREGOODS_TAG:
        {
            if(!isCanSet){
                [self showProgressWithString:@"选择商品" hiddenAfterDelay:1];
                return;
            }
            
            if([ShareDataManager getText:_codeNumTextField.text]){
                [self showProgressWithString:@"请输入口令个数" hiddenAfterDelay:1];
                return;
            }
            if ([_codeNumTextField.text integerValue] > [_listNode.price integerValue] ) {
                [self showProgressWithString:@"口令个数不得小于商品金额" hiddenAfterDelay:1];
                _codeNumTextField.text = _listNode.price;
                return;
            }
            [_goodDiC setObject:[NSString stringWithFormat:@"%ld",(long)[UserDataManager sharedUserDataManager].userData.UID] forKey:@"uid"];
            [_goodDiC setObject:_listNode.Hid forKey:@"gid"];
//            [_goodDiC setObject:_moneyLab.text forKey:@"pice"];
            [_goodDiC setObject:_codeNumTextField.text forKey:@"count"];
            if (isFirst){
                [_goodDiC setObject:@"" forKey:@"remark"];

            }else{
                [_goodDiC setObject:_showTextView.text forKey:@"remark"];

            }
            CountersignPayViewController *createViewController = [[CountersignPayViewController alloc] init];
            createViewController.countersignStyle = WelfareCountersignStyle;
            createViewController.payDict = _goodDiC;
            [self.navigationController pushViewController:createViewController animated:YES];

        }
            break;
        default:
            break;
    }
}

//TODO:传回数据
- (void)getGoodsNode:(SnatchHomeListNode *)node{
    isCanSet = YES;
    _listNode = node;
    _goodsNameLab.text = node.title;
    [_goodDiC setObject:node.price forKey:@"pice"];

    _moneyLab.text = [NSString stringWithFormat:@"￥%@",node.price];

}

//TODO:传回数据
- (void)getGoodFinished{
    SnatchHomeListNode *node = [[NSUserDefaults standardUserDefaults] objectForKey:SAVE_SELECTGOODS_NODE];
    [self getGoodsNode:node];
}

#pragma mark 网络请求
//TODO:生成福利
- (void)reqCreateWerlfare{
    
 
 
}




//TODO:释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTGOODS_SUCCESS object:nil];
    
}
@end
