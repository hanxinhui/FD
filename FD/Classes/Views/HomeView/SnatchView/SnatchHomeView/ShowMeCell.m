//
//  GoodsListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ShowMeCell.h"
#import "FontDefine.h"
#import "NSString+Extension.h"

@implementation ShowMeCell

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
    float setH = 0;
    // 图标
    UIImageView *lineImgView = [[UIImageView alloc] init];
    lineImgView.frame = CGRectMake(0, setH , iPhoneWidth, 1);
    
    lineImgView.backgroundColor = UIColorWithRGB(238, 238, 243, 1);
    [self addSubview:lineImgView];
    
    setH = 10;
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, setH+5  , 70, 70 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    _headImgView.layer.masksToBounds=YES;
    _headImgView.layer.cornerRadius=70/2.0f;
    [self addSubview:_headImgView];
    
    
    // 昵称
    _nikeNameLab = [[UILabel alloc] initWithFrame:CGRectMake(100, setH, iPhoneWidth - 220, 30)];
    _nikeNameLab.backgroundColor = [UIColor clearColor];
    _nikeNameLab.font = [UIFont boldSystemFontOfSize:15];
    _nikeNameLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _nikeNameLab.text = @"我是一个菠菜啊";
    _nikeNameLab.textColor = UIColorWithRGB(202, 0, 17, 0.6);
    [self addSubview:_nikeNameLab];
    
    // 时间
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 115, setH, 100, 30)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:15];
    _timeLab.textAlignment = NSTextAlignmentRight;
    // leoxu delete
    _timeLab.text = @"01-15 17:22";
    _timeLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_timeLab];
    
    setH = setH + 30;
    
    UIImageView *sanImage = [[UIImageView alloc] init];
    sanImage.frame = CGRectMake(84, setH , 26, 16);
    sanImage.image = [UIImage imageNamed:@"showMe_sanjiao.png"];
    
    [self addSubview:sanImage];

    
    // 背景
    _bgImgView = [[UIImageView alloc] init];
    _bgImgView.frame = CGRectMake(100, setH , iPhoneWidth - 110, 200);
    _bgImgView.backgroundColor = UIColorWithRGB(239, 239, 239, 1);
    _bgImgView.layer.masksToBounds=YES;
    _bgImgView.layer.cornerRadius=10;

    [self addSubview:_bgImgView];
    
    setH = setH+15;
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setH, iPhoneWidth - 120, 30)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _titleLab.text = @"花了23中了,";
    _titleLab.textColor = UIColorWithRGB(75, 75, 75, 1);
    [self addSubview:_titleLab];
    
    setH = setH + 23;
    
    // 商品
    _goodsLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setH, iPhoneWidth - 120, 30)];
    _goodsLab.backgroundColor = [UIColor clearColor];
    _goodsLab.font = [UIFont systemFontOfSize:15];
    _goodsLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _goodsLab.text = @"iPhone 6S Plus（128G） 夏威夷果 假日游 ";
    _goodsLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_goodsLab];
    
    setH = setH + 30;
    // 期号
    [self setTheLab:CGRectMake(110, setH, 60, 20) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"期号:" setFont:15 setCen:NO];
    
    //
    _codeLab= [[UILabel alloc] initWithFrame:CGRectMake(150, setH, iPhoneWidth - 220, 20)];
    _codeLab.backgroundColor = [UIColor clearColor];
    _codeLab.font = [UIFont systemFontOfSize:15];
    _codeLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _codeLab.text = @"212152758";
    _codeLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [self addSubview:_codeLab];
    
    setH = setH + 25;

    // 说明
    _subjectLab = [[UILabel alloc] initWithFrame:CGRectMake(110, setH, iPhoneWidth -130, 60)];
    _subjectLab.backgroundColor = [UIColor clearColor];
   _subjectLab.font = [UIFont systemFontOfSize:14];
    _subjectLab.textAlignment = NSTextAlignmentLeft;
    // leoxu delete
    _subjectLab.text = @"重在参与,不要拘泥于那点小小的甜头,大奖在后面!你懂得！从前有座山，山上有座庙,大王叫我来巡山，巡完南山巡北山，唐僧呢？你傻啊！！";
    _subjectLab.numberOfLines = 0;
    _subjectLab.textColor = UIColorWithRGB(98, 98, 98, 1);
    [self addSubview:_subjectLab];
    
    setH = setH + 50;

    // 显示图片界面
    _showPhotoView = [[UIView alloc] initWithFrame:CGRectMake(110, setH, iPhoneWidth -130, 60)];
    _showPhotoView.backgroundColor = [UIColor clearColor];
    [self addSubview:_showPhotoView];
    
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
- (void)setSnode:(ShowMeNode *)snode{
    if (_snode == snode) return;
    
    _snode = snode;
    
    self.nikeNameLab.text = _snode.nickname;
    self.timeLab.text = [[NSString stringWithFormat:@"%@",_snode.time]substringWithRange:NSMakeRange(5,11)];
    self.titleLab.text = _snode.content;
    self.goodsLab.text = _snode.title;
    self.codeLab.text = _snode.code;
    self.subjectLab.text = _snode.subject;
    CGSize detailSize = [self labelAutoCalculateRectWith:self.subjectLab.text FontSize:14 MaxSize:CGSizeMake(iPhoneWidth -130, MAXFLOAT)];
    if (detailSize.height < 60) {
        self.subjectLab.frame = CGRectMake(110, self.subjectLab.frame.origin.y, iPhoneWidth -130, detailSize.height);
    }
    // 是否有图片
    if ([_snode.src isEqualToString:@""] || _snode.src == nil || _snode.src.length == 0) {
        _showPhotoView.hidden = YES;
        _showPhotoView.frame = CGRectZero;

    }else{
        _showPhotoView.hidden = NO;

        _showPhotoView.frame = CGRectMake(_showPhotoView.frame.origin.x, self.subjectLab.frame.origin.y + self.subjectLab.frame.size.height, iPhoneWidth - 130, 60);
    }
    _bgImgView.frame = CGRectMake(_bgImgView.frame.origin.x, _bgImgView.frame.origin.y, _bgImgView.frame.size.width, _showPhotoView.frame.size.height + 90 + self.subjectLab.frame.size.height + 10);

    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:_snode.avatar] placeholderImage:[UIImage imageNamed:@"Home_head_big.png"]];
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


