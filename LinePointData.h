//
//  LinePointData.h
//  图形绘制
//
//  Created by 崇 on 2018/11/19.
//  Copyright © 2018 崇. All rights reserved.
//  !线上的点

#import <UIKit/UIKit.h>

@interface LinePointData : NSObject

@property (nonatomic, copy) NSString *valueForX;
@property (nonatomic, copy) NSString *valueForY;

- (instancetype)initWithValueForX:(NSString *)valueForX valueForY:(NSString *)valueForY;

- (instancetype)initWithValueForY:(CGFloat)valueForY valueForX:(NSString *)valueForX;

@end
