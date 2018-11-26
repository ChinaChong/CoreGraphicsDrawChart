//
//  LineData.h
//  图形绘制
//
//  Created by 崇 on 2018/11/16.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinePointData;
@interface LineData : NSObject

@property (nonatomic, strong) NSMutableArray<LinePointData *> *linePointsDataArray;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@end
