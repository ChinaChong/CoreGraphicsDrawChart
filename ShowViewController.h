//
//  ShowViewController.h
//  图形绘制
//
//  Created by 崇 on 2018/11/24.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShowCoordinateSystem,
    ShowLineChart,
    ShowBarChart,
    ShowPieChart,
    ShowAnnulusChart,
    ShowAreaChart
} ShowStyle;

@interface ShowViewController : UIViewController

@property (nonatomic, assign) ShowStyle showStyle;

@end
