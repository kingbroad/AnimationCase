//
//  RadarLayer.h
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface RadarLayer : CALayer

@property (nonatomic, assign) CGFloat radius;///<雷达扩散最大半径,默认:20pt
@property (nonatomic, assign) NSTimeInterval animationDuration;///<雷达扩散效果持续时间, 默认:3s
@property (nonatomic, assign) NSTimeInterval pulseInterval;///<雷达效果脉冲间隔,默认0秒(一个脉冲消失后,下一个脉冲才出现) 

@end
