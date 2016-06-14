//
//  CustomSearchBar.m
//  Deji_Plaza
//
//  Created by Leoxu on 13-1-7.
//  Copyright (c) 2013年 Leoxu. All rights reserved.
//

#import "CustomSearchBar.h"
#import "FontDefine.h"
@implementation CustomSearchBar

#pragma mark===========初始化================
/**   函数作用 :初始化界面
 **   函数参数 :
 **   函数返回值:
 **/
-(void)initView
{
    self.backgroundColor=[UIColor clearColor];
    UIImageView *bagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [bagImgView setImage:[UIImage imageNamed:@"Home_Search.png"]];
    [self addSubview:bagImgView];
    
    float version = [[[ UIDevice currentDevice ] systemVersion ] floatValue ];
    
    if (version > 7)
        
    {
        
        //iOS7.1
        
        [[[[ self.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        [ self setBackgroundColor :[ UIColor clearColor ]];
        
    }
    else if (IOS7) {
        if ([ self  respondsToSelector: @selector (barTintColor)]) {
            [ self  setBarTintColor:[UIColor clearColor]];
        }
    }
    else
    {
        for (UIView *subView in self.subviews) {
            //背景透明
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subView removeFromSuperview];
            }
        }
    }
    
    
    //背景
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[MHFile getResourcesFile:@"searchBar_bg.png"]]];
//    imageView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height );
//    [self insertSubview:imageView atIndex:0];
//    [imageView release];
    
}


#pragma mark===========life circle================

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initView];
}

-(void)dealloc
{
    [_searchBarLeftIcon release];
    [_searchBarRightIcon release];
    [_searchBarBackGround release];
    [super dealloc];
}

//重载放大镜图片
- (void)layoutSubviews {
	UITextField *searchField = nil;
    UIView *view = self;
    
    if (IOS7) {
        view = [self.subviews lastObject];
    }

    
	NSUInteger numViews = [view.subviews count];
	for(int i = 0; i< numViews; i++) {
		if([[view.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
			searchField = [view.subviews objectAtIndex:i];
		}
	}
	if(searchField) {
        searchField.background = [UIImage imageNamed:@"Home_Search.png"];
        searchField.backgroundColor = [UIColor clearColor];
        //放大镜
		UIImageView *iView = [[UIImageView alloc] initWithImage:_searchBarLeftIcon];
		searchField.leftView = iView;
		[iView release];
        
        
        searchField.font = defaultFontSize(13);
//        searchField.textColor = UIColorWithRGB(242, 237, 202, 1);
//        [searchField setValue:UIColorWithRGB(242, 237, 202, 1) forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:defaultFontSize(13) forKeyPath:@"_placeholderLabel.font"];
	}
    
	[super layoutSubviews];
}

-(void)setSearchBarBackGround:(UIImage *)backGround
{
    if (_searchBarBackGround == backGround) return;
    [_searchBarBackGround release];
    _searchBarBackGround = [backGround retain];
    [self setNeedsDisplay];
}

-(void)setSearchBarLeftIcon:(UIImage *)leftIcon
{
    if (_searchBarLeftIcon == leftIcon) return;
    [_searchBarLeftIcon release];
    _searchBarLeftIcon = [leftIcon retain];
    [self setNeedsDisplay];
}

-(void)setSearchBarRightIcon:(UIImage *)rightIcon
{
    if (_searchBarRightIcon == rightIcon) return;
    [_searchBarRightIcon release];
    _searchBarRightIcon = [rightIcon retain];

    
    [self setImage:_searchBarRightIcon forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
}


@end

