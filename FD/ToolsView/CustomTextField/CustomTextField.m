//
//  CustomTextField.m
//  lightsOut
//
//  Created by Leoxu on 13-7-13.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import "CustomTextField.h"
#import "SystemStateManager.h"

@implementation CustomTextField
@synthesize horizontalPadding, verticalPadding;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
//    [_placeHoldColor release];
//    [_placeHoldFont release];
//    [super dealloc];
}

////控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
//}

////控制placeHolder的位置，左右缩20
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    return CGRectInset(bounds, 20, 0);
//}
////控制显示文本的位置
//-(CGRect)textRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
//    
//}

- (CGRect)textRectForBounds:(CGRect)bounds{
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y + verticalPadding, bounds.size.width - horizontalPadding*2, bounds.size.height - verticalPadding*2);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if ([SystemStateManager sharedSystemStateManager].isIOS7) {
        return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y + verticalPadding + (bounds.size.height - self.font.ascender*1.2 )/2-1, bounds.size.width - horizontalPadding*2, bounds.size.height - verticalPadding*2);
    }
    return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y , bounds.size.width - horizontalPadding*2, bounds.size.height - verticalPadding*2);
}

////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+5, bounds.origin.y+ (bounds.size.height - 11)/2, 11, 11);
    return inset;
    //return CGRectInset(bounds,50,0);
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    if (_placeHoldColor) {
       [_placeHoldColor setFill];
    }
    else
        [[UIColor lightGrayColor] setFill];
    
    if (_placeHoldFont) {
        
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName: _placeHoldFont, NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: _placeHoldColor};
        [[self placeholder] drawInRect:rect withAttributes:attributes];
 
    }
    else{
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13], NSParagraphStyleAttributeName: style, NSForegroundColorAttributeName: [UIColor lightGrayColor]};
        [[self placeholder] drawInRect:rect withAttributes:attributes];
 
        
    }

}


@end
