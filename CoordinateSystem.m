//
//  CoordinateSystem.m
//  图形绘制
//
//  Created by 崇 on 2018/11/15.
//  Copyright © 2018 崇. All rights reserved.
//

#import "CoordinateSystem.h"

@implementation CoordinateSystem

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
    self.borderColor = [UIColor grayColor];
    self.axisXColor = [UIColor blackColor];
    self.axisYColor = [UIColor blackColor];
    self.latitudeColor = [UIColor orangeColor];
    self.latitudeFontColor = [UIColor blackColor];
    self.longitudeColor = [UIColor orangeColor];
    self.longitudeFontColor = [UIColor blackColor];
    self.crossLinesColor = [UIColor redColor];
    self.crossLinesFontColor = [UIColor whiteColor];
    
    self.axisMarginBottom = 15.0f;
    self.axisMarginLeft = 15.0f;
    self.axisMarginTop = 13.0f;
    self.axisMarginRight = 3.0f;
    
    self.latitudeFont = [UIFont systemFontOfSize:12.0];
    self.longitudeFont = [UIFont systemFontOfSize:12.0];
    self.crossLinesFont = [UIFont systemFontOfSize:12.0];
    
    self.borderWidth = 2.0f;
    self.axisXYWidth = 1.0f;
    self.longitudeWidth = 0.5f;
    self.latitudeWidth = 0.5f;
    
    self.latitudeCount = 3;
}

- (void)drawData:(CGRect)rect {
    
}

- (void)drawRect:(CGRect)rect {
    //清理当前画面，设置背景色
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //消除锯齿
    CGContextSetAllowsAntialiasing(context, YES);
    
    /*
     坐标系是UIKit坐标系
     */
    
    //绘制边框
    [self drawBorder:rect];

    //绘制XY轴
    [self drawXAxis:rect];
    [self drawYAxis:rect];

    //绘制纬线
    [self drawLatitudeLines:rect];
    //绘制经线
    [self drawLongitudeLines:rect];
    //绘制数据
    [self drawData:rect];
    //绘制X轴标题
    [self drawXAxisTitles:rect];
    //绘制Y轴标题
    [self drawYAxisTitles:rect];

    // 绘制十字交叉线
    [self drawCrossLines:rect];
    
}

- (void)drawBorder:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.borderWidth);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextStrokePath(context);
}

- (void)drawXAxis:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.axisXYWidth);
    
    CGContextMoveToPoint(context, 0.0f, rect.size.height - self.axisMarginBottom);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - self.axisMarginBottom);
    
    CGContextSetStrokeColorWithColor(context, self.axisXColor.CGColor);
    CGContextStrokePath(context);
}

- (void)drawYAxis:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.axisXYWidth);
    
    CGContextMoveToPoint(context, self.axisMarginLeft, 0.0f);
    CGContextAddLineToPoint(context, self.axisMarginLeft, rect.size.height);
    
    CGContextSetStrokeColorWithColor(context, self.axisYColor.CGColor);
    CGContextStrokePath(context);
}

- (void)drawLatitudeLines:(CGRect)rect {
    if (!self.displayLatitude) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.latitudeWidth);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.latitudeFontColor.CGColor);
    
    if ([self.latitudeTitles count] <= 0){
        return ;
    }
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 3.0}; // 线宽和间距，长短相间可以画两条虚线，然后拼接在一起
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGFloat postOffset; // 纬线之间的间距
    postOffset = (rect.size.height - self.axisMarginBottom - self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - self.axisMarginBottom;
    
    for (int i = 1; i < [self.latitudeTitles count]; i++) {
        CGContextMoveToPoint(context, 0, offset - i * postOffset);
        CGContextAddLineToPoint(context, rect.size.width , offset - i * postOffset);
    }
    CGContextStrokePath(context);
    //还原线条
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawYAxisTitles:(CGRect)rect {
    if (!self.displayYTitles) return;
    if ([self.latitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    postOffset = (rect.size.height - self.axisMarginBottom - self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - self.axisMarginBottom;
    
    for (int i = 0; i < [self.latitudeTitles count]; i++) {
        // 左侧
        // 绘制线条
        NSString *valueStr = (NSString *) [self.latitudeTitles objectAtIndex:i];
        UIFont *textFont= self.latitudeFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.latitudeFontColor};
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
            CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        }
        
        /*
         显示右边
         */
//        textStyle.alignment=NSTextAlignmentRight;
//        //绘制右侧
//        //调整Y轴坐标位置
//        if (i == [self.latitudeTitles count] - 1) {
//            CGRect textRect= CGRectMake(rect.size.width - textSize.width - self.axisMarginRight, offset - i * postOffset, textSize.width, textSize.height);
//            //绘制字体
//            [valueStr drawInRect:textRect withAttributes:attrs];
//        } else {
//            CGRect textRect= CGRectMake(rect.size.width - textSize.width - self.axisMarginRight, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
//            //绘制字体//
//            [valueStr drawInRect:textRect withAttributes:attrs];
//        }
    }
}

- (void)drawLongitudeLines:(CGRect)rect {
    if (!self.displayLongitude) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.longitudeWidth);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 2);

    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = self.axisMarginLeft;
    
    for (int i = 1; i < self.longitudeTitles.count ; i++) {
        CGContextMoveToPoint(context, offset + i * postOffset, 0);
        CGContextAddLineToPoint(context, offset + i * postOffset, rect.size.height - self.axisMarginBottom);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawXAxisTitles:(CGRect)rect {
    if (!self.displayXTitles) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.longitudeFontColor.CGColor);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = self.axisMarginLeft;
    
    for (int i = 0; i < [self.longitudeTitles count]; i++) {
        
        // 绘制线条
        NSString *valueStr = (NSString *) [self.longitudeTitles objectAtIndex:i];
        UIFont *textFont= self.longitudeFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.longitudeFontColor};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        
        //调整X轴坐标位置
        if (i == 0) {
            CGRect textRect= CGRectMake(self.axisMarginLeft, rect.size.height - self.axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentLeft;
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
            
        } else if (i == self.longitudeTitles.count-1) {
            CGRect textRect= CGRectMake(rect.size.width - self.axisMarginRight - textSize.width, rect.size.height - self.axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentRight;
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, rect.size.height - self.axisMarginBottom, postOffset, textSize.height);
            textStyle.alignment=NSTextAlignmentCenter;
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
    if (self.singleTouchPoint.x < self.axisMarginLeft ||
        self.singleTouchPoint.y < self.axisMarginTop ||
        self.singleTouchPoint.x > rect.size.width - self.axisMarginRight ||
        self.singleTouchPoint.y > rect.size.height - self.axisMarginBottom) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
    CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);
    
    //设置线条为虚线
    CGFloat lengths[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 1);
    
    
    // 绘制刻度文字
    NSString *valueStr = [self calcAxisXGraduate:rect];
    if (![valueStr isEqualToString:@""]) {
        
        //绘制纵线
        //还原半透明
        CGContextSetAlpha(context, 1);
        // 移动初始点
        CGContextMoveToPoint(context, self.singleTouchPoint.x, 0);
        // 添加line
        CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height - self.axisMarginBottom);
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont= self.crossLinesFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment=NSTextAlignmentCenter;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.crossLinesFontColor};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        CGRect boxRect = CGRectMake(self.singleTouchPoint.x - textSize.width / 2.0, 1, textSize.width, textSize.height);
        
        CGContextAddRect(context,boxRect);
        CGContextFillPath(context);
        
        [valueStr drawInRect:boxRect withAttributes:attrs];
        
        CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
        CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);
        
        
    }

    // 绘制刻度文字
    NSString *valueStr2 = [self calcAxisYGraduate:rect];
    if (![valueStr2 isEqualToString:@""]) {
        
        //绘制横线
        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
        CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);
        
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont2= self.crossLinesFont; //设置字体
        NSMutableParagraphStyle *textStyle2 = [[NSMutableParagraphStyle alloc] init];//段落样式
        textStyle2.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle2.alignment=NSTextAlignmentLeft;
        
        NSDictionary *attrs2 = @{NSFontAttributeName:textFont2,
                                 NSParagraphStyleAttributeName:textStyle2,
                                 NSForegroundColorAttributeName:self.crossLinesFontColor};
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
    if ([self.delegate respondsToSelector:@selector(crossLineTouchPoint:xPercent:yPercent:frame:)]) {
        NSArray *titles = [self.delegate crossLineTouchPoint:self.singleTouchPoint xPercent:[self touchPointAxisXValue:rect] yPercent:[self touchPointAxisYValue:rect] frame:rect];
        return titles.firstObject;
    }
    return [NSString stringWithFormat:@"%f", [self touchPointAxisXValue:rect]];
}

- (NSString *)calcAxisYGraduate:(CGRect)rect {
    if ([self.delegate respondsToSelector:@selector(crossLineTouchPoint:xPercent:yPercent:frame:)]) {
        NSArray *titles = [self.delegate crossLineTouchPoint:self.singleTouchPoint xPercent:[self touchPointAxisXValue:rect] yPercent:[self touchPointAxisYValue:rect] frame:rect];
        return titles.lastObject;
    }
    return [NSString stringWithFormat:@"%f", [self touchPointAxisYValue:rect]];
}

- (CGFloat)touchPointAxisXValue:(CGRect)rect {
    CGFloat length = rect.size.width - self.axisMarginLeft - self.axisMarginRight;
    CGFloat valueLength = self.singleTouchPoint.x - self.axisMarginLeft ;
    return valueLength / length;
}

- (CGFloat)touchPointAxisYValue:(CGRect)rect {
    CGFloat length = rect.size.height - self.axisMarginBottom - self.axisMarginTop;
    CGFloat valueLength = length - (self.singleTouchPoint.y - self.axisMarginTop);
    
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

@end
