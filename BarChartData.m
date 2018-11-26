//
//  BarChartData.m
//  图形绘制
//
//  Created by 崇 on 2018/11/21.
//  Copyright © 2018 崇. All rights reserved.
//

#import "BarChartData.h"

@implementation BarChartData

- (instancetype)initWithValueForX:(NSString *)valueForX valueForY:(NSString *)valueForY {
    self = [super init];
    if (self) {
        self.valueForX = valueForX;
        self.valueForY = valueForY;
        self.borderColor = [UIColor redColor];
        self.borderWidth = 1;
        self.fillColor = [UIColor yellowColor];
    }
    
    return self;
}

@end
