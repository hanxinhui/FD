//
//  HomeCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "HomeCell.h"
#import "FontDefine.h"

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self creat];
    }
    return self;
}

//TODO:传入数据
- (void)setHomeNode:(HomeNode *)homeNode{
    if(_homeNode == homeNode){
        return;
    }
    _homeNode = homeNode;
//    NSLog(@"_homeNode id is === %@ ,_homeNode img is === %@ ",_homeNode.Hid,_homeNode.Hcover);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_homeNode.Hcover] placeholderImage:nil];
    [self.VICimgView setImage:self.imgView.image];
    if (_canAim) {
        _imgView.hidden = NO;
    }else{
        _imgView.hidden = YES;

    }
    
}

//TODO:初始化数据
- (void)creat{
    // 显示图片
    UIImageView *bgimgView = [[UIImageView alloc] initWithFrame:CGRectMake((iPhoneWidth - 110 ) / 2, 55,  110, 90)];
    bgimgView.backgroundColor = [UIColor clearColor];
    [bgimgView setImage:[UIImage imageNamed:@"list_noImg.png"]];
    [self addSubview:bgimgView];
    
    // 显示图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , 200)];
    _imgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imgView];

    // 显示图片
    _VICimgView = [[VICMAImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth , 200)];
    _VICimgView.backgroundColor = [UIColor clearColor];
    [_VICimgView setImage:nil];
    [self addSubview:_VICimgView];
//    [self insertSubview:_VICimgView atIndex:0];

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


