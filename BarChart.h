//
//  BarChart.h
//  图形绘制
//
//  Created by 崇 on 2018/11/21.
//  Copyright © 2018 崇. All rights reserved.
//  柱状图

#import "CoordinateSystem.h"

@class BarChartData;
@interface BarChart : CoordinateSystem

@property (nonatomic, strong) NSMutableArray<BarChartData *> *dataArray;
@property (nonatomic, assign) CGFloat barSpacing;
@property (nonatomic, assign) CGFloat barLeftInset;
@property (nonatomic, assign) CGFloat barRightInset;

@end
