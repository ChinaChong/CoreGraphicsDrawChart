//
//  LineChart.h
//  图形绘制
//
//  Created by 崇 on 2018/11/16.
//  Copyright © 2018 崇. All rights reserved.
//

#import "CoordinateSystem.h"

@class LineData;
@interface LineChart : CoordinateSystem

/**
 LineData数据源
 */
@property (nonatomic, strong) NSMutableArray<LineData *> *linesArray;
/*
 Y轴显示最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

/*
 Y轴显示最小值
 */
@property (nonatomic, assign) CGFloat minValue;

- (void)initAxisY;

- (void)initAxisX;

@end
