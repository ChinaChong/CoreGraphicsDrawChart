//
//  BarChartData.h
//  图形绘制
//
//  Created by 崇 on 2018/11/21.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarChartData : NSObject

@property (nonatomic, copy) NSString *valueForX;
@property (nonatomic, copy) NSString *valueForY;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat borderWidth;

- (instancetype)initWithValueForX:(NSString *)valueForX valueForY:(NSString *)valueForY;

@end
