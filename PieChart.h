//
//  PieChart.h
//  图形绘制
//
//  Created by 崇 on 2018/11/22.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PieChartData;
@interface PieChart : UIView

@property (nonatomic, strong) NSMutableArray<PieChartData *> *dataArray;

/**
 边框线宽
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 边框线颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 标题字号
 */
@property (nonatomic, strong) UIFont *titleFont;

- (void)initProperty;

@end
