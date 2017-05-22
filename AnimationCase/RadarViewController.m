//
//  RadarViewController.m
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "RadarViewController.h"
#import "RadarLayer.h"
@interface RadarViewController ()

@end

@implementation RadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //对封装的动画初始化
    RadarLayer *animationlayer = [RadarLayer layer];
    //设置动画的位置(根据需要自己修改)
    animationlayer.position = self.view.center;
    animationlayer.radius = 200;
    //将动画添加到显示动画的视图的layer层上
    [self.view.layer insertSublayer:animationlayer below:self.view.layer];
    
}












@end
