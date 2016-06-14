//
//  RCDraggableButton.h
//  RCDraggableButton
//
//  Created by Looping (www.looping@gmail.com) on 14-2-8.
//  Copyright (c) 2014 RidgeCorn (https://github.com/RidgeCorn).
//

#import <UIKit/UIKit.h>
#define RC_DB_VERSION @"0.2"

@interface RCDraggableButton : UIButton {
    BOOL _isDragging;
    BOOL _singleTapBeenCanceled;
    CGPoint _beginLocation;
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
}
@property (nonatomic) BOOL draggable;
@property (nonatomic) BOOL autoDocking;

@property (nonatomic, copy) void(^longPressBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^tapBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^doubleTapBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^draggingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^dragDoneBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^autoDockingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^autoDockingDoneBlock)(RCDraggableButton *button);
@property (nonatomic, strong) UILabel *numLab;// 显示个数

- (id)initInKeyWindowWithFrame:(CGRect)frame;
- (id)initInView:(id)view WithFrame:(CGRect)frame;

- (BOOL)isDragging;

+ (NSString *)version;

+ (void)allHiddenWindow;// 全部隐藏
+ (void)allShowWindow;// 全部显示

+ (void)removeAllFromKeyWindow;// 全部取消


+ (void)removeAllFromView:(id)superView;

@end
