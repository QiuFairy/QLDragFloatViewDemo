//
//  QLDragFloatView.h
//  QLDragFloatViewDemo
//
//  Created by qiu on 2018/4/21.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 悬浮按钮
 */
@protocol QLTapViewDelegate <NSObject>
//点击事件
-(void)tapViewFloatingBall;
@end

@interface QLDragFloatView : UIView
//代理
@property(nonatomic,weak) id<QLTapViewDelegate>delegate;

//距父view的边距
@property (nonatomic) UIEdgeInsets contentInset;
/** 是否自动改变alpha  默认YES */
@property (nonatomic, assign) BOOL isAutoChangeAlpha;
@end
