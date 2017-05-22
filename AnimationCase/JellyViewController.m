//
//  JellyViewController.m
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "JellyViewController.h"

@interface JellyViewController ()

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, assign) CGPoint originPoint;

@end

@implementation JellyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *rView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200)];
    rView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:rView];
    
    UIView *rPoint = [[UIView alloc] init];
    rPoint.frame = CGRectMake(rView.center.x, 200-20, 10, 10);
    rPoint.backgroundColor = [UIColor redColor];
    [rView addSubview:rPoint];
    rPoint.layer.cornerRadius = 5;
    rPoint.layer.masksToBounds = YES;
    
    self.grayView = rView;
    self.redView = rPoint;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    self.redView.userInteractionEnabled = YES;
    [self.redView addGestureRecognizer:pan];
    self.originPoint = self.redView.center;
    
}

- (void)handlePanAction:(UIPanGestureRecognizer *)ges{
    
    if (ges.state == UIGestureRecognizerStateChanged) {
        
         CGPoint point = [ges translationInView:self.grayView];
        self.redView.frame = CGRectMake(point.x, point.y, 10, 10);
        
    }else{
        
        self.redView.frame = self.redView.frame = CGRectMake(self.originPoint.x, self.originPoint.y, 10, 10);
        
    }
}
@end
