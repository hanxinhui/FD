//
//  MyBankListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBankListCell.h"
#import "FontDefine.h"

@implementation MyBankListCell

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
//    // 图标
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, 0 , iPhoneWidth, 8);
    
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [self addSubview:lineImgView];
    self.backgroundColor = [UIColor clearColor];
    
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 19  , 50, 50 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 标题
    _bankLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 5 + 8, iPhoneWidth - 90, 30)];
    _bankLab.backgroundColor = [UIColor clearColor];
    _bankLab.font = [UIFont systemFontOfSize:15];
    _bankLab.textAlignment = NSTextAlignmentLeft;

    //    _titleLab.numberOfLines = 0;
    
    _bankLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_bankLab];
    
    // 卡号
    _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 35+ 8, 120, 30)];
    _codeLab.backgroundColor = [UIColor clearColor];
    _codeLab.font = [UIFont systemFontOfSize:13];
    _codeLab.textAlignment = NSTextAlignmentLeft;

    _codeLab.numberOfLines = 0;
    _codeLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_codeLab];
    
    // 类型
    _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(200, 35+ 8, 120, 30)];
    _typeLab.backgroundColor = [UIColor clearColor];
    _typeLab.font = [UIFont systemFontOfSize:13];
    _typeLab.textAlignment = NSTextAlignmentLeft;

    _typeLab.numberOfLines = 0;
    _typeLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_typeLab];

    
}


//TODO:获取数据
- (void)setNode:(MyBankListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.bankLab.text = _node.bank;
    self.codeLab.text = [NSString stringWithFormat:@"%@ 尾号",_node.lastno];
    if ([_node.cardtype integerValue] == 1) {
        self.typeLab.text = @"借记卡";

    }
    else if ([_node.cardtype integerValue] == 2) {
        self.typeLab.text = @"信用卡";
        
    }

    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.icon] placeholderImage:[UIImage imageNamed:@"Public_list_noImg.png"]];
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


@end


