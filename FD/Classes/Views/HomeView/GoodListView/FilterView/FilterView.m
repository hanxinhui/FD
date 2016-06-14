//
//  FilterView.m
//  ShowProduct
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "FilterView.h"
#import "FontDefine.h"


#define MENUHEIHT 40

@implementation FilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self commHeadInit];
    }
    return self;
}



#pragma mark UI初始化
//TODO:传人数据



//TODO:初始化数组
-(void)commHeadInit{
    //
    _conScorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, self.frame.size.height - 80) ];
    _conScorllView.backgroundColor = [UIColor blueColor];
    [self addSubview:_conScorllView];
    
    _listArr = [NSMutableArray array];

    
    
    float high = 0;
    
    for (int i = 0; i < 3; i++) {
        SelectBtnScrollView *selectBtnScrollView = [[SelectBtnScrollView alloc] init];
        selectBtnScrollView.frame = CGRectMake(50, high, self.frame.size.width - 65, 90);
        selectBtnScrollView.backgroundColor = [UIColor redColor];
        [_conScorllView addSubview:selectBtnScrollView];
        selectBtnScrollView.nameArray = @[@"全部", @"看图片", @"看视频", @"做任务", @"全部", @"10000及已下", @"10001-100000", @"100001 - 1000000", @"11-20天"];
        selectBtnScrollView.varTag = 1000 * i + 1;
        selectBtnScrollView.nowSelectTag = 0;
        [selectBtnScrollView initWithNameButtons];
        selectBtnScrollView.btnDelegate = self;
        float realityH = [[selectBtnScrollView.buttonOriginYArray objectAtIndex:selectBtnScrollView.buttonOriginYArray.count - 1] floatValue] + 50;
        selectBtnScrollView.frame = CGRectMake(80, high, self.frame.size.width - 65, realityH);
        high = high + realityH + 20;
    }
    
    _conScorllView.contentSize = CGSizeMake(self.frame.size.width, high );
    
    // 取消
    UIButton   *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.frame.size.height - 60, (self.frame.size.width - 20) / 2, 50)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitleColor:UIColorWithRGB(154, 154, 154, 1) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    
    // 确认
    UIButton  *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 20) / 2 + 20, self.frame.size.height - 60, (self.frame.size.width - 20) / 2, 50)];
    sureBtn.backgroundColor = [UIColor clearColor];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn setTitleColor:UIColorWithRGB(154, 154, 154, 1) forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    


}


//TOOD:选择按钮
- (void)selectBtnTag:(id)sender{
    NSLog(@"now selectTag is ====== %@",sender);
}


//TODO:取消
- (void)cancelPressed{
    
}

//TODO:确认
- (void)surePressed{
    
}

@end
