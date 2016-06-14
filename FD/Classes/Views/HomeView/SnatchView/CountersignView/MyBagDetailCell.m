//
//  MyBagDetailCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBagDetailCell.h"
#import "FontDefine.h"

@implementation MyBagDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
    }
    return self;
}

//TODO:初始化数据
- (void)creat{
    
    float setHeight = 10;
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    [_headImgView setImage:[UIImage imageNamed:@"Home_head_big.png"]];
    _headImgView.layer.cornerRadius = 25;
    _headImgView.layer.masksToBounds = YES;

    // 图片
    _luckImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60 )];
    _luckImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_luckImgView];
    [_luckImgView setImage:[UIImage imageNamed:@"indiana_win.png"]];
    _luckImgView.hidden = YES;
    
    if (iPhoneWidth>320) {
        // 抢宝人
        _luckLab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight, iPhoneWidth - 160, 25)];
        _luckLab.backgroundColor = [UIColor clearColor];
        _luckLab.font = [UIFont systemFontOfSize:18];
        _luckLab.textAlignment = NSTextAlignmentLeft;
        _luckLab.textColor = UIColorWithRGB(0, 0, 0, 1);
        [self addSubview:_luckLab];
        
        // 抢宝号码
        _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, setHeight, 110, 25)];
        _codeLab.backgroundColor = [UIColor clearColor];
        _codeLab.font = [UIFont systemFontOfSize:18];
        _codeLab.textAlignment = NSTextAlignmentRight;
        _codeLab.textColor = UIColorWithRGB(0, 0, 0, 1);
        [self addSubview:_codeLab];
    }else{
        // 抢宝人
        _luckLab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight, iPhoneWidth - 160, 25)];
        _luckLab.backgroundColor = [UIColor clearColor];
        _luckLab.font = [UIFont systemFontOfSize:15];
        _luckLab.textAlignment = NSTextAlignmentLeft;
        _luckLab.textColor = UIColorWithRGB(0, 0, 0, 1);
        [self addSubview:_luckLab];
        
        // 抢宝号码
        _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, setHeight, 110, 25)];
        _codeLab.backgroundColor = [UIColor clearColor];
        _codeLab.font = [UIFont systemFontOfSize:15];
        _codeLab.textAlignment = NSTextAlignmentRight;
        _codeLab.textColor = UIColorWithRGB(0, 0, 0, 1);
        [self addSubview:_codeLab];

    }
    
    // 参与次数
    _addnumLab = [[MMLabel alloc] initWithFrame:CGRectMake(iPhoneWidth / 2, setHeight , iPhoneWidth / 2-10, 25)];
    _addnumLab.backgroundColor = [UIColor clearColor];
    _addnumLab.font = [UIFont systemFontOfSize:15];
    _addnumLab.textAlignment = NSTextAlignmentRight;
    _addnumLab.textColor = UIColorWithRGB(51, 51, 51, 1);
    _addnumLab.keyWordColor = UIColorWithRGB(206, 52, 21, 1);
    [self addSubview:_addnumLab];
    

    setHeight = setHeight+25;
    
    _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, setHeight, 80, 35)];
    _detailBtn.backgroundColor = [UIColor clearColor];
    [self addSubview: _detailBtn];
    [ _detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [ _detailBtn setTitleColor:UIColorWithRGB(6, 33, 230, 1) forState:UIControlStateNormal];
    [ _detailBtn addTarget:self action:@selector(detailBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    _detailBtn.titleLabel.font = defaultFontSize(15);

    // 继续参与
    _addmoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth-105, setHeight, 100, 20)];
    _addmoreBtn.backgroundColor = [UIColor whiteColor];
//    [_addmoreBtn addTarget:self action:@selector(addMorePressed) forControlEvents:UIControlEventTouchUpInside];
    [_addmoreBtn setTitle:@"继续参与" forState:UIControlStateNormal];
    [_addmoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    _addmoreBtn.titleLabel.font = defaultFontSize(10);
    [_addmoreBtn.layer setBorderWidth:1.0f];
    [_addmoreBtn.layer setBorderColor:UIColorWithRGB(177, 177, 177, 1).CGColor];
    [_addmoreBtn.layer setMasksToBounds:YES];
    [_addmoreBtn.layer setCornerRadius:5];
//    [self addSubview:_addmoreBtn];
    
    // 立即参与
    _addnowBtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth -105, setHeight, 100, 20)];
    _addnowBtn.backgroundColor = [UIColor clearColor];
//    [_addnowBtn addTarget:self action:@selector(addMorePressed) forControlEvents:UIControlEventTouchUpInside];
    [_addnowBtn setTitle:@"立即参与" forState:UIControlStateNormal];
    [_addnowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addnowBtn.titleLabel.font = defaultFontSize(10);
    [_addnowBtn.layer setBorderWidth:1.0f];
    [_addnowBtn.layer setBorderColor:UIColorWithRGB(177, 177, 177, 1).CGColor];
    [_addnowBtn.layer setMasksToBounds:YES];
    [_addnowBtn.layer setCornerRadius:5];
//    [self addSubview:_addnowBtn];
    
    // 时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(70, setHeight, iPhoneWidth - 110, 25)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:13];
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.textColor = UIColorWithRGB(171, 173, 173, 1);
    [self addSubview:_timeLab];
 
    
    // 抢宝号码
    UILabel *scodeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, setHeight, 110, 25)];
    scodeLab.backgroundColor = [UIColor clearColor];
    scodeLab.font = [UIFont systemFontOfSize:13];
    scodeLab.textAlignment = NSTextAlignmentRight;
    scodeLab.text = @"抢宝号码";
    scodeLab.textColor = UIColorWithRGB(171, 173, 173, 1);
//    [self addSubview:scodeLab];
    
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentRight;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
}

//TODO:获取数据
- (void)setNode:(MyBagDetailListNode *)node{
    if (_node == node) return;
    
    _node = node;
    _detailBtn.tag = _detailTag;
    self.luckLab.text = _node.nickname;
    self.timeLab.text = _node.time;
    self.codeLab.text = _node.code;

    switch (_cellStyle) {
        case WelfareCell:
        {
            self.timeLab.hidden = NO;
            self.codeLab.hidden = NO;
            self.addmoreBtn.hidden = YES;
            self.addnowBtn.hidden = YES;
            self.addnumLab.hidden = YES;
            self.detailBtn.hidden = YES;
            
        }
            break;
        case GroupCell:
        {
            self.timeLab.hidden = YES;
            self.codeLab.hidden = YES;
            self.addnumLab.hidden = NO;

            self.addnumLab.text = [NSString stringWithFormat:@"参与了%@人次",_node.count];
            self.addnumLab.keyWord = [NSString stringWithFormat:@"%@",_node.count];

            _addnumLab.frame = CGRectMake(iPhoneWidth / 3*2, 0 , iPhoneWidth / 3-10, 70);

            NSString *getName = [NSString stringWithFormat:@"%@",_node.nickname];
            
            NSString *myName = [NSString stringWithFormat:@"%@",[UserDataManager sharedUserDataManager].userData.Unike];
            if (myName == [UserDataManager sharedUserDataManager].userData.UPhone || [myName isEqualToString:[UserDataManager sharedUserDataManager].userData.UPhone] || myName) {
                NSMutableString *phoneN = [NSMutableString stringWithFormat:@"%@",[UserDataManager sharedUserDataManager].userData.UPhone];
                [phoneN replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                myName = phoneN;
            }
            if (![getName isEqualToString:myName] ) {
                self.addnowBtn.hidden = YES;
                self.addmoreBtn.hidden = YES;
 
            }
            
        }
            break;
        default:
            break;
    }
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.avatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//TODO:查看详情
-(void)detailBtnPressed:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(showDetailPressed:)]){
        [_delegate showDetailPressed:sender];
    }

    
}

////TODO:立即参与
//- (void)addNowPressed{
//    if (_delegate && [_delegate respondsToSelector:@selector(joinPayPressed)]){
//        [_delegate joinPayPressed];
//    }
//}

////TODO:继续参与
//- (void)addMorePressed{
//    if (_delegate && [_delegate respondsToSelector:@selector(joinPayPressed)]){
//        [_delegate joinPayPressed];
//    }
//}
@end


