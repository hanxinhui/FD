//
//  SelectDataView.m
//  FD
//
//  Created by leoxu on 14-5-22.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "SelectDataView.h"
#import "FontDefine.h"
#import <QuartzCore/QuartzCore.h>


@interface SelectDataView ()
{
    NSArray *provinces, *cities, *areas;
}

@end

@implementation SelectDataView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
        [self commHeadInit];
    }
    return self;
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}


//TODO:初始化数组
-(void)commHeadInit{
    // 确定
    UIButton *bgbtn = [[UIButton alloc] initWithFrame:CGRectMake( 0,0,iPhoneWidth,iPhoneHeight)];
    bgbtn.backgroundColor = [UIColor clearColor];
    [bgbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    bgbtn.tag = 10000;
    [self addSubview:bgbtn];
    
    _locatePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 180, self.frame.size.width, 180)];
    self.locatePicker.dataSource = self;
    self.locatePicker.delegate = self;
    [self addSubview:_locatePicker];
    _locatePicker.backgroundColor = UIColorWithRGB(208, 213, 219, 1);

    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:0] objectForKey:@"childs"];
    
    self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"name"];
    self.locate.city = [[cities objectAtIndex:0] objectForKey:@"name"];
    
    areas = [[cities objectAtIndex:0] objectForKey:@"childs"];
    if (areas.count > 0) {
        self.locate.district = [areas objectAtIndex:0];
    } else{
        self.locate.district = @"";
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,iPhoneHeight - _locatePicker.frame.size.height - 40,iPhoneWidth,40)];
    imgView.backgroundColor = UIColorWithRGB(242, 246, 247, 1);
    [imgView setImage:[UIImage imageNamed:@""]];
    [self addSubview:imgView];
    
    // 取消
    UIButton *cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(10.0,iPhoneHeight - _locatePicker.frame.size.height - 40,50,40)];
    cancelbtn.backgroundColor = [UIColor clearColor];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [cancelbtn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelbtn.tag = 10001;
    [self addSubview:cancelbtn];
    
    // 确定
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake(iPhoneWidth - 60,iPhoneHeight - _locatePicker.frame.size.height - 40,50,40)];
    surebtn.backgroundColor = [UIColor clearColor];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    [surebtn setTitleColor:UIColorWithRGB(89, 91, 93, 1) forState:UIControlStateNormal];
    surebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [surebtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    surebtn.tag = 10002;
    [self addSubview:surebtn];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (_pickerStyle == PickerWithCityArea) {
        return 3;
    }else{
        return 2;

    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            return [areas count];
            
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            
            return [[provinces objectAtIndex:row] objectForKey:@"name"];
            break;
        case 1:
            
            return [[cities objectAtIndex:row] objectForKey:@"name"];
            break;
        case 2:
            if ([areas count] > 0) {
                
                return [[areas objectAtIndex:row] objectForKey:@"name"];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"childs"];
            [self.locatePicker selectRow:0 inComponent:1 animated:YES];
            [self.locatePicker reloadComponent:1];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"childs"];
            if (_pickerStyle == PickerWithCityArea) {
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];

            }
            
            self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"name"];
            self.locate.stateID = [[provinces objectAtIndex:row] objectForKey:@"id"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"name"];
            self.locate.cityID = [[cities objectAtIndex:0] objectForKey:@"id"];
            _provinceStr = [NSString stringWithFormat:@"%@",self.locate.state];
            _cityStr = [NSString stringWithFormat:@"%@",self.locate.city];
            
            if ([areas count] > 0) {
                self.locate.district = [[areas objectAtIndex:0] objectForKey:@"name"];
                self.locate.districtID = [[areas objectAtIndex:0] objectForKey:@"id"];
            } else{
                self.locate.district = @"";
                self.locate.districtID = @"";
                
            }
            break;
        case 1:
            areas = [[cities objectAtIndex:row] objectForKey:@"childs"];
            if (_pickerStyle == PickerWithCityArea) {
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
            }
    

            self.locate.city = [[cities objectAtIndex:row] objectForKey:@"name"];
            _cityStr = [NSString stringWithFormat:@"%@",self.locate.city];

            self.locate.cityID = [[cities objectAtIndex:row] objectForKey:@"id"];
            if ([areas count] > 0) {
                self.locate.district = [[areas objectAtIndex:0] objectForKey:@"name"];
                self.locate.districtID = [[areas objectAtIndex:0] objectForKey:@"id"];
            } else{
                self.locate.district = @"";
                self.locate.districtID = @"";
                
            }
            break;
        case 2:
            if ([areas count] > 0) {
                self.locate.district = [[areas objectAtIndex:row] objectForKey:@"name"];
                self.locate.districtID = [[areas objectAtIndex:row] objectForKey:@"id"];
                
            } else{
                self.locate.district = @"";
                self.locate.districtID = @"";
                
            }
            break;
        default:
            break;
    }
    
//    NSLog(@"选择城市为 === %@ %@ %@",self.locate.state,self.locate.city,self.locate.district);
//    NSLog(@"选择城市id为 === %@,%@,%@",self.locate.stateID,self.locate.cityID,self.locate.districtID);
    if ([self.locate.stateID isEqualToString:@""] || self.locate.stateID == nil || self.locate.stateID.length == 0) {
        self.locate.stateID = @"110000";
    }
    if ([self.locate.cityID isEqualToString:@""] || self.locate.cityID == nil || self.locate.cityID.length == 0) {
        self.locate.cityID = @"110100";
    }
    if (_pickerStyle == PickerWithCityArea) {
        _dataStr = [NSString stringWithFormat:@"%@ %@ %@",self.locate.state,self.locate.city,self.locate.district];
        _dataIDStr = [NSString stringWithFormat:@"%@,%@,%@",self.locate.stateID,self.locate.cityID,self.locate.districtID];
    }else{
        _dataStr = [NSString stringWithFormat:@"%@ %@",self.locate.state,self.locate.city];
        _dataIDStr = [NSString stringWithFormat:@"%@,%@",self.locate.stateID,self.locate.cityID];
    }
    
}



//TODO:显示动画
- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}


- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

//TODO:点击按钮
- (void)btnPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
            // 取消
        case 10000:
        case 10001:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(cancelDataView)]){
                [_delegate cancelDataView];
            }
            
        }
            break;
            // 确定
        case 10002:
        {
            if (_delegate &&[_delegate respondsToSelector:@selector(sureData:dataID:)]){
                if (_dataStr == nil || [_dataStr isEqualToString:@""]) {
                    if (_pickerStyle == PickerWithCity){
                        _dataStr = @"北京 北京市";
                        _dataIDStr = @"110000,110100";
                        _provinceStr = @"北京";
                        _cityStr = @"北京市";
                    }else{
                        _dataStr = @"北京 北京市 东城区";
                        _dataIDStr = @"110000,110100,110101";
                        
                    }
       

                }
                [_delegate sureData:_dataStr dataID:_dataIDStr];
            }
        }
            break;
            
            
        default:
            break;
    }
}
@end
