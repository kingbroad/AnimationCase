//
//  DingDingViewController.m
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "DingDingViewController.h"

@interface DingDingViewController ()
@property (nonatomic, assign) BOOL touchNum;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation DingDingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.touchNum = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100);
    btn.backgroundColor = [UIColor grayColor];
    btn.bounds = CGRectMake(0, 0, 40, 40);
    [btn setTitle:@"title" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btnArr = [NSMutableArray array];
    for (int i=0; i<9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 40, 40);
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 20;
        btn.layer.masksToBounds = YES;
        btn.userInteractionEnabled = NO;
        btn.hidden = YES;
        [self.view addSubview:btn];
        [self.btnArr addObject:btn];
    }
}
- (void)btnClick{
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:2];
    [CATransaction setCompletionBlock:^{
        for (UIButton *button in self.btnArr) {
            button.transform = CGAffineTransformIdentity;
        }
    }];
    if (self.touchNum == YES) {//弹出动画
        
        for (int i = 0; i<self.btnArr.count; i++) {
            
            UIButton *btn =(UIButton *)self.btnArr[i];
            btn.hidden = NO;
            CGPoint  originPosition = CGPointZero;
            CGPoint finalPosition = CGPointZero;
            originPosition = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100);
            finalPosition = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100 -(i+1)*(20+40));
            
            CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            positionAnimation.fromValue = [NSValue valueWithCGPoint:originPosition];
            positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01f];
            scaleAnimation.toValue = [NSNumber numberWithFloat:1.f];
            
            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.duration = 2;
            groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            groupAnimation.fillMode = kCAFillModeForwards;
            groupAnimation.removedOnCompletion = NO;
            groupAnimation.animations = @[positionAnimation, scaleAnimation];
            
            groupAnimation.beginTime = CACurrentMediaTime() + (3/(float)self.btnArr.count * (float)i) + 0.03f;
            [btn.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            btn.layer.position = finalPosition;
            btn.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
            
        }
    }else{//收回动画
        
        for (int i = 0; i<self.btnArr.count; i++) {
            
            UIButton *btn =(UIButton *)self.btnArr[i];
            //btn.hidden = YES;
            CGPoint finalPosition = CGPointZero;

            finalPosition = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100);
            
            CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
            positionAnimation.toValue = [NSValue valueWithCGPoint:finalPosition];
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.toValue = [NSNumber numberWithFloat:0.01f];            
            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.duration = 2;
            groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            groupAnimation.fillMode = kCAFillModeForwards;
            groupAnimation.removedOnCompletion = NO;
            groupAnimation.animations = @[positionAnimation, scaleAnimation];
            
            groupAnimation.beginTime = CACurrentMediaTime() + (2/(float)self.btnArr.count * (float)(self.btnArr.count - i)) + 0.03f;
            [btn.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            btn.layer.position = finalPosition;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        }
        
    }
    [CATransaction commit];
    self.touchNum = !self.touchNum;
    
}


@end
