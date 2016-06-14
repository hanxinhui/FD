//
//  AnyBuyCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "AnyBuyCell.h"
#import "FontDefine.h"

@implementation AnyBuyCell

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

    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, iPhoneWidth - 40, 42)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
   
    
    _titleLab.textColor = UIColorWithRGB(153, 153, 153, 1);
    [self addSubview:_titleLab];
    
    // 选中图标
   
    _selectImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 30, 15, 17, 14)];
    _selectImgView.image = [UIImage imageNamed:@"AnyBuy_Yes.png"];
    [self addSubview:_selectImgView];
    
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


