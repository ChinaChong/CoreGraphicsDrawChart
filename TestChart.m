//
//  TestChart.m
//  图形绘制
//
//  Created by 崇 on 2018/11/23.
//  Copyright © 2018 崇. All rights reserved.
//

#import "TestChart.h"

@implementation TestChart

static CGFloat axisMarginBottom = 15;
static CGFloat axisMarginLeft = 15;
static CGFloat axisMarginRight = 3;
static CGFloat axisMarginTop = 3;
- (void)drawRect:(CGRect)rect {
    [self haha];
    return;
    // 获取绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置背景填充色
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    // 填充整个绘制区域
    CGContextFillRect(context, rect);
    
    // 设置边框线宽
    CGContextSetLineWidth(context, 2);
    // 设置起始点
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    // 添加一个矩形路径
    CGContextAddRect(context, rect);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    // 绘制路径
    CGContextStrokePath(context);
    
    // 重新设置X轴线宽
    CGContextSetLineWidth(context, 1);
    // 设置绘制X轴的起始点
    CGContextMoveToPoint(context, 0.0f, rect.size.height - axisMarginBottom);
    // 添加绘制X轴线的路径
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - axisMarginBottom);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    // 绘制路径
    CGContextStrokePath(context);
    
    // 绘制Y轴线
    CGContextMoveToPoint(context, axisMarginLeft, 0.0f);
    CGContextAddLineToPoint(context, axisMarginLeft, rect.size.height);
    
    CGContextStrokePath(context);
    
    // 绘制经线
    [self drawLongitudeLines:rect];
    
    // 绘制X轴刻度线
    [self drawXAxisTitles:rect];
    
    // 绘制纬线
    [self drawLatitudeLines:rect];
    
    // 绘制Y轴刻度线
    [self drawYAxisTitles:rect];
    
    // 绘制十字交叉线
    [self drawCrossLines:rect];
}

- (void)haha {
    // 设置字体
    UIFont *textFont= [UIFont systemFontOfSize:15];
    // 设置属性
    NSDictionary *attrs = @{NSFontAttributeName:textFont,
                            NSForegroundColorAttributeName:[UIColor blackColor]};
    // 文字的绘制区域
    CGRect textRect = CGRectMake(100, 100, 100, 100);
    // 绘制文字
    [@"Hello World!" drawInRect:textRect withAttributes:attrs];
}

- (void)drawLongitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - axisMarginLeft - axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = axisMarginLeft;
    
    for (int i = 1; i < self.longitudeTitles.count ; i++) {
        CGContextMoveToPoint(context, offset + i * postOffset, 0);
        CGContextAddLineToPoint(context, offset + i * postOffset, rect.size.height - axisMarginBottom);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawXAxisTitles:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - axisMarginLeft - axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = axisMarginLeft;
    
    for (int i = 0; i < [self.longitudeTitles count]; i++) {
        
        // 绘制线条
        NSString *valueStr = (NSString *) [self.longitudeTitles objectAtIndex:i];
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        
        // 调整X轴坐标位置
        // 第一个刻度的位置要绘制在Y轴线右侧
        if (i == 0) {
            CGRect textRect= CGRectMake(axisMarginLeft, rect.size.height - axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentLeft;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
            
        }
        // 最后一个刻度的位置要绘制在最后一条经线的左侧
        else if (i == self.longitudeTitles.count-1) {
            CGRect textRect= CGRectMake(rect.size.width - axisMarginRight - textSize.width, rect.size.height - axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentRight;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(offset + (i-0.5) * postOffset, rect.size.height - axisMarginBottom, postOffset, textSize.height);
            textStyle.alignment=NSTextAlignmentCenter;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        }
    }
}

- (void)drawLatitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    if ([self.latitudeTitles count] <= 0){
        return ;
    }
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 3.0}; // 线宽和间距，长短相间可以画两条虚线，然后拼接在一起
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGFloat postOffset; // 纬线之间的间距
    postOffset = (rect.size.height - axisMarginBottom - axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - axisMarginBottom;
    
    for (int i = 1; i < [self.latitudeTitles count]; i++) {
        CGContextMoveToPoint(context, 0, offset - i * postOffset);
        CGContextAddLineToPoint(context, rect.size.width , offset - i * postOffset);
    }
    CGContextStrokePath(context);
    //还原线条
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawYAxisTitles:(CGRect)rect {
    if ([self.latitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    postOffset = (rect.size.height - axisMarginBottom - axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - axisMarginBottom;
    
    for (int i = 0; i < [self.latitudeTitles count]; i++) {
        // 左侧
        // 绘制线条
        NSString *valueStr = (NSString *) [self.latitudeTitles objectAtIndex:i];
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        /*
         显示左边
         */
        textStyle.alignment=NSTextAlignmentLeft;
        //调整Y轴坐标位置
        if (i == [self.latitudeTitles count] - 1) {
            CGRect textRect= CGRectMake(axisMarginLeft, offset - i * postOffset, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(axisMarginLeft, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        }
    }
}

/**
 绘制十字交叉线
 
 @param rect 绘制区域
 */
- (void)drawCrossLines:(CGRect)rect {
    
    //过滤非显示区域的点
    if (self.singleTouchPoint.x < axisMarginLeft ||
        self.singleTouchPoint.y < axisMarginTop ||
        self.singleTouchPoint.x > rect.size.width - axisMarginRight ||
        self.singleTouchPoint.y > rect.size.height - axisMarginBottom) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    
    //设置线条为虚线
    CGFloat lengths[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 1);
    
    
    // 绘制纵向刻度文字
    NSString *valueStr = [self calcAxisXGraduate:rect];
    if (![valueStr isEqualToString:@""]) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        
        //绘制纵线
        //还原半透明
        CGContextSetAlpha(context, 1);
        // 移动初始点
        CGContextMoveToPoint(context, self.singleTouchPoint.x, 0);
        // 添加line
        CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height - axisMarginBottom);
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment=NSTextAlignmentCenter;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        CGRect boxRect = CGRectMake(self.singleTouchPoint.x - textSize.width / 2.0, 1, textSize.width, textSize.height);
        
        CGContextAddRect(context,boxRect);
        CGContextFillPath(context);
        
        [valueStr drawInRect:boxRect withAttributes:attrs];
    }
    
    // 绘制横向刻度文字
    NSString *valueStr2 = [self calcAxisYGraduate:rect];
    if (![valueStr2 isEqualToString:@""]) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        
        //绘制横线
        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
        CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);
        
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont2= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle2 = [[NSMutableParagraphStyle alloc] init];//段落样式
        textStyle2.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle2.alignment=NSTextAlignmentLeft;
        
        NSDictionary *attrs2 = @{NSFontAttributeName:textFont2,
                                 NSParagraphStyleAttributeName:textStyle2,
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
        CGSize textSize2 = [valueStr2 boundingRectWithSize:CGSizeMake(100, 100)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attrs2
                                                   context:nil].size;
        CGRect boxRect2 = CGRectMake(1, self.singleTouchPoint.y - textSize2.height / 2.0, textSize2.width, textSize2.height);
        
        CGContextAddRect(context,boxRect2);
        CGContextFillPath(context);
        
        [valueStr2 drawInRect:boxRect2 withAttributes:attrs2];
    }
    
    CGContextSetLineDash(context, 0, nil, 0);
}

- (NSString *)calcAxisXGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisXValue:rect]];
}

- (NSString *)calcAxisYGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisYValue:rect]];
}

- (CGFloat)touchPointAxisXValue:(CGRect)rect {
    CGFloat length = rect.size.width - axisMarginLeft - axisMarginRight;
    CGFloat valueLength = self.singleTouchPoint.x - axisMarginLeft ;
    return valueLength / length;
}

- (CGFloat)touchPointAxisYValue:(CGRect)rect {
    CGFloat length = rect.size.height - axisMarginBottom - axisMarginTop;
    CGFloat valueLength = length - (self.singleTouchPoint.y - axisMarginTop);
    
    return valueLength / length;
}

- (void)setSingleTouchPoint:(CGPoint)point {
    _singleTouchPoint = point;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //重绘
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //重绘
        [self setNeedsDisplay];
    }
}





/*
 搞一个直角拐，填充失败，最多两条线可以做闭合区域
 */
- (void)zhijiao {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 10);
    CGContextAddLineToPoint(context, 300, 10);
    
    CGContextMoveToPoint(context, 300, 10);
    CGContextAddLineToPoint(context, 300, 300);
    
    CGContextMoveToPoint(context, 300, 300);
    CGContextAddLineToPoint(context, 200, 300);
    
    CGContextMoveToPoint(context, 200, 300);
    CGContextAddLineToPoint(context, 200, 100);
    
    CGContextMoveToPoint(context, 200, 100);
    CGContextAddLineToPoint(context, 0, 100);
    CGContextAddLineToPoint(context, 0, 10);
    
//    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextSetLineWidth(context, 2);
//    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillPath(context);
}

/*
 两个不相干的矩形都可以被正常填充
 */
- (void)towRect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddRect(context, CGRectMake(10, 10, 50, 50));
    
    CGContextMoveToPoint(context, 210, 10);
    CGContextAddRect(context, CGRectMake(210, 10, 50, 50));
    
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillPath(context);
}

- (void)draw:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 2);
    
    NSArray *line1 = @[@10,@60,@10,@60,@10];
    
    CGFloat spacing = 50;
    CGFloat X = 30;
    for (int i = 0; i < line1.count; i++) {
        CGFloat Y = [line1[i] floatValue];
        if (i == 0) {
            CGContextMoveToPoint(context, X, Y);
        }
        else {
            CGContextAddLineToPoint(context, X, Y);
        }
        X = X + spacing;
    }
    
    CGContextMoveToPoint(context, 230, 10);
    CGContextAddLineToPoint(context, 130, 300);
    CGContextAddLineToPoint(context, 30, 10);
    
//    CGContextMoveToPoint(context, 30, 200);
//    CGContextAddLineToPoint(context, 30, 10);
    
    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextFillPath(context);

}

/*
 CGContextAddLineToPoint添加完线段后，点也移动到新的端点处，再接CGContextAddLineToPoint会继续从上一次的点开始画。
 
 CGContextFillPath和CGContextStrokePath会消耗掉当前context中的点和线即路径，再次调用需要重新移动点添加线。
 
 CGContextFillPath填充最多可以两条线实现闭合，三条线就失灵了
 
 CGContextClosePath 这将从路径的终点到起点追加一条线。如果你打算填充一段路径，那么就不需要使用该命令，因为该命令会被自动调用。
 
 两个不相干的矩形都可以被正常填充
 */

@end
