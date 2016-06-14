//
//  AnyBuyView.m
//  FD
//
//  Created by leoxu on 16/1/11.
//  Copyright © 2016年 leoxu. All rights reserved.
//

#import "AnyBuyView.h"
#import "BuylistNode.h"
#import "FontDefine.h"
#import "AnyBuyCell.h"

@interface AnyBuyView()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)BuylistNode *buylistNode;
@property(nonatomic,copy)NSString*dateString;
@property (nonatomic,strong)NSArray *array;

@end

@implementation AnyBuyView

- (instancetype)init{
    
    self = [super initWithFrame:CGRectMake(0, 60,iPhoneWidth, iPhoneHeight)];

    
    if (self = [super init]) {
        
         _array = @[@"综合排序",@"人气优先",@"最新上线"];
        
        UIButton *whiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        whiteBtn.frame = CGRectMake(0, 10 , iPhoneWidth, 45);
        whiteBtn.backgroundColor = UIColorWithRGB(255, 255, 255,0);
        [whiteBtn addTarget:self action:@selector(boardDownw) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:whiteBtn];

 
        
        UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        blackBtn.frame = CGRectMake(0, 55, iPhoneWidth, iPhoneHeight);
        blackBtn.backgroundColor = UIColorWithRGB(0, 0, 0, 0.7);
        [blackBtn addTarget:self action:@selector(boardDownw) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:blackBtn];
        
        
        UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 54, iPhoneViewWidth, 44*3) style:UITableViewStylePlain];
        
        table.userInteractionEnabled=YES;
        table.delegate=self;
        table.dataSource=self;
        table.backgroundColor=[UIColor clearColor];
        [self addSubview:table];
        
      self.contentViewHegithCons.constant = 0;
        
    }
    return self;
}
-(void)boardDownw{
    
   [self hide];
    
}

- (void)customView{
    [self layoutIfNeeded];
}

#pragma mark - setter && getter
- (BuylistNode *)buylistNode{
    if (!_buylistNode) {
        _buylistNode = [[BuylistNode alloc]init];
    }
    return _buylistNode;
}

#pragma mark - action

//隐藏
- (void)dissmissBtnPress:(UIButton *)sender {
    
//    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [window.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 0;

        
    }];
}
//隐藏
-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
      self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

#pragma mark--uitableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"AnyBuyCell";
    AnyBuyCell *cell = (AnyBuyCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[AnyBuyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.titleLab.text =[_array objectAtIndex:indexPath.row];

    cell.selectImgView.hidden = YES;

    if (_currentIndex == indexPath.row) {
        cell.selectImgView.hidden = NO;
        cell.titleLab.textColor= UIColorWithRGB(258, 95, 80, 1);

    }
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row==_currentIndex){
        return;
    }
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_currentIndex
                                                   inSection:0];
    AnyBuyCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.selectImgView.hidden) {
        newCell.selectImgView.hidden = NO;
    }
    AnyBuyCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (!oldCell.selectImgView.hidden) {
        oldCell.selectImgView.hidden = YES;
    }
    

    if (self.block) {
        
        self.buylistNode.Mylab=[_array objectAtIndex:indexPath.row];
        self.block(self,self.buylistNode);
        
    }
    [self hide];
    
    _currentIndex = indexPath.row;
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectNowPressed:)]){
        [_delegate selectNowPressed:_currentIndex];
    }
}


@end
