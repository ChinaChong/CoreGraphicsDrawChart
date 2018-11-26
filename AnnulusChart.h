//
//  AnnulusChart.h
//  图形绘制
//
//  Created by 崇 on 2018/11/23.
//  Copyright © 2018 崇. All rights reserved.
//

#import "PieChart.h"

@interface AnnulusChart : PieChart

/**
 范围取值 0-1
 */
@property (nonatomic, assign) CGFloat annulusWidthPercentToRadius;

@end
