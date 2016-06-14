//
//  BuyListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyNewsListCell.h"
#import "FontDefine.h"

@implementation MyNewsListCell

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
    // 图标
    float  setHigh = 0.0;

    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
    leftImgView.backgroundColor = [UIColor clearColor];
    [leftImgView setImage:[UIImage imageNamed:@"MyNews_Icon.png"]];
    [self addSubview:leftImgView];
    
    // 类型
    _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(27, 15, 50, 50)];
    _typeLab.backgroundColor = [UIColor clearColor];
    _typeLab.font = [UIFont systemFontOfSize:18];
    _typeLab.textAlignment = NSTextAlignmentLeft;

    _typeLab.numberOfLines = 0;
    _typeLab.textColor = UIColorWithRGB(255, 255,255, 1);
    [self addSubview:_typeLab];
    
    // 来源
    _formLab = [[UILabel alloc] initWithFrame:CGRectMake(90, setHigh , iPhoneWidth - 90 - 110, 45)];
    _formLab.backgroundColor = [UIColor clearColor];
    _formLab.font = [UIFont systemFontOfSize:17] ;
    _formLab.textAlignment = NSTextAlignmentLeft;

    _formLab.numberOfLines = 0;
    _formLab.textColor = UIColorWithRGB(0, 0, 0, 1);
    [self addSubview:_formLab];
    
    setHigh = setHigh + 40;
    

    // 时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 110, 0, 100, 45)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:11];
    _timeLab.textAlignment = NSTextAlignmentRight;

    _timeLab.numberOfLines = 0;
    _timeLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_timeLab];
    
    setHigh = setHigh + 40;

    // 正文
    _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 40 , iPhoneWidth - 100, 40)];
    _contentLab.backgroundColor = [UIColor clearColor];
    _contentLab.font = [UIFont systemFontOfSize:13];
    _contentLab.textAlignment = NSTextAlignmentLeft;

    _contentLab.numberOfLines = 0;
    _contentLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_contentLab];
    

}

//TODO:获取数据
- (void)setNode:(MyNewsListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.formLab.text = node.Ntitle;
    self.contentLab.text = _node.Ncontent;
    CGSize titleSize = [_node.Ncontent boundingRectWithSize:CGSizeMake(iPhoneWidth - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    float setHh = 40;
    if (titleSize.height > 40 ) {
        setHh = titleSize.height + 5;
    }
    _contentLab.frame = CGRectMake(90, 40 , iPhoneWidth - 100, setHh);

    if ([_node.to_uid integerValue ]!= [UserDataManager sharedUserDataManager].userData.UID ) {
        self.typeLab.text = @"系统消息";

    }else{
        self.typeLab.text = @"其他消息";

    }
    self.timeLab.text = _node.Ntime;

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


