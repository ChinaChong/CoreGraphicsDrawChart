//
//  PieChartData.m
//  图形绘制
//
//  Created by 崇 on 2018/11/22.
//  Copyright © 2018 崇. All rights reserved.
//

#import "PieChartData.h"

@implementation PieChartData

- (instancetype)initWithValue:(CGFloat)value fillColor:(UIColor *)fillColor title:(NSString *)title {
    self = [super init];
    if (self) {
        self.value = value;
        self.fillColor = fillColor;
        self.title = title;
    }
    return self;
}

- (NSString *)title {
    if (_title == nil) {
        _title = @"其它";
    }
    return _title;
}

- (CGFloat)value {
    if (_value <= 0) {
        _value =  1;
    }
    return _value;
}

- (UIColor *)fillColor {
    if (_fillColor == nil) {
        _fillColor = [UIColor whiteColor];
    }
    return _fillColor;
}

@end
