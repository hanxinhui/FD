//
//  MyBagListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "MyBagListCell.h"
#import "FontDefine.h"

@implementation MyBagListCell

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

    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10  , 50, 50 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 12, 100, 30)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:18];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.text = @"福利夺宝";
    _titleLab.textColor = UIColorWithRGB(45, 47, 47, 1);
    [self addSubview:_titleLab];

    // 来自
    _formLab = [[MMLabel alloc] initWithFrame:CGRectMake(150, 15, iPhoneWidth - 220, 30)];
    _formLab.backgroundColor = [UIColor clearColor];
    _formLab.font = [UIFont systemFontOfSize:13];
    _formLab.textAlignment = NSTextAlignmentLeft;
    _formLab.textColor = UIColorWithRGB(45, 47, 47, 1);
    [self addSubview:_formLab];
    _formLab.keyWordColor=UIColorWithRGB(107, 107, 108, 0.6);
    [self addSubview:_formLab];

    
    // 时间&个数
    _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 150, 10, 140, 40)];
    _timeLab.backgroundColor = [UIColor clearColor];
    _timeLab.font = [UIFont systemFontOfSize:13];
    _timeLab.textAlignment = NSTextAlignmentRight;
    _timeLab.numberOfLines = 0;
    _timeLab.textColor = UIColorWithRGB(179, 180, 181, 1);
    [self addSubview:_timeLab];
    
    // 说明
    _conLab= [[UILabel alloc] initWithFrame:CGRectMake(70,35, iPhoneWidth - 150, 30)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.font = [UIFont systemFontOfSize:13];
    _conLab.textAlignment = NSTextAlignmentLeft;
    _conLab.textColor = UIColorWithRGB(155, 155, 155, 0.7);
    [self addSubview:_conLab];
    
    // 状态
    _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 90, 35, 80, 30)];
    _typeLab.backgroundColor = [UIColor clearColor];
    _typeLab.font = [UIFont systemFontOfSize:16];
    _typeLab.textAlignment = NSTextAlignmentRight;
    _typeLab.textColor = UIColorWithRGB(155, 155, 155, 0.7);
    [self addSubview:_typeLab];
    
    
}


//TODO:获取数据
- (void)setNode:(MyBagListNode *)node{
    if (_node == node) return;
    
    _node = node;

    if (_isMyin){
        _formLab.hidden = NO;
        NSString *formstr = [NSString stringWithFormat:@"来自%@",_node.nickname];
        _formLab.text = formstr;
        _formLab.keyWord=@"来自";
    }else{
        _formLab.hidden = YES;
   

    }
    //1 福利抢宝  2 群抢宝 3 心愿单 （icon也不一样）
    switch (_node.kind) {
        case 1:
        {
            self.titleLab.text = @"福利抢宝";
            [self.headImgView setImage:[UIImage imageNamed:@"indiana_password_kind_icon_01.png"]];
 
        }

            break;
        case 2:{
            self.titleLab.text = @"群抢宝";
            [self.headImgView setImage:[UIImage imageNamed:@"indiana_password_kind_icon_02.png"]];
            
        }

            break;
        case 3:{
            self.titleLab.text = @"心愿单";
            [self.headImgView setImage:[UIImage imageNamed:@"myBag_xinyuan_icon.png"]];
            
        }

            break;
        default:
            break;
    }
//1 参与中  2 已揭晓 3 等待开奖
    switch (_node.status) {
        case -1:{
            _typeLab.text = @"已取消";
            _typeLab.textColor = UIColorWithRGB(155, 155, 155, 1);
        }
   
            break;
        case 1:{
            _typeLab.text = @"进行中";
            _typeLab.textColor = UIColorWithRGB(238, 95, 80, 1);

        }
                        break;
        case 2:{
            _typeLab.text = @"已开奖";
            _typeLab.textColor = UIColorWithRGB(155, 155, 155, 1);
            

        }
            break;
        case 3:{
            _typeLab.text = @"揭晓中";
            _typeLab.textColor = UIColorWithRGB(250, 230, 153, 1);
        }
            
            break;
        default:
            break;
    }
    self.conLab.text = _node.title;
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


