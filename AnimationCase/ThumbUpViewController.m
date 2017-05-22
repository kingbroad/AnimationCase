//
//  ThumbUpViewController.m
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "ThumbUpViewController.h"

@interface ThumbUpViewController ()

@property (nonatomic, assign) BOOL tapNum;
@property (nonatomic, strong) UIImageView *imageView;
//两种不同的CAEmitterLayer
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation ThumbUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tapNum = YES;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    imageView.frame = CGRectMake(100, 200, 20, 40);
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topClick)];
    [self.imageView addGestureRecognizer:tap];
    
}
- (void)topClick{
    self.tapNum = !self.tapNum;
    if (self.tapNum == NO) {
        self.imageView.image = [UIImage imageNamed:@"Image-1"];
        CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
        explosionCell.name           = @"explosion";
        //一个粒子的颜色alpha能改变的范围
        explosionCell.alphaRange     = 0.10;
        //粒子透明度在生命周期内的改变速度
        explosionCell.alphaSpeed     = -1.0;
        //生命周期
        explosionCell.lifetime       = 0.7;
        //生命周期范围 lifetime= lifetime(+/-) lifetimeRange
        explosionCell.lifetimeRange  = 0.3;
        //每秒发射的粒子数量
        explosionCell.birthRate      = 0;
        //速度
        explosionCell.velocity       = 40.00;
        //速度范围
        explosionCell.velocityRange  = 100.00;
        //	缩放比例
        explosionCell.scale          = 0.03;
        //	缩放比例范围
        explosionCell.scaleRange     = 0.02;
        //是个CGImageRef的对象,既粒子要展现的图片
        explosionCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
        
        _explosionLayer               = [CAEmitterLayer layer];
        _explosionLayer.name          = @"emitterLayer";
        //发射源的形状
        _explosionLayer.emitterShape  = kCAEmitterLayerCircle;
        //发射模式
        _explosionLayer.emitterMode   = kCAEmitterLayerOutline;
        //	发射源的大小
        _explosionLayer.emitterSize   = CGSizeMake(10, 0);
        //装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
        _explosionLayer.emitterCells  = @[explosionCell];
        //渲染模式
        _explosionLayer.renderMode    = kCAEmitterLayerOldestFirst;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.position      = CGPointMake(self.imageView.frame.size.width/2.0, self.imageView.frame.size.height/2.0);
        _explosionLayer.zPosition     = -1;
        [self.imageView.layer addSublayer:_explosionLayer];
        
        CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
        chargeCell.name           = @"charge";
        chargeCell.alphaRange     = 0.10;
        chargeCell.alphaSpeed     = -1.0;
        chargeCell.lifetime       = 0.3;
        chargeCell.lifetimeRange  = 0.1;
        chargeCell.birthRate      = 0;
        chargeCell.velocity       = -40.0;
        chargeCell.velocityRange  = 0.00;
        chargeCell.scale          = 0.03;
        chargeCell.scaleRange     = 0.02;
        chargeCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
        
        _chargeLayer               = [CAEmitterLayer layer];
        _chargeLayer.name          = @"emitterLayer";
        _chargeLayer.emitterShape  = kCAEmitterLayerCircle;
        _chargeLayer.emitterMode   = kCAEmitterLayerOutline;
        _chargeLayer.emitterSize   = CGSizeMake(20, 0);
        _chargeLayer.emitterCells  = @[chargeCell];
        _chargeLayer.renderMode    = kCAEmitterLayerOldestFirst;
        _chargeLayer.masksToBounds = NO;
        _chargeLayer.position      = CGPointMake(self.imageView.frame.size.width/2.0, self.imageView.frame.size.height/2.0);
        _chargeLayer.zPosition     = -1;
        [self.imageView.layer addSublayer:_chargeLayer];
        [self startAnimate];
    }else{
        self.imageView.image = [UIImage imageNamed:@"Image"];
    }
}
/**
 *  开始喷射
 */
- (void)startAnimate {
    //chareLayer开始时间
    self.chargeLayer.beginTime = CACurrentMediaTime();
    //chareLayer每秒喷射的80个
    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    //进入下一个动作
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

/**
 *  大量喷射
 */
- (void)explode {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    //停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

/**
 *  停止喷射
 */
- (void)stop {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer每秒喷射的0个
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}








@end
