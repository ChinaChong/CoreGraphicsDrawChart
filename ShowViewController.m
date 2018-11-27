//
//  ShowViewController.m
//  图形绘制
//
//  Created by 崇 on 2018/11/24.
//  Copyright © 2018 崇. All rights reserved.
//

#import "ShowViewController.h"
#import "CoordinateSystem.h"
#import "LineChart.h"
#import "LinePointData.h"
#import "LineData.h"
#import "BarChart.h"
#import "BarChartData.h"
#import "PieChart.h"
#import "PieChartData.h"
#import "AnnulusChart.h"
#import "AreaChart.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    switch (self.showStyle) {
        case ShowCoordinateSystem:{
            [self testCoordinateSystem];
        }
            break;
        case ShowLineChart:{
            [self testLineChart];
        }
            break;
        case ShowBarChart:{
            [self testBarChart];
        }
            break;
        case ShowPieChart:{
            [self testPieChart];
        }
            break;
        case ShowAnnulusChart:{
            [self testAnnulusChart];
        }
            break;
        case ShowAreaChart:{
            [self testAreaChart];
        }
            break;
            
        default:
            break;
    }
}

// 区域填充
- (void)testAreaChart {
    NSMutableArray *lines = [NSMutableArray array];
    
    NSMutableArray *line1Points = [[NSMutableArray alloc] init];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10617113 valueForX:@"11/4"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10603895 valueForX:@"11/1"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10580560 valueForX:@"10/31"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10564875 valueForX:@"10/30"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10620287 valueForX:@"10/29"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10700735 valueForX:@"10/28"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10910710 valueForX:@"10/25"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11031533 valueForX:@"10/24"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11099384 valueForX:@"10/23"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11312491 valueForX:@"10/22"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11599872 valueForX:@"10/21"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11931192 valueForX:@"10/18"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11990448 valueForX:@"10/17"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12048276 valueForX:@"10/16"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12027775 valueForX:@"10/15"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12077014 valueForX:@"10/14"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12183218 valueForX:@"10/11"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12256963 valueForX:@"10/10"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12323136 valueForX:@"10/9"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12389093 valueForX:@"10/8"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12437400 valueForX:@"9/30"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12482654 valueForX:@"9/27"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12505480 valueForX:@"9/26"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12524677 valueForX:@"9/25"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12502277 valueForX:@"9/24"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12479441 valueForX:@"9/23"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12378219 valueForX:@"9/18"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12273935 valueForX:@"9/17"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:12166553 valueForX:@"9/16"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11918787 valueForX:@"9/13"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11522061 valueForX:@"9/12"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10912059 valueForX:@"9/11"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10499696 valueForX:@"9/10"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9885196 valueForX:@"9/9"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9453670 valueForX:@"9/6"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9326601 valueForX:@"9/5"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9286147 valueForX:@"9/4"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9222794 valueForX:@"9/3"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9150994 valueForX:@"9/2"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9087760 valueForX:@"8/30"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9011299 valueForX:@"8/29"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8934251 valueForX:@"8/28"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8826646 valueForX:@"8/27"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8707433 valueForX:@"8/26"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8637643 valueForX:@"8/23"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8607666 valueForX:@"8/22"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8568989 valueForX:@"8/21"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8523176 valueForX:@"8/20"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8461634 valueForX:@"8/19"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8400730 valueForX:@"8/16"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8366701 valueForX:@"8/15"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8363630 valueForX:@"8/14"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8398539 valueForX:@"8/13"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8432797 valueForX:@"8/12"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8491880 valueForX:@"8/9"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8552711 valueForX:@"8/8"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8701628 valueForX:@"8/7"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8703846 valueForX:@"8/6"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8704691 valueForX:@"8/5"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8704874 valueForX:@"8/2"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8707473 valueForX:@"8/1"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8710206 valueForX:@"7/31"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8706704 valueForX:@"7/30"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8703774 valueForX:@"7/29"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8688681 valueForX:@"7/26"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8695485 valueForX:@"7/25"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8702430 valueForX:@"7/24"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8717868 valueForX:@"7/23"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8726431 valueForX:@"7/22"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8766321 valueForX:@"7/19"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8779082 valueForX:@"7/18"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8800376 valueForX:@"7/17"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8887330 valueForX:@"7/16"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:8999954 valueForX:@"7/15"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9084014 valueForX:@"7/12"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9171337 valueForX:@"7/11"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9202712 valueForX:@"7/10"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9371937 valueForX:@"7/9"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9536389 valueForX:@"7/8"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9719491 valueForX:@"7/5"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:9899715 valueForX:@"7/4"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10075432 valueForX:@"7/3"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10368327 valueForX:@"7/2"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10631488 valueForX:@"7/1"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10849122 valueForX:@"6/28"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11043563 valueForX:@"6/27"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11134790 valueForX:@"6/26"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11167134 valueForX:@"6/25"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11157660 valueForX:@"6/24"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11067701 valueForX:@"6/21"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11055600 valueForX:@"6/20"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11034638 valueForX:@"6/19"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11029121 valueForX:@"6/18"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:11017853 valueForX:@"6/17"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10971400 valueForX:@"6/14"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10904335 valueForX:@"6/13"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10807036 valueForX:@"6/7"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10749237 valueForX:@"6/6"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10692279 valueForX:@"6/5"]];
    [line1Points addObject:[[LinePointData alloc] initWithValueForY:10658587 valueForX:@"6/4"]];
    
    LineData *line1 = [[LineData alloc] init];
    line1.linePointsDataArray = line1Points;
    line1.lineColor = [UIColor greenColor];
    line1.lineWidth = 2;
    [lines addObject:line1];
    
    /*
     line2
     */
    NSMutableArray *line2Points = [[NSMutableArray alloc] init];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9725886 valueForX:@"11/4"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9718104 valueForX:@"11/1"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9723439 valueForX:@"10/31"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9723124 valueForX:@"10/30"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9686712 valueForX:@"10/29"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9639264 valueForX:@"10/28"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9532289 valueForX:@"10/25"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9504466 valueForX:@"10/24"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9521615 valueForX:@"10/23"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9455508 valueForX:@"10/22"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9366127 valueForX:@"10/21"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9247807 valueForX:@"10/18"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9327551 valueForX:@"10/17"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9427723 valueForX:@"10/16"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9510224 valueForX:@"10/15"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9406985 valueForX:@"10/14"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9184781 valueForX:@"10/11"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8970036 valueForX:@"10/10"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8814863 valueForX:@"10/9"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8618906 valueForX:@"10/8"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8446599 valueForX:@"9/30"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8284345 valueForX:@"9/27"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8137519 valueForX:@"9/26"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7996322 valueForX:@"9/25"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7814722 valueForX:@"9/24"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7598558 valueForX:@"9/23"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7425780 valueForX:@"9/18"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7275064 valueForX:@"9/17"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7150446 valueForX:@"9/16"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7094212 valueForX:@"9/13"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7130938 valueForX:@"9/12"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7337940 valueForX:@"9/11"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7454303 valueForX:@"9/10"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7770803 valueForX:@"9/9"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7980329 valueForX:@"9/6"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7951398 valueForX:@"9/5"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7877852 valueForX:@"9/4"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7828205 valueForX:@"9/3"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7794005 valueForX:@"9/2"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7766239 valueForX:@"8/30"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7741700 valueForX:@"8/29"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7725748 valueForX:@"8/28"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7719353 valueForX:@"8/27"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7727566 valueForX:@"8/26"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7697356 valueForX:@"8/23"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7682333 valueForX:@"8/22"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7679010 valueForX:@"8/21"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7679823 valueForX:@"8/20"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7704365 valueForX:@"8/19"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7715269 valueForX:@"8/16"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7721298 valueForX:@"8/15"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7722369 valueForX:@"8/14"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7701460 valueForX:@"8/13"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7679202 valueForX:@"8/12"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7645119 valueForX:@"8/9"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7632288 valueForX:@"8/8"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7570371 valueForX:@"8/7"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7578153 valueForX:@"8/6"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7566308 valueForX:@"8/5"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7551125 valueForX:@"8/2"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7561526 valueForX:@"8/1"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7571793 valueForX:@"7/31"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7593295 valueForX:@"7/30"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7627225 valueForX:@"7/29"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7685318 valueForX:@"7/26"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7709514 valueForX:@"7/25"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7688569 valueForX:@"7/24"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7650131 valueForX:@"7/23"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7607568 valueForX:@"7/22"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7524678 valueForX:@"7/19"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7536917 valueForX:@"7/18"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7537623 valueForX:@"7/17"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7494669 valueForX:@"7/16"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7435045 valueForX:@"7/15"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7395985 valueForX:@"7/12"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7361662 valueForX:@"7/11"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7346287 valueForX:@"7/10"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7301062 valueForX:@"7/9"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7289610 valueForX:@"7/8"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7280508 valueForX:@"7/5"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7263284 valueForX:@"7/4"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7259567 valueForX:@"7/3"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7209672 valueForX:@"7/2"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7185511 valueForX:@"7/1"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7202877 valueForX:@"6/28"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7235436 valueForX:@"6/27"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7385209 valueForX:@"6/26"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7595865 valueForX:@"6/25"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:7840339 valueForX:@"6/24"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8214298 valueForX:@"6/21"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8432399 valueForX:@"6/20"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8652361 valueForX:@"6/19"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8792878 valueForX:@"6/18"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:8912146 valueForX:@"6/17"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9056599 valueForX:@"6/14"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9218664 valueForX:@"6/13"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9415963 valueForX:@"6/7"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9541762 valueForX:@"6/6"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9650720 valueForX:@"6/5"]];
    [line2Points addObject:[[LinePointData alloc] initWithValueForY:9724412 valueForX:@"6/4"]];
    
    LineData *line2 = [[LineData alloc] init];
    line2.linePointsDataArray = line2Points;
    line2.lineColor = [UIColor redColor];
    line2.lineWidth = 2;
    [lines addObject:line2];
    
    AreaChart *areaChart = [[AreaChart alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width)];
    
    areaChart.displayYTitles = YES;
    areaChart.displayLatitude = YES;
    areaChart.linesArray = lines;
    areaChart.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:areaChart];
}

// 环形图
- (void)testAnnulusChart {
    CGFloat WH = self.view.bounds.size.width;
    AnnulusChart *annulus = [[AnnulusChart alloc] initWithFrame:CGRectMake(20, 100, WH - 2*20, WH - 2*20)];
    annulus.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableArray *datas = [NSMutableArray array];
    
    [datas addObject:[[PieChartData alloc] initWithValue:140 fillColor:[UIColor orangeColor] title:@"帝舜"]];
    [datas addObject:[[PieChartData alloc] initWithValue:100 fillColor:[UIColor yellowColor] title:@"黄帝"]];
    [datas addObject:[[PieChartData alloc] initWithValue:110 fillColor:[UIColor greenColor] title:@"帝喾"]];
    [datas addObject:[[PieChartData alloc] initWithValue:120 fillColor:[UIColor cyanColor] title:@"帝颛顼"]];
    [datas addObject:[[PieChartData alloc] initWithValue:130 fillColor:[UIColor redColor] title:@"帝尧"]];
    [datas addObject:[[PieChartData alloc] initWithValue:135 fillColor:[UIColor magentaColor] title:@"帝禹"]];
    [datas addObject:[[PieChartData alloc] initWithValue:60 fillColor:[UIColor brownColor] title:@"炎帝"]];
    
    annulus.dataArray = datas;
    [self.view addSubview:annulus];
}

// 圆饼图
- (void)testPieChart {
    CGFloat WH = self.view.bounds.size.width;
    PieChart *pie = [[PieChart alloc] initWithFrame:CGRectMake(20, 100, WH - 2*20, WH - 2*20)];
    pie.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableArray *datas = [NSMutableArray array];
    
    [datas addObject:[[PieChartData alloc] initWithValue:140 fillColor:[UIColor orangeColor] title:@"帝舜"]];
    [datas addObject:[[PieChartData alloc] initWithValue:100 fillColor:[UIColor yellowColor] title:@"黄帝"]];
    [datas addObject:[[PieChartData alloc] initWithValue:110 fillColor:[UIColor greenColor] title:@"帝喾"]];
    [datas addObject:[[PieChartData alloc] initWithValue:120 fillColor:[UIColor cyanColor] title:@"帝颛顼"]];
    [datas addObject:[[PieChartData alloc] initWithValue:130 fillColor:[UIColor redColor] title:@"帝尧"]];
    [datas addObject:[[PieChartData alloc] initWithValue:135 fillColor:[UIColor magentaColor] title:@"帝禹"]];
    [datas addObject:[[PieChartData alloc] initWithValue:60 fillColor:[UIColor brownColor] title:@"炎帝"]];
    
    pie.dataArray = datas;
    
    [self.view addSubview:pie];
}

// 柱状图
- (void)testBarChart {
    NSMutableArray *datas = [NSMutableArray array];
    
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴荡" valueForY:@"12600"]];
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴渠梁" valueForY:@"20000"]];
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴稷" valueForY:@"40000"]];
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴政" valueForY:@"52700"]];
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴驷" valueForY:@"12900"]];
    [datas addObject:[[BarChartData alloc] initWithValueForX:@"嬴子楚" valueForY:@"2000"]];
    
    BarChart *barChart = [[BarChart alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width)];
    barChart.dataArray = datas;
    barChart.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barChart];
}

// 折线图
- (void)testLineChart {
    NSMutableArray *points = [NSMutableArray array];
    
    [points addObject:[[LinePointData alloc] initWithValueForX:@"11/19" valueForY:@"4000"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"11/21" valueForY:@"3987"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"12/3"  valueForY:@"3102"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"12/10" valueForY:@"3567"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"12/17" valueForY:@"3456"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"12/24" valueForY:@"3001"]];
    [points addObject:[[LinePointData alloc] initWithValueForX:@"1/7"   valueForY:@"3293"]];
    
    LineData *line = [[LineData alloc] init];
    line.linePointsDataArray = points;
    line.lineColor = [UIColor blueColor];
    line.lineWidth = 1;
    
    NSMutableArray *points2 = [NSMutableArray array];
    
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"1/7"   valueForY:@"3293"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"12/24" valueForY:@"3001"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"12/17" valueForY:@"3456"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"12/10" valueForY:@"3567"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"12/3"  valueForY:@"3102"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"11/21" valueForY:@"3987"]];
    [points2 addObject:[[LinePointData alloc] initWithValueForX:@"11/19" valueForY:@"4000"]];
    
    LineData *line2 = [[LineData alloc] init];
    line2.linePointsDataArray = points2;
    line2.lineColor = [UIColor redColor];
    line2.lineWidth = 3;
    
    NSMutableArray *lines = [NSMutableArray array];
    [lines addObject:line];
    [lines addObject:line2];
    
    LineChart *lineChart = [[LineChart alloc] initWithFrame:CGRectMake(50, 100, self.view.bounds.size.width - 50*2, self.view.bounds.size.width - 50*2)];
    
    lineChart.linesArray = lines;
    lineChart.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lineChart];
}

// 坐标系
- (void)testCoordinateSystem {
    CoordinateSystem *view = [[CoordinateSystem alloc] initWithFrame:CGRectMake(7, 100, self.view.bounds.size.width - 20, self.view.bounds.size.width - 20)];
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    
    [TitleX addObject:@"11/26"];
    [TitleX addObject:@"12/3"];
    [TitleX addObject:@"12/10"];
    [TitleX addObject:@"12/17"];
    [TitleX addObject:@"12/24"];
    [TitleX addObject:@"12/31"];
    [TitleX addObject:@"1/7"];
    [TitleX addObject:@"1/14"];
    
    view.longitudeTitles = TitleX;
    
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    
    [TitleY addObject:@"0"];
    [TitleY addObject:@"1000"];
    [TitleY addObject:@"2000"];
    [TitleY addObject:@"3000"];
    [TitleY addObject:@"4000"];
    
    view.latitudeTitles = TitleY;
    view.displayXTitles = YES;
    view.displayYTitles = YES;
    view.displayLatitude = YES;
    view.displayLongitude = YES;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
