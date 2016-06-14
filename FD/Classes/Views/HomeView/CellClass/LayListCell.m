//
//  LayListCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "LayListCell.h"
#import "FontDefine.h"

@implementation LayListCell

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
    // 图片
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHigh , iPhoneWidth, 325)];
    _bgImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImgView];
    
    //
    _timeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(iPhoneWidth - 140, 23 , 140, 30)];
    _timeImgView.backgroundColor = [UIColor blackColor];
    _timeImgView.alpha = 0.5;
    [self addSubview:_timeImgView];
    
    //
    _stoptLab = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 136, 30)];
    _stoptLab.backgroundColor = [UIColor clearColor];
    _stoptLab.font = [UIFont systemFontOfSize:15];
    _stoptLab.textAlignment = NSTextAlignmentCenter;
//    _stoptLab.text = @"23:59:59";
    _stoptLab.textColor = UIColorWithRGB(252, 250, 251, 1);
    [_timeImgView addSubview:_stoptLab];
    _timeImgView.hidden = YES;
    setHigh = setHigh + 325;
    
    // 底部背景
    _footBGImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, setHigh , iPhoneWidth, 155)];
    _footBGImgView.backgroundColor = UIColorWithRGB(161, 132, 108, 1);
    _footBGImgView.alpha = 0.9;
    [self addSubview:_footBGImgView];
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, setHigh + 10, iPhoneWidth - 40, 45)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = defaultFontSize(17);
    _titleLab.textAlignment = NSTextAlignmentCenter;

    
    _titleLab.textColor = UIColorWithRGB(252, 250, 251, 1);
    [self addSubview:_titleLab];
    
    setHigh = setHigh + 45;

    // 说明
    _conLab= [[UILabel alloc] initWithFrame:CGRectMake(20, setHigh, iPhoneWidth - 40, 30)];
    _conLab.backgroundColor = [UIColor clearColor];
    _conLab.font = defaultFontSize(13);
    _conLab.textAlignment = NSTextAlignmentCenter;

    _conLab.numberOfLines = 0;
    _conLab.textColor = UIColorWithRGB(188, 169, 153, 1);
    [self addSubview:_conLab];
    

    setHigh = setHigh + 30;
    

    _moneynLab = [[UILabel alloc] initWithFrame:CGRectMake((iPhoneWidth - 280)/ 2, setHigh, 165, 30)];
    _moneynLab.backgroundColor = [UIColor clearColor];
    _moneynLab.font = defaultFontSize(13);
    _moneynLab.textAlignment = NSTextAlignmentLeft;

    _moneynLab.numberOfLines = 0;
    _moneynLab.textColor = UIColorWithRGB(188, 169, 153, 1);
    [self addSubview:_moneynLab];
    
    _timeconLab = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneWidth - 120, setHigh, 80, 20)];
    _timeconLab.backgroundColor = [UIColor clearColor];
    _timeconLab.font = defaultFontSize(13);
    _timeconLab.textAlignment = NSTextAlignmentLeft;

    _timeconLab.numberOfLines = 0;
    _timeconLab.textColor = UIColorWithRGB(188, 169, 153, 1);
    [self addSubview:_timeconLab];
    
    
}

//TODO:设置文字
- (void)setTheLab:(CGRect )rect textColor:(UIColor *)color labText:(NSString *)text setFont:(float )font  setCen:(BOOL )cen{
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = text;
    lab.textColor = color;
    if (cen) {
        lab.textAlignment = NSTextAlignmentCenter;
        
    }else{
        lab.textAlignment = NSTextAlignmentLeft;
        
    }
    lab.font = [UIFont systemFontOfSize:font];
    [self addSubview:lab];
}

//TODO:获取数据
- (void)setNode:(LayListNode *)node{
    if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.Btitle;
    self.conLab.text = _node.sub_title;
    self.moneynLab.text = [NSString stringWithFormat:@"保证金（葫芦币）%@",_node.bond];
    [self makeTime];
    
//    self.timeconLab.text = _node.start_time;
    self.timeconLab.text = [NSString stringWithFormat:@"开奖时间 %@",_node.draw_time];
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:node.Bicon] placeholderImage:[UIImage imageNamed:@"Public_NOImg.png"]];
}

//TODO:计算时间
- (void)makeTime{
    djsNum = [_node.stop_time integerValue];

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    _timeImgView.hidden = NO;
    
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    if (djsNum <= 0) {
        self.stoptLab.text = @"报名已结束";
        [theTimer invalidate];
    }else{
        NSInteger day = djsNum / 86400;
        if (day > 1) {
            self.stoptLab.text = [NSString stringWithFormat:@"报名截止:%ld天",(long)day];
        }else{
            self.stoptLab.text = [NSString stringWithFormat:@"报名截止:%@",[self timeFormatted:djsNum]];
            
        }

        
            djsNum--;
        
    }
    
    
}

//TODO:秒数变时间
- (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
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


