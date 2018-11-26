//
//  BarChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/21.
//  Copyright © 2018 崇. All rights reserved.
//

#import "BarChart.h"
#import "BarChartData.h"

@interface BarChart()<CoordinateSystemDelegate>

/*
 Y轴显示最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

/*
 Y轴显示最小值
 */
@property (nonatomic, assign) CGFloat minValue;

@end

@implementation BarChart

- (void)initProperty {
    [super initProperty];
    self.barSpacing = 5;
    self.barLeftInset = 10;
    self.barRightInset = 10;
    self.displayLatitude = YES;
    self.displayYTitles = YES;
    self.delegate = self;
}

- (void)drawData:(CGRect)rect {
    [super drawData:rect];
    
    // 绘制数据
    [self drawBarChart:rect];
}

- (void)drawRect:(CGRect)rect {
    // 计算Y轴取值范围
    [self calcValueRangeForY];
    [self initAxisY];
    [self initAxisX];
    // 初始化父类 drawRect
    [super drawRect:rect];
    
}

#pragma mark - 绘制柱条上下标题
- (void)drawXAxisTitles:(CGRect)rect {
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat barWidth = (rect.size.width - self.axisMarginLeft - self.axisMarginRight - self.barLeftInset - self.barRightInset - self.barSpacing * (self.dataArray.count - 1)) / self.dataArray.count;
    
    CGFloat barCenterX = self.axisMarginLeft + self.barLeftInset + barWidth/2;
    
    for (int i = 0; i < [self.longitudeTitles count]; i++) {
        // 取出上下标题
        BarChartData *barData = self.dataArray[i];
        NSString *topTitle = [self formatYTitles:barData.valueForY.longLongValue];
        NSString *bottomTitle = (NSString *) [self.longitudeTitles objectAtIndex:i];
        // 统一设置属性
        UIFont *textFont= self.longitudeFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.longitudeFontColor};
        // 绘制下标题
        CGSize bottomTitleSize = [bottomTitle boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attrs
                                                 context:nil].size;
        CGRect bottomTitleRect= CGRectMake(barCenterX - bottomTitleSize.width/2, rect.size.height - self.axisMarginBottom, bottomTitleSize.width, bottomTitleSize.height);
        textStyle.alignment=NSTextAlignmentCenter;
        [bottomTitle drawInRect:bottomTitleRect withAttributes:attrs];
        
        // 绘制上标题
        CGSize topTitleSize = [topTitle boundingRectWithSize:CGSizeMake(100, 100)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:attrs
                                                    context:nil].size;
        CGFloat valueY = (1 - (barData.valueForY.floatValue - self.minValue)/(self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom - self.axisMarginTop) + self.axisMarginTop - topTitleSize.height;
        
        CGRect topTitleRect= CGRectMake(barCenterX - topTitleSize.width/2, valueY, topTitleSize.width, topTitleSize.height);
        textStyle.alignment=NSTextAlignmentCenter;
        [topTitle drawInRect:topTitleRect withAttributes:attrs];
        
        // X位移
        barCenterX = barCenterX + self.barSpacing + barWidth;
    }
}

#pragma mark - 绘制柱条
- (void)drawBarChart:(CGRect)rect {
    CGFloat barWidth = (rect.size.width - self.axisMarginLeft - self.axisMarginRight - self.barLeftInset - self.barRightInset - self.barSpacing * (self.dataArray.count - 1)) / self.dataArray.count;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.dataArray && self.dataArray.count) {
        CGFloat valueX = self.axisMarginLeft + self.barLeftInset;
        for (BarChartData *barData in self.dataArray) {
            if (barData) {
                CGFloat valueY = (1 - (barData.valueForY.floatValue - self.minValue)/(self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom - self.axisMarginTop) + self.axisMarginTop;
                
                CGRect drawFrame = CGRectMake(valueX, valueY, barWidth, rect.size.height - valueY - self.axisMarginBottom);
                CGContextSetLineWidth(context, barData.borderWidth);
                CGContextSetStrokeColorWithColor(context, barData.borderColor.CGColor);
                CGContextSetFillColorWithColor(context, barData.fillColor.CGColor);
                CGContextFillRect(context, drawFrame);
                CGContextStrokeRect(context, drawFrame);
            }
            //X位移
            valueX = valueX + self.barSpacing + barWidth;
        }
    }
}

#pragma mark - 初始化XY轴
- (void)initAxisY {
    
    if (self.maxValue == 0.0f && self.minValue == 0.0f) {
        self.latitudeTitles = nil;
        return;
    }
    
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    long average = (long) ((self.maxValue - self.minValue) / self.latitudeCount);
    
    // 处理刻度，可以在这里处理刻度的缩放显示比例
    for (int i = 0; i < self.latitudeCount; i++) {
        long degree = floor(self.minValue + i * average);
        [TitleY addObject:[self formatYTitles:degree]];
    }
    
    // 最后在纬线标题数组中再加上一个最大值的标题
    long degree = (long)self.maxValue;
    [TitleY addObject:[self formatYTitles:degree]];
    
    // 设置Y轴标题数组
    self.latitudeTitles = TitleY;
}

- (NSString *)formatYTitles:(long)value {
    if (value >= 10000) {
        return [NSString stringWithFormat:@"%.2f 万", value/10000.0f];
    }
    else {
        return [NSString stringWithFormat:@"%ld", value];
    }
}

- (void)initAxisX {
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.dataArray && self.dataArray.count) {
        for (BarChartData *barData in self.dataArray) {
            [TitleX addObject:[NSString stringWithFormat:@"%@", barData.valueForX]];
        }
    }
    self.longitudeTitles = TitleX;
}

#pragma mark - 计算Y轴取值范围
- (void)calcValueRangeForY {
    if (self.dataArray && self.dataArray.count) {
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

- (void)calcMaxAndMin {
    CGFloat maxValue = 0;
    CGFloat minValue = LONG_MAX;
    
    for (BarChartData *barData in self.dataArray) {
        if (barData) {
            if (barData.valueForY.floatValue < minValue) {
                minValue = barData.valueForY.floatValue;
            }
            
            if (barData.valueForY.floatValue > maxValue) {
                maxValue = barData.valueForY.floatValue;
            }
        }
    }
    self.maxValue = maxValue;
    self.minValue = minValue;
}

- (void)enlargeMaxAndMinRange {
    CGFloat maxValue = self.maxValue;
    CGFloat minValue = self.minValue;
    
    if (maxValue > minValue) {
        // 10以内的上下限扩大 1
        if ((maxValue - minValue) < 10.0f && minValue > 1.0f) {
            self.maxValue = (long)maxValue + 1;
            self.minValue = (long)minValue - 1;
        } else {
            // 10以上的上下限扩大 差值的10%
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

#pragma mark - 十字交叉线重绘标题
- (NSArray *)crossLineTouchPoint:(CGPoint)touchPoint xPercent:(CGFloat)xPercent yPercent:(CGFloat)yPercent frame:(CGRect)rect {
    NSMutableArray *arrM = [NSMutableArray array];
    // 处理X轴
    CGFloat barWidth = (rect.size.width - self.axisMarginLeft - self.axisMarginRight - self.barLeftInset - self.barRightInset - self.barSpacing * (self.dataArray.count - 1)) / self.dataArray.count;
    CGFloat barLeft = self.axisMarginLeft + self.barLeftInset;
    for (int i = 0; i < self.dataArray.count; i++) {
        CGFloat barRight = barLeft + barWidth;
        if (touchPoint.x >= barLeft && touchPoint.x < barRight) {
            BarChartData *data = self.dataArray[i];
            [arrM addObject:data.valueForX];
            break;
        }
        barLeft = barLeft + barWidth + self.barSpacing;
    }
    
    if (arrM.count == 0) {
        [arrM addObject:@""];
    }
    
    // 处理Y轴
    CGFloat valueRange = self.maxValue - self.minValue;
    CGFloat valueY = valueRange * yPercent;
    NSString *yString = [self formatYTitles:valueY];
    [arrM addObject:yString];
    
    return arrM;
}

@end
