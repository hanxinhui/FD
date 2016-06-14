//
//  RegisterViewController.m
//  FD
//
//  Created by Leoxu on 15-6-16.
//  Copyright (c) 2015年 Leo xu. All rights reserved.
//

#import "RegisterViewController.h"
#import "CodeViewController.h"
#import "SvUDIDTools.h"


@interface RegisterViewController ()


@end

@implementation RegisterViewController


//TODO:初始化导航栏
-(void)initNavBar
{
    
    self.titleLable.textColor = [UIColor whiteColor];
    
    self.titleLable.text = @"手机快速注册";
    self.headerBgView.backgroundColor = [UIColor clearColor];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.statusBarView.backgroundColor = [UIColor clearColor];
    self.dlineImgView.hidden = YES;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 50);
    [leftBtn setImage:[UIImage imageNamed:@"Public_Back.png"] forState:UIControlStateNormal];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
    self.backgroundView .backgroundColor = UIColorWithRGB(0, 0, 0, 0.8);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    setHeight = IOS7?20:0;

    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.alpha = 0.8;
    
    [self initNavBar];
    setHeight = setHeight + NVARBAR_HIGHT;
   
    setHeight =  setHeight + 50;
    
    _phoneTextField = [[CustomTextField alloc]initWithFrame:CGRectMake(20, setHeight, iPhoneWidth - 40, 40)];
    _phoneTextField.backgroundColor = [UIColor clearColor];
    _phoneTextField.font = defaultFontSize(21);
    _phoneTextField.textColor = [UIColor whiteColor];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.verticalPadding = 2;
//    [_phoneTextField becomeFirstResponder];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextField.delegate = self;
    [self.view addSubview:_phoneTextField];
//    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self setTheLineImg:setHeight + 40];
    // 清除手机号
    _phoneTextBtn  = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 40, setHeight + 10 , 20, 20)];
    _phoneTextBtn.backgroundColor = [UIColor clearColor];
    [_phoneTextBtn setImage:[UIImage imageNamed:@"Public_ClearText.png"] forState:UIControlStateNormal];
    [_phoneTextBtn addTarget:self action:@selector(clearPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_phoneTextBtn];
    _phoneTextBtn.hidden = YES;
    
    _dealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dealBtn.frame = CGRectMake(20, setHeight + 50, 19, 19);
    _dealBtn.backgroundColor = [UIColor clearColor];
    [_dealBtn setImage:[UIImage imageNamed:@"deal_unselect.png"] forState:UIControlStateNormal];
    [_dealBtn setImage:[UIImage imageNamed:@"deal_select.png"] forState:UIControlStateSelected];
    [_dealBtn addTarget:self action:@selector(dealBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dealBtn];
    _dealBtn.selected = YES;
    
    UILabel *deallab = [[UILabel alloc] initWithFrame:CGRectMake(50,setHeight + 50, iPhoneWidth - 100, 20)];
    deallab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:deallab];
    deallab.text = @"同意爱葫芦用户注册协议";
    deallab.font = [UIFont boldSystemFontOfSize:12];
    deallab.textColor = UIColorWithRGB(167, 167, 167, 1);
    deallab.textAlignment = NSTextAlignmentLeft;
    
    UIButton *showDealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showDealBtn.frame = CGRectMake(50,setHeight + 50, iPhoneWidth - 100, 20);
    showDealBtn.backgroundColor = [UIColor clearColor];
    [showDealBtn addTarget:self action:@selector(showDealBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showDealBtn];
    
    setHeight =  setHeight + 80;

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(20, setHeight, iPhoneWidth - 40, 45);
    nextBtn.backgroundColor = UIColorWithRGB(61, 159, 242, 1);
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg"] forState:UIControlStateNormal];
    [nextBtn setImage:[UIImage imageNamed:@"next_blue_bg_h"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth - 40, 45)];
    lab.backgroundColor = [UIColor clearColor];
    [nextBtn addSubview:lab];
    lab.text = @"下一步";
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;

    [self.view bringSubviewToFront:self.progressView];
    [self setProgressViewLoadingStyle];
    [self.view bringSubviewToFront:self.leftBtn];
    
    

}

//TODO:设置横线
- (void)setTheLineImg:(float )sizeY {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, sizeY-1, iPhoneWidth - 40, 1)];
    imgView.backgroundColor = UIColorWithRGB(209, 209, 209, 1);
    imgView.alpha = 0.5;
    [self.view addSubview:imgView];
}

#pragma mark -
#pragma mark ============ UIAlertViewDelegate ============
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    NSString *str = [alertView buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"确定"]) {
        [self reqGetCode];
    }
    if ([str isEqualToString:@"放弃"]) {
//        [_phoneTextField resignFirstResponder];
        
        // 返回
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


#pragma mark -
#pragma mark ============ 点击事件 ============
//TODO:返回
- (void)backAction{
     [_phoneTextField resignFirstResponder];
    // 弹出警告
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃注册" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续注册", nil];
    [alert show];
}

//TODO:下一步
- (void)nextBtnPressed{
    if (!_dealBtn.selected){
        [self showProgressWithString:@"请先阅读同意爱葫芦用户注册协议" hiddenAfterDelay:2];
        
        return;

    }
    if ([ShareDataManager getText:_phoneTextField.text]) {
        NSLog(@"未输入手机");
        [self showProgressWithString:@"请输入手机号" hiddenAfterDelay:1];

        return;
        
    }
    if (![ShareDataManager isValidatePhoneNum:_phoneTextField.text]) {
        [self showProgressWithString:@"手机号输入错误" hiddenAfterDelay:1];

        NSLog(@"手机格式输入错误");
        return;

    }
    NSString *msg = [NSString stringWithFormat:@"我们将发送验证码短信至:%@",_phoneTextField.text];
    
    // 弹出警告
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

#pragma mark ============ UITextFieldDelegate ============
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _phoneTextBtn.hidden = NO;

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _phoneTextBtn.hidden = YES;

}
//TODO:清除手机号
- (void)clearPhoneAction{
    _phoneTextField.text = nil;
    [_phoneTextField becomeFirstResponder];

}

//TODO:协议
- (void)dealBtnPressed{
    _dealBtn.selected = !_dealBtn.selected;
    
}
//TODO:协议展示
- (void)showDealBtnPressed{
    UIAlertView *showAlertView = [[UIAlertView alloc] initWithTitle:@"爱葫芦" message:@"1、特别提示\n1.1南京沸点互联网科技有限公司（以下简称“沸点科技”）同意按照本协议的规定及其不时发布的操作规则提供基于互联网的相关服务(以下称“网络服务”)，为获得网络服务，服务使用人(以下称“用户”)同意本协议的全部条款并按照页面上的提示完成全部的注册程序。用户在进行注册程序过程中点击“同意”按钮即表示用户完全接受本协议项下的全部条款。\n1.2这些条款可由爱葫芦随时更新，本注册协议一旦发生变动，爱葫芦将会在相关的页面上提示修改内容。修改后的注册协议一旦在页面上公布即有效代替原来的注册协议。用户可随时造访网站查阅最新的注册协议。用户在使用爱葫芦提供的各项服务之前，应仔细阅读本服务协议。在此特别提醒用户，本协议之规定可能随时会更改，敬请定期查询。由于用户规则变更后因未熟悉公告规定而引起的损失,我们一律不予以赔偿。如用户不同意本服务协议及/或随时对其的修改，请停止使用爱葫芦提供的服务。\n1.3爱葫芦提供的各项服务的所有权和运作权归南京沸点互联网科技有限公司所有。\n2、服务内容\n2.1爱葫芦是一个新型社交类型的网络广告复合型媒体平台，其网络服务的具体内容由爱葫芦根据实际情况提供，例如完成“广告任务”等。爱葫芦保留随时变更、中断或终止部分或全部网络服务的权利。\n2.2用户应使用正版软件接受网络服务。\n3、使用规则\n3.1用户在申请成为爱葫芦用户时，必须向爱葫芦提供准确的个人资料，即必须使用真实的身份进行注册；如个人资料有任何变动，必须及时更新。\n3.2注册及提现须知\n3.2.1一个用户只能注册和使用一个账号，此处所指用户指具有独立民事行为能力，并具有与其姓名相一致手机号码的个人，用户须以真实有效的手机号码作为注册账号，该手机号码须对应用户的真实姓名（以用户个人身份证所载姓名为准）；用户用以注册的手机号码为无姓名用户的，视为无效账号，爱葫芦有权终止为此账号用户提供一切基于爱葫芦的服务。\n3.2.2一个用户被确认注册使用的帐号不止一个时，一律永久冻结账号。\n3.2.3用户使用五个以上的账号进行注册，并通过相应的第三方平台（包括但不限于银联、支付宝等），对其通过完成爱葫芦广告任务而赚取的广告佣金以外的其他奖励进行提现的，视为恶意提现，爱葫芦有权永久冻结其账号，并停止为其提供提现服务，同时，该部分奖励对应的葫芦币由爱葫芦全数收回。\n3.2.4用户通过第三方支付平台提现的，如遇非爱葫芦所能避免或控制的障碍，导致提现款到账迟延的，爱葫芦将向用户作出必要的解释，并不承担由此导致的相关责任。\n3.2.5用户未遵守前述注册及提现规则，导致账号冻结的，如需重新开通此账号，须向爱葫芦提供被冻结账号、密码、该账号绑定的银行卡（彩色电子版本或扫描件）、与银行卡账户名一致的身份证复印件（彩色电子版本或扫描件）。\n3.3用户注册成功后，爱葫芦将给予每个用户一个用户账号及相应的密码，该用户账号和密码由用户负责保管；用户应当对以其用户账号进行的所有活动和事件负法律责任。\n3.4用户为通过爱葫芦完成“广告任务”，而使用信用卡的现金支付功能支付广告任务保证金的，应按发卡行规定的还款日期按时还款；用户因恶意透支信用卡被发卡行追究责任的，应自行承担相应的法律责任，爱葫芦终端不具备且不提供银行卡类别识别功能，爱葫芦并不因此承担任何连带责任。\n4、隐私保护\n4.1保护用户隐私是爱葫芦的一项基本政策，爱葫芦保证不对外公开用户注册资料及用户在使用爱葫芦时存储在爱葫芦的非公开内容，但下列情况除外：\n①事先获得用户的明确授权；\n②根据有关的法律法规要求；\n③按照相关政府主管部门的要求；\n④为维护社会公众的利益；\n⑤为维护爱葫芦的合法权益。\n4.2爱葫芦可能会与第三方合作向用户提供相关的网络服务，在此情况下，如该第三方同意承担与爱葫芦同等的保护用户隐私的责任，则爱葫芦可将用户的注册资料等提供给该第三方。\n4.3在不透露单个用户隐私资料的前提下，爱葫芦有权对整个用户数据库进行技术分析并对已进行分析、整理后的用户数据库进行商业上的利用。\n5、免责声明\n5.1爱葫芦不保证以下事宜：\n①本服务将符合您的要求；\n②本服务将不受干扰、及时提供、安全可靠或不会出错。\n5.2用户明确同意：因其违规使用爱葫芦网络服务所存在的风险将完全由其自己承担；因其违规使用爱葫芦网络服务而产生的一切后果也由其自己承担。\n5.3使用葫芦手机客户端登录爱葫芦的用户同意，当其使用手机客户端登录爱葫芦时：\n5.3.1爱葫芦有权利用UDID来识别和收集手机用户信息，并对用户操作爱葫芦的整个活动进程进行跟踪；\n5.3.2爱葫芦有权在用户进入签到页面进行签到时，通过调集GPS信号/收集wifi对用户进行定位；\n5.3.3爱葫芦该行为不视为侵犯用户隐私，爱葫芦承诺依前述隐私保护条款对用户信息予以保密。\n6、服务变更、中断或终止\n6.1如因系统维护或升级的需要而需暂停网络服务，爱葫芦将尽可能事先进行通告。\n6.2如发生下列任何一种情形，爱葫芦有权随时中断或终止向用户提供本协议项下的网络服务而无需通知用户：\n①用户提供的个人资料不真实；\n②用户违反本协议中规定的使用规则；\n③爱葫芦在与用户联系过程中，发现用户注册时填写的资料不真实，经爱葫芦以其他联系方式通知用户更改，而用户在三个工作日内仍未提供新的更改资料的，爱葫芦有权终止与该用户的服务协议。\n④爱葫芦对任何直接、间接、偶然、特殊及继起的使用虚假信息或盗取他人信息，以获取不正当所得为目的的行为，爱葫芦有权永久删除用户账号、冻结所有非法所得，并保留依法追究权利。\n6.3除前款所述情形外，爱葫芦有权在不损害用户利益的前提下不事先通知而随时中断或终止部分或全部网络服务。\n7、修改协议\n7.1爱葫芦有权在必要时修改服务条款，爱葫芦服务条款一旦发生变动，将会在重要页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的爱葫芦服务。如果用户继续享用爱葫芦服务，则视为接受服务条款的变动。\n8、相关声明\n8.1您一旦注册成功成为用户，您将得到一个密码和账号。如果您不保管好自己的账号和密码安全，将负全部责任。另外，每个用户都要对其账户中的所有活动和事件负全责。您可随时根据指示改变您的密码，也可以结束旧的账户重开一个新账户。用户同意若发现任何非法使用用户账号或安全漏洞的情况，将立即通告爱葫芦。\n8.2用户明确同意信息服务的使用由用户个人承担风险。爱葫芦不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保，但会在能力范围内，避免出错。\n8.3爱葫芦对任何直接、间接、偶然、特殊及继起的损害不负责任，这些损害来自：不正当使用爱葫芦服务，或用户传送的信息不符合规定等。这些行为都有可能导致爱葫芦形象受损，所以爱葫芦事先提出这种损害的可能性，同时会尽量避免这种损害的发生。\n8.4用户同意保障和维护爱葫芦及其他用户的利益，如因用户违反有关法律、法规或本协议项下的任何条款而给爱葫芦或任何其他第三人造成损失，用户同意承担由此造成的损害赔偿责任。\n8.5爱葫芦作为广告发布平台有权接受其合作商户的委托，在爱葫芦（www.ihuluu.com）的相应版块发布该商户提供的图片、文字及链接等可直观呈现的信息，该类信息将由爱葫芦于上线发布前予以审核。鉴于合作商户可能因各类主客观缘由，变更其链接地址所对应的信息内容，并不经爱葫芦审核，据此，爱葫芦并不保证发布于本网站上所有其他商户的链接信息均合法或非为法律法规及相关政策所禁止，且不承担因链接信息不合法所导致的任何风险。\n9、法律管辖\n9.1本协议的订立、执行和解释及争议的解决均应适用中国法律。\n9.2如双方就本协议内容或其执行发生任何争议，双方应尽量友好协商解决；协商不成时，任何一方均可向爱葫芦所在地的人民法院提起诉讼。\n10、通知和送达本协议项下所有的通知均可通过重要页面的公告传送。服务条款的修改、服务变更、或其它重要事件的通告都会以此形式进行。\n11、其他规定\n11.1本协议构成双方对本协议之约定事项及其他有关事宜的完整协议，除本协议规定的之外，未赋予本协议各方其他权利。\n11.2如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍继续有效并具有约束力。\n11.3本协议中的标题仅为方便而设，不具法律或契约效果。\n南京沸点互联网科技有限公司\n2015年10月13日" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [showAlertView show];
}

#pragma mark ============ 其他事件 ============
//TODO:隐藏底部tarbar
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
}

#pragma mark ===============网络请求 ================

//TODO:上传手机号获取验证码
- (void)reqGetCode{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:REQ_GETCODE] forKey:REQ_CODE];
    [dict setObject:_phoneTextField.text forKey:@"username"];
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
            // 请求验证码
        case REQ_GETCODE:
        {
            NSDictionary *dict = [resultDict objectForKey:RESP_CONTENT];
            // 倒计时
            NSString *exp = [NSString stringWithFormat:@"%@",[dict objectForKey:@"exp"]];
            float expp = [exp floatValue];
            
            // 验证码
            NSString *verify = [NSString stringWithFormat:@"%@",[dict objectForKey:@"verify"]];
            NSString *codeid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
            NSLog(@"验证码 ===   %@",verify);
            
            // 进入下一层 验证码
            CodeViewController *codeViewController = [[CodeViewController alloc] init];
            codeViewController.expCode = *(&(expp));
            codeViewController.phoneNum = _phoneTextField.text;
            codeViewController.codeID = codeid;
            [self.navigationController pushViewController:codeViewController animated:YES];
            
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
            // 请求验证码
        case REQ_GETCODE:{
        }
            break;
            
        default:
            break;
    }
    
    [self showProgressWithString:msg hiddenAfterDelay:1];

}

@end
