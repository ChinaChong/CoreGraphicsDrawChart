//
//  LinePointData.m
//  图形绘制
//
//  Created by 崇 on 2018/11/19.
//  Copyright © 2018 崇. All rights reserved.
//

#import "LinePointData.h"

@implementation LinePointData

- (instancetype)initWithValueForX:(NSString *)valueForX valueForY:(NSString *)valueForY {
    self = [super init];
    if (self) {
        self.valueForX = valueForX;
        self.valueForY = valueForY;
    }
    
    return self;
}

- (instancetype)initWithValueForY:(CGFloat)valueForY valueForX:(NSString *)valueForX {
    self = [super init];
    if (self) {
        self.valueForX = valueForX;
        self.valueForY = [NSString stringWithFormat:@"%lf", valueForY];
    }
    
    return self;
}

@end
