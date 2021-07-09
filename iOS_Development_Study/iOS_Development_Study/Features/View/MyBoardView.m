//
//  MyBoardView.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/6.
//

#import "MyBoardView.h"


@interface MyBoardView ()

@end

@implementation MyBoardView

#pragma mark- Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.opaque = NO;
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint aPoints[3];
    
    //坐标点数组
    aPoints[0] = CGPointMake(0, 80);
    aPoints[1] = CGPointMake(0, 0);
    aPoints[2] = CGPointMake(80, 0);
    [self setCGcontext:context width:15 alpha:1 points:aPoints num:3];
    
    //坐标点数组
    aPoints[0] = CGPointMake(0, 220);
    aPoints[1] = CGPointMake(0, 300);
    aPoints[2] = CGPointMake(80, 300);
    [self setCGcontext:context width:15 alpha:1 points:aPoints num:3];
    
    //坐标点数组
    aPoints[0] = CGPointMake(520, 0);
    aPoints[1] = CGPointMake(600, 0);
    aPoints[2] = CGPointMake(600, 80);
    [self setCGcontext:context width:15 alpha:1 points:aPoints num:3];
    
    //坐标点数组
    aPoints[0] = CGPointMake(600, 220);
    aPoints[1] = CGPointMake(600, 300);
    aPoints[2] = CGPointMake(520, 300);
    [self setCGcontext:context width:15 alpha:1 points:aPoints num:3];
    
    //坐标点数组
    aPoints[0] = CGPointMake(4, 110);
    aPoints[1] = CGPointMake(4, 190);
    [self setCGcontext:context width:2 alpha:0.5 points:aPoints num:2];
    
    //坐标点数组
    aPoints[0] = CGPointMake(596, 110);
    aPoints[1] = CGPointMake(596, 190);
    [self setCGcontext:context width:2 alpha:0.5 points:aPoints num:2];
    
    //坐标点数组
    aPoints[0] = CGPointMake(490, 4);
    aPoints[1] = CGPointMake(250, 4);
    [self setCGcontext:context width:2 alpha:0.5 points:aPoints num:2];
    
    //坐标点数组
    aPoints[0] = CGPointMake(110, 296);
    aPoints[1] = CGPointMake(350, 296);
    [self setCGcontext:context width:2 alpha:0.5 points:aPoints num:2];
    
    for(int i = 0; i < 7; ++ i) {
        CGContextSetLineWidth(context, 0);
        //设置起点-终点
        CGPoint pointsRect[5] = {CGPointMake(140 + i * 15, 0), CGPointMake(110 + i * 15, 30), CGPointMake(120 + i * 15, 30), CGPointMake(150 + i * 15, 0), CGPointMake(140 + i * 15, 0)};
        CGContextAddLines(context, pointsRect, 5);
        //填充
        CGContextSetRGBFillColor(context, 0.16, 0.51, 0.97, 0.5);
        //绘制路径及填充模式
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    for(int i = 0; i < 7; ++ i) {
        CGContextSetLineWidth(context, 0);
        //设置起点-终点
        CGPoint pointsRect[5] = {CGPointMake(460 - i * 15, 300), CGPointMake(490 - i * 15, 270), CGPointMake(480 - i * 15, 270), CGPointMake(450 - i * 15, 300), CGPointMake(460 - i * 15, 300)};
        CGContextAddLines(context, pointsRect, 5);
        //填充
        CGContextSetRGBFillColor(context, 0.16, 0.51, 0.97, 0.5);
        //绘制路径及填充模式
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}
#pragma mark- Public Method
#pragma mark- Delegate
#pragma mark- Event Response
#pragma mark- Getters and Setters
#pragma mark- Private Method
- (void)setCGcontext:(CGContextRef)context width:(double)width alpha:(double)alpha points:(CGPoint *)aPoints num:(int)num {
    //线条宽
    CGContextSetLineWidth(context, width);
    //线条颜色
    CGContextSetRGBStrokeColor(context, 0.16, 0.51, 0.97, alpha); //设置线条颜色第一种方法
    //添加线 points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, num);
    //根据坐标绘制路径
    CGContextDrawPath(context, kCGPathStroke);
}

@end
