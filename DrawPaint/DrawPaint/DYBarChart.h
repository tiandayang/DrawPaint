//
//  DYBarChart.h
//  DrawPaint
//
//  Created by 田向阳 on 2017/12/18.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DYChartType) {
    DYChartTypeBar = 0,  //柱状图
    DYChartTypePie = 1  //饼状图
};

@interface DYBarChart : UIView

@property (nonatomic, strong) NSArray <NSNumber * >*values;

- (instancetype)initWithFrame:(CGRect)frame chartType:(DYChartType)chartType;

@end
