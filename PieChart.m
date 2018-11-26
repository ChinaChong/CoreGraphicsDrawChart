//
//  PieChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/22.
//  Copyright © 2018 崇. All rights reserved.
//

#import "PieChart.h"
#import "PieChartData.h"

#define PI 3.141592653f

@implementation PieChart

- (id)init {
    self = [super init];
    if (self) {
        //初始化属性
        [self initProperty];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //初始化属性
        [self initProperty];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        //初始化属性
        [self initProperty];
    }
    return self;
}

- (void)initProperty {
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 1;
    self.titleFont = [UIFont systemFontOfSize:14];
    self.titleColor = [UIColor blackColor];
}

- (void)drawRect:(CGRect)rect {
    if (!self.dataArray || !self.dataArray.count) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextSetAllowsAntialiasing(context, YES);
    
    // 数据总和
    CGFloat total = [self calcTotalValue];
    // 起始位置弧度
    CGFloat offset = PI * -0.5;
    // 半径和圆心
    CGFloat radius = MIN(rect.size.width, rect.size.height) / 2;
    CGPoint circleCenter = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    for (PieChartData *data in self.dataArray) {
        if (data) {
            // 拿出数据
            CGFloat value = data.value;
            // 计算百分比
            CGFloat percent = value / total;
            // 确定分支弧度
            CGFloat endAngle = percent * 2 * PI;
            
            // 移动至圆心
            CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
            // 添加一个圆
            CGContextAddArc(context, circleCenter.x, circleCenter.y, radius, offset, endAngle + offset, 0);
            // 关闭路径
            CGContextClosePath(context);
            // 设置填充色
            CGContextSetFillColorWithColor(context, data.fillColor.CGColor);
            // 填充
            CGContextFillPath(context);
            
            /*
             绘制边框线
             */
            
            // 移动至圆心
            CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
            // 添加一个圆弧
            CGContextAddArc(context, circleCenter.x, circleCenter.y, radius, offset, endAngle + offset, 0);
            // 关闭路径
            CGContextClosePath(context);
            // 设置画笔颜色
            CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
            // 画线
            CGContextStrokePath(context);
            
            /*
             绘制标题和百分比
             */
            
            // 一半的弧度
            CGFloat halfAngle = offset + endAngle/2;
            CGFloat X = circleCenter.x + radius*0.7*cos(halfAngle);
            CGFloat Y = circleCenter.y + radius*0.7*sin(halfAngle);
            
            NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];//段落样式
            textStyle.alignment = NSTextAlignmentCenter;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attrs = @{NSFontAttributeName:self.titleFont,
                                    NSParagraphStyleAttributeName:textStyle,
                                    NSForegroundColorAttributeName:self.titleColor};
            // 拼接 标题 和 百分比
            NSString *text = [NSString stringWithFormat:@"%@\n%.2f%%", data.title, percent*100];
            CGSize titleSize = [text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            CGRect textRect= CGRectMake(X - titleSize.width / 2, Y - titleSize.height / 2, titleSize.width, titleSize.height);
            [text drawInRect:textRect withAttributes:attrs];
            
            // 弧度积累偏移
            offset += endAngle;
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
