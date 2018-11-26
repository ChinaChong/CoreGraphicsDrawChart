//
//  CoordinateSystem.h
//  图形绘制
//
//  Created by 崇 on 2018/11/15.
//  Copyright © 2018 崇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CoordinateSystemDelegate <NSObject>
- (NSArray *)crossLineTouchPoint:(CGPoint)touchPoint xPercent:(CGFloat)xPercent yPercent:(CGFloat)yPercent frame:(CGRect)rect;
@end

/**
 一个简单的网格坐标系，带十字交叉线
 */
@interface CoordinateSystem : UIView

@property (nonatomic, weak) id<CoordinateSystemDelegate> delegate;

/**
 边框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 X轴颜色
 */
@property (nonatomic, strong) UIColor *axisXColor;

/**
 Y轴颜色
 */
@property (nonatomic, strong) UIColor *axisYColor;

/**
 网格线 纬线颜色
 */
@property (nonatomic, strong) UIColor *latitudeColor;

/**
 网格线 经线颜色
 */
@property (nonatomic, strong) UIColor *longitudeColor;

/**
 纬线刻度字体颜色
 */
@property (nonatomic, strong) UIColor *latitudeFontColor;

/**
 经线刻度字体颜色
 */
@property (nonatomic, strong) UIColor *longitudeFontColor;

/**
 十字交叉线颜色
 */
@property (nonatomic, strong) UIColor *crossLinesColor;

/**
 十字交叉线刻度字体颜色
 */
@property (nonatomic, strong) UIColor *crossLinesFontColor;

/**
 X轴标题
 */
@property (nonatomic, strong) NSMutableArray *latitudeTitles;

/**
 Y轴标题
 */
@property (nonatomic, strong) NSMutableArray *longitudeTitles;

/**
 轴线下边距
 */
@property (nonatomic, assign) CGFloat axisMarginBottom;

/**
 轴线左边距
 */
@property (nonatomic, assign) CGFloat axisMarginLeft;

/**
 轴线上边距
 */
@property (nonatomic, assign) CGFloat axisMarginTop;

/**
 轴线右边距
 */
@property (nonatomic, assign) CGFloat axisMarginRight;

/**
 纬线标题字体
 */
@property (nonatomic, strong) UIFont *latitudeFont;

/**
 经线标题字体
 */
@property (nonatomic, strong) UIFont *longitudeFont;

/**
 十字交叉线刻度字体
 */
@property (nonatomic, strong) UIFont *crossLinesFont;

/**
 单点触控的选中点
 */
@property(assign, nonatomic ,setter = setSingleTouchPoint:) CGPoint singleTouchPoint;

/**
 边框线宽
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 XY轴线宽
 */
@property (nonatomic, assign) CGFloat axisXYWidth;

/**
 经线宽
 */
@property (nonatomic, assign) CGFloat longitudeWidth;

/**
 纬线宽
 */
@property (nonatomic, assign) CGFloat latitudeWidth;

/**
 十字交叉线宽
 */
@property (nonatomic, assign) CGFloat crossLinesWidth;

/**
 经线数量
 */
@property (nonatomic, assign) NSUInteger longitudeCount;

/**
 纬线数量
 */
@property (nonatomic, assign) NSUInteger latitudeCount;

/**
 显示经线
 */
@property (nonatomic, assign) BOOL displayLongitude;

/**
 显示纬线
 */
@property (nonatomic, assign) BOOL displayLatitude;

/**
 显示X轴刻度
 */
@property (nonatomic, assign) BOOL displayXTitles;

/**
 显示Y轴刻度
 */
@property (nonatomic, assign) BOOL displayYTitles;

- (void)initProperty;
- (void)drawData:(CGRect)rect;
- (void)drawXAxisTitles:(CGRect)rect;

@end
