//
//  PieChartData.h
//  图形绘制
//
//  Created by 崇 on 2018/11/22.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, strong) UIColor *fillColor;

- (instancetype)initWithValue:(CGFloat)value fillColor:(UIColor *)fillColor title:(NSString *)title;

@end
