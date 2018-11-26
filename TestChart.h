//
//  TestChart.h
//  图形绘制
//
//  Created by 崇 on 2018/11/23.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestChart : UIView

@property (nonatomic, strong) NSArray *longitudeTitles;
@property (nonatomic, strong) NSArray *latitudeTitles;
@property (nonatomic, assign) CGPoint singleTouchPoint;

@end
