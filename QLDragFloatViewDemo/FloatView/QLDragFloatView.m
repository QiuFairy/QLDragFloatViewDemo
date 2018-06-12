//
//  QLDragFloatView.m
//  QLDragFloatViewDemo
//
//  Created by qiu on 2018/4/21.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import "QLDragFloatView.h"

#define DEFAULTAPHLA 0.5

@interface QLDragFloatView()
{
    CGPoint startLocation;
    
}
// 上边距(默认值:0)
@property (nonatomic, assign) CGFloat topEdgeDistance;
// 左边距(默认值:0)
@property (nonatomic, assign) CGFloat leftEdgeDistance;
// 下边距(默认值:0)
@property (nonatomic, assign) CGFloat bottomEdgeDistance;
// 右边距(右边距:0)
@property (nonatomic, assign) CGFloat rightEdgeDistance;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation QLDragFloatView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.alpha = DEFAULTAPHLA;
        self.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = NO;
        
        self.isAutoChangeAlpha = YES;
        
        [self addPanGestureRecognizer];
        // 设置 默认 边距
        [self setupDefaultEdgeDistance];
        [self addViews];
        
    }
    return self;
}
-(void)addViews{
    UILabel *answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    answerLabel.text = @"回答";
    answerLabel.font = [UIFont systemFontOfSize:18.0];
    answerLabel.textColor = [UIColor whiteColor];
    answerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:answerLabel];
}
// 设置 默认 边距
- (void)setupDefaultEdgeDistance {
    // 左边距
    self.leftEdgeDistance = 0;
    // 右边距
    self.rightEdgeDistance = 0;
    // 上边距
    self.topEdgeDistance = 0;
    // 下边距
    self.bottomEdgeDistance = 0;
}

-(void)setContentInset:(UIEdgeInsets)contentInset{
    _contentInset = contentInset;
    
    // 左边距
    self.leftEdgeDistance = contentInset.left;
    // 右边距
    self.rightEdgeDistance = contentInset.right;
    // 上边距
    self.topEdgeDistance = contentInset.top;
    // 下边距
    self.bottomEdgeDistance = contentInset.bottom;
}
// 添加 手势
- (void)addPanGestureRecognizer {
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMe)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
}
#pragma mark --- response event
-(void)pan:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{
            [self PanGestureBegan:sender];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self PanGestureMoved:sender];
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            [self PanGestureEnded:sender];
        }
            break;
        default:
            break;
    }
}
-(void)PanGestureBegan:(UIPanGestureRecognizer *)sender{
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    
    self.alpha = 1.0;
    CGPoint pt = [sender locationInView:self];
    startLocation = pt;
    [[self superview] bringSubviewToFront:self];
}
-(void)PanGestureMoved:(UIPanGestureRecognizer *)sender{
    CGPoint pt = [sender locationInView:self];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    //
    float halfx = CGRectGetMidX(self.bounds);
    newcenter.x = MAX(halfx + self.leftEdgeDistance, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width-self.rightEdgeDistance - halfx, newcenter.x);
    //
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy + self.topEdgeDistance, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - self.bottomEdgeDistance - halfy, newcenter.y);
    //
    self.center = newcenter;
}
-(void)PanGestureEnded:(UIPanGestureRecognizer *)sender{
    CGPoint point = self.center;
    if (point.x>[self superview].bounds.size.width/2.0) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = [self superview].bounds.size.width -self.frame.size.width-self.rightEdgeDistance;
            self.frame = frame;
        } completion:^(BOOL finished) {
            [self createTimer];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = 0+self.leftEdgeDistance;
            self.frame = frame;
        } completion:^(BOOL finished) {
            [self createTimer];
        }];
    }
}

//是否变灰
-(void)createTimer{
    if (self.isAutoChangeAlpha) {
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
        }
    }
}
-(void)updateTimer{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = DEFAULTAPHLA;
        [self.timer invalidate];
        self.timer = nil;
    }];
}

-(void)tapMe{
    if ([self.delegate respondsToSelector:@selector(tapViewFloatingBall)]) {
        [self.delegate tapViewFloatingBall];
    }
}
#pragma mark - 去除父响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

@end
