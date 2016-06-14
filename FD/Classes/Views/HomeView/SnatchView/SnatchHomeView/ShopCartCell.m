//
//  ShopCartCell.m
//  tableview
//
//  Created by leoxu on 14-9-8.
//  Copyright (c) 2014年 leoxu. All rights reserved.
//

#import "ShopCartCell.h"
#import "FontDefine.h"
#import "AppDelegate.h"

@implementation ShopCartCell

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
    _diView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth  + 50, 140)];
    _diView.backgroundColor = [UIColor clearColor];
    [self addSubview:_diView];
    
    float setH = 10.0;
   
    // 图片
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10+ 60, setH  , 40, 80 )];
    _headImgView.backgroundColor = [UIColor clearColor];
    [_diView addSubview:_headImgView];
    
    
    // 标题
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(90+ 50, setH-5, iPhoneWidth - 120, 40)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    
    _titleLab.textColor = UIColorWithRGB(90, 91, 92, 1);
    [_diView addSubview:_titleLab];
    
    setH = setH + 30;
    
    // 总需人次
   _allnumLab = [[UILabel alloc] initWithFrame:CGRectMake(90+ 50, setH, 180, 25)];
    _allnumLab.backgroundColor = [UIColor clearColor];
    _allnumLab.font = [UIFont systemFontOfSize:13];
    _allnumLab.textAlignment = NSTextAlignmentLeft;
    _allnumLab.textColor = UIColorWithRGB(155, 155, 155, 1);
    [_diView addSubview:_allnumLab];
    
    // 剩余人次
    _surplusNumLab = [[UILabel alloc] initWithFrame:CGRectMake(250+20, setH, 50, 25)];
    _surplusNumLab.backgroundColor = [UIColor clearColor];
    _surplusNumLab.font = [UIFont systemFontOfSize:13];
    _surplusNumLab.textAlignment = NSTextAlignmentLeft;
    _surplusNumLab.textColor = UIColorWithRGB(56, 147, 231, 1);
    [_diView addSubview:_surplusNumLab];
    
    // 人次
    [self setTheLab:CGRectMake(270+30, setH, 50, 25) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"人次" setFont:13 setCen:NO];
   
    setH = setH + 25;
    
    // 参与人次
    [self setTheLab:CGRectMake(140, setH, 80, 45) textColor:UIColorWithRGB(155, 155, 155, 1) labText:@"参与人次" setFont:14 setCen:NO];
    
    
    UIButton *borderBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, setH+5, 144 +(iPhoneWidth - 320)/2, 38)];
     borderBtn.backgroundColor = UIColorWithRGB(255, 255, 255, 1);
    [borderBtn.layer setMasksToBounds:YES];
    [borderBtn.layer setCornerRadius:3.0];
    [borderBtn.layer setBorderWidth:1.0];
    [borderBtn.layer setBorderColor:[UIColorWithRGB(204, 205, 205, 1) CGColor]];
    [_diView addSubview:borderBtn];


    // 减少数量
    _lessBtn = [[UIButton alloc] initWithFrame:CGRectMake(201 , setH+6, 42, 36)];
   _lessBtn.backgroundColor = UIColorWithRGB(241, 242, 243, 1);
   
      [_lessBtn setImage:[UIImage imageNamed:@"ShoppingCart_LessBtn.png"] forState:UIControlStateNormal];
    

    [_lessBtn addTarget:self action:@selector(lessGoods:) forControlEvents:UIControlEventTouchUpInside];
    [_diView addSubview:_lessBtn];
    
    UIImageView *linImg = [[UIImageView alloc]initWithFrame:CGRectMake(243, setH+5, 1, 38)];
    linImg.backgroundColor = UIColorWithRGB(233, 234, 235, 1);
    [_diView addSubview:linImg];

    
    _innumTextField = [[UITextField alloc] initWithFrame:CGRectMake(243, setH+5, 60+ (iPhoneWidth - 320)/ 2, 38)];
    _innumTextField.backgroundColor = [UIColor clearColor];
    _innumTextField.delegate = self;
    _innumTextField.textAlignment = NSTextAlignmentCenter;
    _innumTextField.textColor = UIColorWithRGB(204, 35, 67, 1);
    _innumTextField.text = @"11";
//    _innumTextField.borderStyle =UITextBorderStyleLine;
    _innumTextField.font = defaultFontSize(15);
    [_diView addSubview:_innumTextField];
    _innumTextField.keyboardType = UIKeyboardTypeNumberPad;

    
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(300+ (iPhoneWidth - 320)/ 2, setH+5, 1, 38)];
    lineImg.backgroundColor = UIColorWithRGB(233, 234, 235, 1);
    [_diView addSubview:lineImg];
                                       
    
    // 增加数量
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(300 + (iPhoneWidth - 320)/ 2, setH+5, 42, 38)];
    _addBtn.backgroundColor = [UIColor clearColor];

    [_addBtn setImage:[UIImage imageNamed:@"ShoppingCart_AddBtn.png"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    [_diView addSubview:_addBtn];
    
    setH = setH + 50;

    
    // 是否提示倍数
    _showLab= [[UILabel alloc] initWithFrame:CGRectMake(200, setH, iPhoneWidth - 150, 20)];
    _showLab.backgroundColor = [UIColor clearColor];
    _showLab.font = [UIFont systemFontOfSize:13];
    _showLab.textAlignment = NSTextAlignmentLeft;
    _showLab.textColor = UIColorWithRGB(204, 35, 67, 1);
    [_diView addSubview:_showLab];
    
    // 是否选中图标
    _m_checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-35+ 50, 75  , 30, 30 )];
    _m_checkImageView.backgroundColor = [UIColor clearColor];
    
//    [_diView addSubview:_m_checkImageView];
    
    //选择按钮
    _secBtn = [[UIButton alloc] initWithFrame:CGRectMake(-35+ 45, 75  , 30, 30 )];
    _secBtn.backgroundColor = [UIColor clearColor];
    [_secBtn addTarget:self action:@selector(getChecker:) forControlEvents:UIControlEventTouchUpInside];
    [_secBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];
    [_secBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"] forState:UIControlStateSelected];
    [_diView addSubview:_secBtn];
}

//取消键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_innumTextField resignFirstResponder];
    
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
    [_diView addSubview:lab];
}

//TODO:获取数据
- (void)setNode:(ShopCartNode *)node{
     if (_node == node) return;
    
    _node = node;
    
    self.titleLab.text = _node.title;
    self.allnumLab.text = [NSString stringWithFormat:@"总需:%@人次，剩余",_node.price];
    NSInteger sy = [_node.price integerValue] - [_node.progress integerValue];
    self.surplusNumLab.text = [NSString stringWithFormat:@"%ld",(long)sy];
    self.innumTextField.text = _node.count;
    self.showLab.hidden = NO;

    
    if ([_node.step integerValue] > 0) {
        self.showLab.text = [NSString stringWithFormat:@"参与人次需是%@的倍数",_node.step];
        self.showLab.hidden = NO;
        
    }
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:node.thumb] placeholderImage:[UIImage imageNamed:@"listMoren.png"]];
}

//TODO:判断输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //    NSLog(@"string ==== %@",string);
    //    NSLog(@"textField ==== %@",textField.text);
    //    NSLog(@"range ==== %lu",(unsigned long)range.length);
    NSString *str;
    if (range.length == 0) {
        str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }else{
        str = [textField.text substringToIndex:textField.text.length - 1];
        
    }
    NSInteger money = [str integerValue];
    
    if ([_surplusNumLab.text integerValue]  < money) {
        if (_delegate &&[_delegate respondsToSelector:@selector(showAlertMsgPressed:)]){
            
            [_delegate showAlertMsgPressed:@"已经超过最大可选数量"];
            _innumTextField.text = _surplusNumLab.text;
            return NO;
            
        }
    }
    if (money == 0){
        if (_delegate &&[_delegate respondsToSelector:@selector(showAlertMsgPressed:)]){
            
            [_delegate showAlertMsgPressed:@"可选数量不可为空"];
            _innumTextField.text = [NSString stringWithFormat:@"%@",_node.step];
            return NO;
        }
        
    }
    
    
    return YES;
    
}

- (void)awakeFromNib
{
    // Initialization code
}
// TODO:选择cell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void) setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated
{
    if (animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        _diView.center = pt;

        [UIView commitAnimations];
    }
    else
    {
        _diView.center = pt;
//        _m_checkImageView.alpha = alpha;
        
    }
}


- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{

    [self setChecked:m_checked];

    if (editting) {
        
    [self setCheckImageViewCenter:CGPointMake(_diView.center.x, _diView.center.y)
                                       alpha:1.0 animated:animated];
        _secBtn.hidden = NO;

    }else{
        [self setCheckImageViewCenter:CGPointMake(_diView.center.x-50, _diView.center.y)
                                alpha:1.0 animated:animated];
        _secBtn.hidden = YES;

    }
    

    _secBtn.exclusiveTouch = YES;
    
   }


// TODO:选择cell
- (void) setChecked:(BOOL)checked
{
    if (checked)
    {
        [_secBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_Yes.png"] forState:UIControlStateNormal];

    }
    else
    {
        
        [_secBtn setImage:[UIImage imageNamed:@"ShoppingCart_Choose_No.png"] forState:UIControlStateNormal];

    }
    m_checked = checked;
}




//TODO: 按钮选中
- (void)getChecker:(id)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(getchecheerPressed:)]) {
        [_delegate getchecheerPressed:sender];
    }
}

//TODO:移除商品
- (void)lessGoods:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector (lessGoodsPressed:)]) {
        [_delegate lessGoodsPressed:sender];
    }
    
}

//TODO:添加商品
- (void)addGoods:(id)sender{
    if ([_innumTextField.text integerValue] > [_surplusNumLab.text integerValue]){
        if (_delegate &&[_delegate respondsToSelector:@selector(showAlertMsgPressed:)]){
            
            [_delegate showAlertMsgPressed:@"已经超过最大可选数量"];
            _innumTextField.text = _surplusNumLab.text;
            
        }
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(addGoodsPressed:)]) {
        [_delegate addGoodsPressed:sender];
    }
}

@end


