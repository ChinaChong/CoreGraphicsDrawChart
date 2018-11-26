//
//  LineChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/16.
//  Copyright © 2018 崇. All rights reserved.
//

#import "LineChart.h"
#import "LineData.h"
#import "LinePointData.h"

@interface LineChart()

@end

@implementation LineChart

- (void)drawRect:(CGRect)rect {
    // 初始化XY轴，如果是密度很大的K线图，单独初始化XY轴设置相应的值
    [self initAxisY];
    [self initAxisX];
    // 初始化父类 drawRect
    [super drawRect:rect];
    // 绘制数据
//    [self drawLines:rect];
}

#pragma mark - 绘制折线
- (void)drawData:(CGRect)rect {
    if (!self.linesArray || !self.linesArray.count) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES); // 消除锯齿
    
    // 经线间距
    CGFloat longitudeSpacing = 0;
    // 坐标
    __block CGFloat valueX = 0;
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
}

#pragma mark - 初始化XY轴
- (void)initAxisY {
    // 计算Y轴取值范围
    [self calcValueRangeForY];
    
    if (self.maxValue == 0.0f && self.minValue == 0.0f) {
        self.latitudeTitles = nil;
        return;
    }
    
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    long average = (long) ((self.maxValue - self.minValue) / self.latitudeCount);
    
    // 处理刻度，可以在这里处理刻度的缩放显示比例
    for (int i = 0; i < self.latitudeCount; i++) {
        long degree = floor(self.minValue + i * average);
        NSString *value = [[NSNumber numberWithInteger:degree] stringValue];
        [TitleY addObject:value];
    }
    
    // 最后在纬线标题数组中再加上一个最大值的标题
    long degree = (long)self.maxValue;
    NSString *value = [[NSNumber numberWithInteger:degree] stringValue];
    [TitleY addObject:value];
    
    // 设置Y轴标题数组
    self.latitudeTitles = TitleY;
}

// 以第一条线作为X轴标识
- (void)initAxisX {
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.linesArray && self.linesArray.count) {
        LineData *line = self.linesArray.firstObject;
        if (line.linePointsDataArray && line.linePointsDataArray.count) {
            for (LinePointData *linePoint in line.linePointsDataArray) {
                [TitleX addObject:[NSString stringWithFormat:@"%@", linePoint.valueForX]];
            }
        }
    }
    self.longitudeTitles = TitleX;
}

#pragma mark - 计算Y轴取值范围
- (void)calcValueRangeForY {
    if (self.linesArray && self.linesArray.count) {
        // 第一步：确定数据源中的最大值和最小值
        [self calcMaxAndMin];
        // 第二步：扩大最大值和最小值范围
        [self enlargeMaxAndMinRange];
        // 第三步：去 “毛茬”
        [self trimMaxAndMin];
    }
    else {
        self.maxValue = 0;
        self.minValue = 0;
    }
}

// MARK:第一步：确定数据源中的最大值和最小值
- (void)calcMaxAndMin {
    CGFloat maxValue = 0;
    CGFloat minValue = LONG_MAX;
    
    for (LineData *line in self.linesArray) {
        if (line && line.linePointsDataArray && line.linePointsDataArray.count) {
            for (LinePointData *linePoint in line.linePointsDataArray) {
                if (linePoint.valueForY.floatValue < minValue) {
                    minValue = linePoint.valueForY.floatValue;
                }
                
                if (linePoint.valueForY.floatValue > maxValue) {
                    maxValue = linePoint.valueForY.floatValue;
                }
            }
        }
    }
    self.maxValue = maxValue;
    self.minValue = minValue;
}

// MARK:第二步：扩大最大值和最小值范围
- (void)enlargeMaxAndMinRange {
    CGFloat maxValue = self.maxValue;
    CGFloat minValue = self.minValue;
    
    if (maxValue > minValue) {
        // 10以内的上下限扩大 1
        if ((maxValue - minValue) < 10.0f && minValue > 1.0f) {
            self.maxValue = (long)maxValue + 1;
            self.minValue = (long)minValue - 1;
        } else {
            // 10以上的上下限扩大 10%
            self.maxValue = (long)(maxValue + (maxValue - minValue) * 0.1);
            self.minValue = (long)(minValue - (maxValue - minValue) * 0.1);
            
            if (self.minValue < 0) {
                self.minValue = 0;
            }
        }
    }
    else if (maxValue == minValue) {
        /*
         2 - 10               1
         11 - 100             10
         101 - 1000           100
         1001 - 10000         1000
         ...
         */
        // 按照区间，上下限扩大 10%
        long power = 0;
        long temp = (long)maxValue;
        while (temp > 10) {
            temp = temp / 10;
            power++;
        }
        
        long enlargeValue = (long)(pow(10, power));
        self.maxValue = (long)maxValue + enlargeValue;
        self.minValue = (long)minValue - enlargeValue;
        if (self.minValue < 0) {
            self.minValue = 0;
        }
    }
    else {
        self.maxValue = 0;
        self.minValue = 0;
    }
}

// MARK:第三步：去 “毛茬”
- (void)trimMaxAndMin {
    /*
     范围           取余基准值
     1-99           %1
     100-999        %10
     1000-9999      %100
     10000-99999    %1000
     ...
     */
    long power = 0;
    long temp = (long)self.maxValue;
    while (temp >= 100) {
        temp = temp / 10;
        power++;
    }
    // 用来计算扣除部分的取余基准值
    long deduction = (long)pow(10, power);
    
    // 处理最小值
    if (self.latitudeCount > 0 && deduction > 1 && (long)self.minValue % deduction != 0) {
        self.minValue = (long)self.minValue - ((long)(self.minValue) % deduction);
    }
    
    // 处理最大值，为了让纬线刻度等分，取余基准值再乘以纬线份数
    if (self.latitudeCount > 0 && (long)(self.maxValue - self.minValue) % (self.latitudeCount * deduction) != 0) {
        self.maxValue = (long)self.maxValue + (self.latitudeCount * deduction) - (long)(self.maxValue - self.minValue) % (self.latitudeCount * deduction);
    }
}

@end
