//
//  AreaChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/23.
//  Copyright © 2018 崇. All rights reserved.
//

#import "AreaChart.h"
#import "LineData.h"
#import "LinePointData.h"

@implementation AreaChart



- (void)drawData:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (self.linesArray != NULL) {
        // 经线间距
        CGFloat longitudeSpacing = 0;
        // 坐标
        __block CGFloat valueX = 0;
        __block CGFloat lastX = 0;
        __block CGFloat lastY = 0;
        // 逐条绘制
        for (LineData *line in self.linesArray) {
            if (!line || !line.linePointsDataArray || line.linePointsDataArray.count < 2) continue;
            // 配置线条
            CGContextSetStrokeColorWithColor(context, line.lineColor.CGColor);
            CGContextSetLineWidth(context, line.lineWidth);

            longitudeSpacing = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / (line.linePointsDataArray.count - 1);

            valueX = self.axisMarginLeft;

            [line.linePointsDataArray enumerateObjectsUsingBlock:^(LinePointData * _Nonnull point, NSUInteger idx, BOOL * _Nonnull stop) {
                // 计算点的Y坐标
                CGFloat valueY = (1 - (point.valueForY.floatValue - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop;
                // 第一个初始点不画线
                if (idx == 0) {
                    CGContextMoveToPoint(context, valueX, valueY);
                    lastY = valueY;
                }
                else {
                    CGContextAddLineToPoint(context, valueX, valueY);
                    lastY = valueY;
                }
                // X坐标移动
                valueX = valueX + longitudeSpacing;
            }];
            // 绘制路径
            CGContextStrokePath(context);
        }
        
        LineData *line1 = [self.linesArray objectAtIndex:0];
        LineData *line2 = [self.linesArray objectAtIndex:1];


        if (line1 != NULL && line2 != NULL) {
            //设置线条颜色
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            //获取线条数据
            NSArray *line1Points = line1.linePointsDataArray;
            NSArray *line2Points = line2.linePointsDataArray;

            // 点线距离
            CGFloat lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([line1.linePointsDataArray count] - 1));
            //起始点
            valueX = super.axisMarginLeft;
            //遍历并绘制线条
            for (int j = 0; j < [line1Points count]; j++) {
                LinePointData *line1Point = [line1Points objectAtIndex:j];
                LinePointData *line2Point = [line2Points objectAtIndex:j];

                //获取终点Y坐标
                CGFloat valueY1 = (1 - (line1Point.valueForY.floatValue - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop;
                CGFloat valueY2 = (1 - (line2Point.valueForY.floatValue - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop;

                //绘制线条路径
                if (j == 0) {
                    CGContextMoveToPoint(context, valueX, valueY1);
                    CGContextAddLineToPoint(context, valueX, valueY2);
                    CGContextMoveToPoint(context, valueX, valueY1);
                } else {
                    CGContextAddLineToPoint(context, valueX, valueY1);
                    CGContextAddLineToPoint(context, valueX, valueY2);
                    CGContextAddLineToPoint(context, lastX, lastY);

                    CGContextMoveToPoint(context, valueX, valueY1);
                }
                lastX = valueX;
                lastY = valueY2;
                //X位移
                valueX = valueX + lineLength;
            }
            CGContextClosePath(context);
            CGContextSetAlpha(context, 0.5);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillPath(context);
//            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//            CGContextStrokePath(context);
        }
        
    }
}

- (void)initAxisX {
    [super initAxisX];
}

- (void)initAxisY {
    [super initAxisY];
}

@end
