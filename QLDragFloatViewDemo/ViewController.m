//
//  ViewController.m
//  QLDragFloatViewDemo
//
//  Created by qiu on 2018/6/12.
//  Copyright © 2018年 QiuFairy. All rights reserved.
//

#import "ViewController.h"
#import "QLDragFloatView.h"
@interface ViewController ()<QLTapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFloatView];
}
#pragma mark - 悬浮按钮
-(void)createFloatView{
    QLDragFloatView *floatView = [[QLDragFloatView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-70, [UIScreen mainScreen].bounds.size.height-160, 60, 60)];
    floatView.delegate = self;
    floatView.contentInset = UIEdgeInsetsMake(88, 10,10, 10);
    [self.view addSubview:floatView];
}

-(void)tapViewFloatingBall{
    NSLog(@"dianji");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
