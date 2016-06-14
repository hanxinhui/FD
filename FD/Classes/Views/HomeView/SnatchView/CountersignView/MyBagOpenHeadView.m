//
//  MyBagOpenHeadView.m
//  FD
//
//  Created by leoxu on 15/12/22.
//  Copyright © 2015年 leoxu. All rights reserved.
//

#import "MyBagOpenHeadView.h"
#import "FontDefine.h"

@implementation MyBagOpenHeadView

//TODO:是否传入
- (void)setIsJoin:(BOOL)isJoin{
    _isJoin = isJoin;
    
}

//TOOD:传入数据
- (void)setDataDic:(NSDictionary *)dataDic{
    if (_dataDic == dataDic) {
        return;
    }
    _dataDic = dataDic;
    if (_isJoin){
        _nameLab.hidden = NO;
        _headImgView.hidden = NO;
        _myconLab.hidden = YES;
        
        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 150 );
        [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];
//        _bgImgView.backgroundColor = UIColorWithRGB(234, 97, 84, 1);
        // 4S
        if (iPhoneWidth==320 && iPhoneHeight <500) {
            
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
            _bgImgView.frame = CGRectMake(0, -10 ,320, 150);
            
            
        }
        // 5/5S
        if (iPhoneWidth == 320 && iPhoneHeight >500) {
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_320.png"];
            _bgImgView.frame = CGRectMake(0, -90 ,320, 221);
            
            
        }
        // 6/6s
        if (iPhoneWidth == 375) {
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_375.png"];
            _bgImgView.frame = CGRectMake(0, -110 , 375, 259);
            
        }
        // 6P/6SP
        
        if (iPhoneWidth == 414) {
            _bgImgView.frame = CGRectMake(0, -140 , 414, 286);
            _bgImgView.image = [UIImage imageNamed:@"CounterSign_Home_bg_414.png"];
            
        }
        

        _headImgView.frame = CGRectMake((iPhoneWidth - 90) / 2, 80  , 90, 90 );
        _nameLab.frame = CGRectMake(15, 173, iPhoneWidth - 30, 25);
        _conLab.frame = CGRectMake(15, 190, iPhoneWidth - 30, 40);
        _footView.frame = CGRectMake(0, 230, iPhoneWidth, 140);
        
        
    }else{
        _nameLab.hidden = YES;
        _myconLab.hidden = NO;
        _headImgView.hidden = YES;
        
        _bgImgView.backgroundColor = UIColorWithRGB(238, 95, 80, 1);
        [_bgImgView setImage:nil];

        _bgImgView.frame = CGRectMake(0, 0, iPhoneWidth, 260 );
        _myconLab.frame = CGRectMake(15, 20, iPhoneWidth - 30, 50);
        _conLab.frame = CGRectMake(15, 60, iPhoneWidth - 30, 40);
        _conLab.textColor = UIColorWithRGB(247, 165, 150, 1);

        _footView.frame = CGRectMake(0, 120, iPhoneWidth, 140);
        _footView.backgroundColor = UIColorWithRGB(236, 96, 84, 1);
        NSInteger kind = [[_dataDic objectForKey:@"kind"] integerValue];
        //                 kind = 1; 1 福利抢宝  2 群抢宝 3 心愿单

        switch (kind) {
            case 1:
                _myconLab.text = [NSString stringWithFormat:@"福利抢宝,共%@人次",[_dataDic objectForKey:@"price"]];
                
                break;
            case 2:
                _myconLab.text = [NSString stringWithFormat:@"群抢宝,共%@人次",[_dataDic objectForKey:@"price"]];

                break;
            case 3:
                _myconLab.text = [NSString stringWithFormat:@"心愿单,共%@人次",[_dataDic objectForKey:@"price"]];

                break;
            default:
                break;
        }
    }
    _conLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"remark"]];
    NSString *name = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"nickname"]];
    if ([name isEqualToString:@"<null>"]) {
        name = [_dataDic objectForKey:@"mobile"];
        
    }
    _nameLab.text = [NSString stringWithFormat:@"%@",name];
    _nameLab.text = [NSString stringWithFormat:@"%@",name];
    _goodsLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"title"]];
    _goodsfLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"sub_title"]];
    [_goodsImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"list_noImg.png"]];
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];

    _showLab.text = [NSString stringWithFormat:@"共%@/%@个参与人",[_dataDic objectForKey:@"progress"],[_dataDic objectForKey:@"price"] ];

    _numberLab.text = [NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"luck_code"]];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self creat];
    }
    return self;
}

//TODO:初始化数据
- (void)creat{
    // 背景图片
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, 150 )];
    [self addSubview:_bgImgView];
    [_bgImgView setImage:[UIImage imageNamed:@"MyCounter_bgImage.png"]];

    
    // 头像
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 90) / 2, 70  , 90, 90 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    [_headImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
    _headImgView.layer.cornerRadius = 45;
    _headImgView.layer.masksToBounds = YES;

    
    // 昵称
    _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 160, iPhoneWidth - 30, 25)];
    _nameLab.backgroundColor = [UIColor clearColor];
    _nameLab.font = [UIFont systemFontOfSize:25];
    _nameLab.textAlignment = NSTextAlignmentCenter;
//    _nameLab.textColor = UIColorWithRGB(255,255, 255, 1);
    _nameLab.textColor = [UIColor blackColor];
    [self addSubview:_nameLab];
    
    
    //我发起说明
    _myconLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, iPhoneWidth - 30, 50)];
    _myconLab.backgroundColor = [UIColor clearColor];
    _myconLab.font = [UIFont systemFontOfSize:25];
    _myconLab.textAlignment = NSTextAlignmentCenter;
    _myconLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [self addSubview:_myconLab];

    
    // 说明
    _conLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 185, iPhoneWidth - 60, 40)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.font = [UIFont systemFontOfSize:15];
    _conLab.textAlignment = NSTextAlignmentCenter;
    _conLab.numberOfLines = 0;
    _conLab.textColor = UIColorWithRGB(159, 161, 161, 1);
    [self addSubview:_conLab];
    
    // 底部界面
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 225, iPhoneWidth, 140)];
    _footView.backgroundColor =  UIColorWithRGB(255, 255,255, 1);
    
       [self addSubview:_footView];
    
    //白色图片
    UIImageView *bgImageView= [[ UIImageView alloc]initWithFrame:CGRectMake(3, 2, iPhoneWidth-7, 80)];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [_footView addSubview:bgImageView];
    
    // 商品
    _goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10  , 70, 60 )];
    _goodsImgView.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_goodsImgView];
    
    // 商品
    _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, iPhoneWidth - 140, 40)];
    _goodsLab.backgroundColor = [UIColor clearColor];
    _goodsLab.font = [UIFont systemFontOfSize:15];
    _goodsLab.textAlignment = NSTextAlignmentLeft;
//    _goodsLab.numberOfLines = 0;
    _goodsLab.textColor = UIColorWithRGB(234, 97, 84, 1);
    [_footView addSubview:_goodsLab];
    
    // 商品说明
    _goodsfLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, iPhoneWidth - 140, 40)];
    _goodsfLab.backgroundColor = [UIColor clearColor];
    _goodsfLab.font = [UIFont systemFontOfSize:13];
    _goodsfLab.textAlignment = NSTextAlignmentLeft;
//    _goodsfLab.numberOfLines = 0;
    _goodsfLab.textColor = UIColorWithRGB(159, 161, 161, 1);
    [_footView addSubview:_goodsfLab];
    
    //红色底图
        UIImageView *redImage = [[UIImageView alloc]init];
        redImage.frame = CGRectMake(0, 80, iPhoneWidth, 30);
        redImage.backgroundColor = UIColorWithRGB(234, 97, 84, 1);
        [_footView addSubview:redImage];

// 幸运号码
    UILabel *luckyLab = [[UILabel alloc]init];
    luckyLab.frame = CGRectMake(15, 80, iPhoneWidth - 90, 30);
    luckyLab.text = @"幸运号码 :";
    luckyLab.font = [UIFont systemFontOfSize:15];
    luckyLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [_footView addSubview:luckyLab];
    
    _numberLab = [[UILabel alloc]init];
    _numberLab.frame = CGRectMake(90, 80, iPhoneWidth-90, 30);
//    _numberLab.text = @"12222222";
    _numberLab.font = [UIFont systemFontOfSize:15];
    _numberLab.textAlignment = NSTextAlignmentLeft;
   _numberLab.textColor = UIColorWithRGB(255, 255, 255, 1);
    [_footView addSubview:_numberLab];
    
    _lookBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth  - 124, 86, 120, 20)];
    _lookBtn.backgroundColor = [UIColor clearColor];
    [_footView addSubview:_lookBtn];
    [_lookBtn setTitle:@"查看计算详情" forState:UIControlStateNormal];
    [_lookBtn setTitleColor:UIColorWithRGB(255, 255, 255, 1) forState:UIControlStateNormal];
    _lookBtn.titleLabel.font = defaultFontSize(15);
   [_lookBtn addTarget:self action:@selector(showCountDetailsPressed) forControlEvents:UIControlEventTouchUpInside];
//    [_lookBtn.layer setBorderWidth:1.0f];
//    [_lookBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    
//    //灰色图片
    UIImageView *grayImageView= [[ UIImageView alloc]initWithFrame:CGRectMake(0, 110, iPhoneWidth, 30)];
    grayImageView.backgroundColor = UIColorWithRGB(245, 246,250, 1);
    [_footView addSubview:grayImageView];
    
 
    //
    _showLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, iPhoneWidth - 90, 30)];
    _showLab.backgroundColor = [UIColor clearColor];
    _showLab.font = [UIFont systemFontOfSize:15];
    _showLab.textAlignment = NSTextAlignmentLeft;
    _showLab.textColor = UIColorWithRGB(154, 156, 156, 1);
    [_footView addSubview:_showLab];
    
    
}

//TODO:获取数据
- (void)setNode:(SnatchHomeListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
}

//TODO:显示详情
- (void)showDetail:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showGoodsDetailPressed)]) {
        [_delegate showGoodsDetailPressed];
    }
}

//TODO:显示中奖计算详情
- (void)showCountDetailsPressed{
    if (_delegate && [_delegate respondsToSelector:@selector(showCountDetails)]) {
        [_delegate showCountDetails];
    }
}


@end
