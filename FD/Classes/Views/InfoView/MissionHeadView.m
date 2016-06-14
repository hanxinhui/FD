//
//  MissionHeadView.m
//  FD
//
//  Created by Leo on 15-7-10.
//  Copyright (c) 2015年 Leo. All rights reserved.
//

#import "MissionHeadView.h"
#import "PropertyNode.h"
#import "FontDefine.h"

@interface MissionHeadView()
{
    UIButton *_bgButton;
    UILabel *_numLabel;
    UILabel *_haveLabel;
}
@end

@implementation MissionHeadView

+(instancetype)headViewWithTableView:(UITableView *)tableView getRow:(NSInteger)row
{
    static NSString *headIdentifier = @"header";
    MissionHeadView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[MissionHeadView alloc] initWithReuseIdentifier:headIdentifier getRow:row];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier getRow:(NSInteger)row
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bgButton];
        bgButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _bgButton = bgButton;
        bgButton.tag = row;
   

        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:numLabel];
//        numLabel.textColor = [UIColor redColor];
        numLabel.textColor = UIColorWithRGB(203, 15, 27, 0.8);

        _numLabel = numLabel;
        _numLabel.font = [UIFont systemFontOfSize:15];

        
        UILabel *haveLabel = [[UILabel alloc] init];
        haveLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:haveLabel];
//        haveLabel.textColor = [UIColor greenColor];
        haveLabel.textColor = UIColorWithRGB(70, 154, 19, 0.8);

        _haveLabel = haveLabel;
        _haveLabel.font = [UIFont systemFontOfSize:15];

        self.backgroundColor = UIColorWithRGB(232, 232, 232, 1.0);
    }
    return self;
}

- (void)headBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    _propertyNode.opened = !_propertyNode.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView:)]) {
        [_delegate clickHeadView:tag];
    }
}

- (void)setPropertyNode:(PropertyNode *)propertyNode
{
    _propertyNode = propertyNode;
    
    [_bgButton setTitle:propertyNode.pname forState:UIControlStateNormal];
    _numLabel.text = [NSString stringWithFormat:@"%@", propertyNode.pin];
    _haveLabel.text = [NSString stringWithFormat:@"%@",propertyNode.pout];
}

- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _propertyNode.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _numLabel.frame = CGRectMake(self.frame.size.width/3, 15, self.frame.size.width/3, self.frame.size.height- 10);

    UIImageView *sLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/7*2, 13, 1, self.frame.size.height - 26)];
    sLineImgView.backgroundColor = UIColorWithRGB(177, 177, 177, 0.3);
    [self addSubview:sLineImgView];
    
    // 收入
    UILabel *numTLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3, 5, self.frame.size.width/3, 25)];
    numTLabel.textAlignment = NSTextAlignmentLeft;
    numTLabel.text = @"收入(葫芦币)";
    numTLabel.textColor = UIColorWithRGB(173, 173, 173, 1.0);
    [self addSubview:numTLabel];
    numTLabel.font = [UIFont systemFontOfSize:9];
    
    // 支出
    UILabel *haveTLabel = [[UILabel alloc] initWithFrame:CGRectMake(iPhoneViewWidth / 3 * 2, 5, iPhoneViewWidth / 4 , 25)];
    haveTLabel.textAlignment = NSTextAlignmentLeft;
    haveTLabel.text = @"支出(葫芦币)";
    haveTLabel.textColor = UIColorWithRGB(173, 173, 173, 1.0);
    [self addSubview:haveTLabel];
    haveTLabel.font = [UIFont systemFontOfSize:9];
    _haveLabel.frame = CGRectMake(iPhoneViewWidth / 3 * 2, 15, iPhoneViewWidth / 4 , self.frame.size.height- 10);
    
//    UIImageView *hLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
//    hLineImgView.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:hLineImgView];
//    
    UIImageView *fLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.frame.size.height - 3, self.frame.size.width, 3)];
    fLineImgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:fLineImgView];
}

@end
