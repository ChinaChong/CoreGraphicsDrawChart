//
//  AnnulusChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/23.
//  Copyright © 2018 崇. All rights reserved.
//

#import "AnnulusChart.h"
#import "PieChartData.h"

#define PI 3.141592653f

@implementation AnnulusChart

- (void)initProperty {
    [super initProperty];
    self.annulusWidthPercentToRadius = 0.3;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    if (self.dataArray && self.dataArray.count && self.annulusWidthPercentToRadius > 0 && self.annulusWidthPercentToRadius < 1) {
        
        // 数据总和
        CGFloat total = [self calcTotalValue];
        
        // 起始位置弧度
        CGFloat offset = PI * -0.5;
        // 半径和圆心
        CGFloat radius = MIN(rect.size.width, rect.size.height) / 2;
        CGPoint circleCenter = CGPointMake(rect.size.width/2, rect.size.height/2);
        
        // 遍历每一条数据列表
        for (int j = 0; j < [self.dataArray count]; j++) {
            PieChartData *entity = [self.dataArray objectAtIndex:j];
            
            //角度
            CGFloat sweep = entity.value * 2 * PI / total;
            
            // 边线绘制的宽度是圆周内一半外一半
            CGContextSetLineWidth(context, radius * self.annulusWidthPercentToRadius);
            CGContextSetStrokeColorWithColor(context, entity.fillColor.CGColor);
            CGContextAddArc(context, circleCenter.x, circleCenter.y, radius * (1 - self.annulusWidthPercentToRadius / 2), offset, offset + sweep, 0);
            CGContextStrokePath(context);
            
            //调整偏移
            offset = offset + sweep;
            
        }
    }
}

- (CGFloat)calcTotalValue {
    if (self.dataArray && self.dataArray.count) {
        CGFloat sum = 0;
        for (PieChartData *data in self.dataArray) {
            sum += data.value;
        }
        return sum;
    }
    return 0;
}

@end
