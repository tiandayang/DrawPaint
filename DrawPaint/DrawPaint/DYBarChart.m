//
//  DYBarChart.m
//  DrawPaint
//
//  Created by 田向阳 on 2017/12/18.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "DYBarChart.h"

@interface DYBarChart ()

@property (nonatomic, assign) DYChartType type;
@property (nonatomic, assign) CGFloat totalValue;

@end

@implementation DYBarChart

- (instancetype)initWithFrame:(CGRect)frame chartType:(DYChartType)chartType
{
    if (self = [super initWithFrame:frame]) {
        _type = chartType;
    }
    return self;
}

- (void)setValues:(NSArray<NSNumber *> *)values
{
    _values = values;
    __block CGFloat total = 0;
    [values enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.floatValue;
    }];
    self.totalValue = total;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_type == DYChartTypeBar) {
        CGFloat space = 10;
        CGFloat width = (rect.size.width - (self.values.count + 1) * space)/self.values.count;
        [_values enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat value = obj.floatValue;
            CGFloat x = idx * (width + space) + space;
            CGFloat scale = value/self.totalValue;
            CGFloat y = rect.size.height * (1 - scale);
            CGFloat height = rect.size.height * scale;
            CGRect barRect = CGRectMake(x, y, width, height);
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:barRect];
            CGFloat randRed = arc4random_uniform(256)/255.0;
            CGFloat randGreen = arc4random_uniform(256)/255.0;
            CGFloat randBlue = arc4random_uniform(256)/255.0;
            UIColor *fillColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1.0];
            [fillColor set];
            [path fill];
            
            CGFloat x1 = barRect.origin.x + width/2 ;
            CGFloat y1 = barRect.origin.y - 15;
            NSString *scaleStr = [NSString stringWithFormat:@"%.2f%%",scale * 100];
            NSMutableDictionary * paras = [NSMutableDictionary dictionary];
            paras[NSFontAttributeName] = [UIFont systemFontOfSize:10];
            CGSize fontSize = [scaleStr sizeWithAttributes:paras];
            CGPoint currentPoint = CGPointMake(x1 , y1 );
            CGRect fontRect = CGRectMake(currentPoint.x - fontSize.width/2, currentPoint.y - fontSize.height/2, fontSize.width, fontSize.height);
            [scaleStr drawInRect:fontRect withAttributes:paras];
        }];
    }else if (_type == DYChartTypePie){
        CGFloat centerX = rect.size.width/2;
        CGFloat centerY = rect.size.height/2;
        CGFloat radius = MIN(rect.size.width, rect.size.height)/2;
        CGFloat startAngle = 0;
        CGFloat endAngle = 0;
        for (NSNumber *v in self.values) {
            CGFloat value = v.floatValue;
            CGFloat scale = value/_totalValue;
            startAngle = endAngle;
            endAngle = startAngle + scale * 2 * M_PI;
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
            [path addLineToPoint:CGPointMake(centerX, centerY)];
            CGFloat randRed = arc4random_uniform(256)/255.0;
            CGFloat randGreen = arc4random_uniform(256)/255.0;
            CGFloat randBlue = arc4random_uniform(256)/255.0;
            UIColor *fillColor = [UIColor colorWithRed:randRed green:randGreen blue:randBlue alpha:1.0];
            [fillColor set];
            [path fill];
            
            CGFloat x1 = centerX + radius * 0.6 * cos((endAngle + startAngle)/2);
            CGFloat y1 = centerY + radius * 0.6 * sin((endAngle + startAngle)/2);
            NSString *scaleStr = [NSString stringWithFormat:@"%.2f%%",scale * 100];
            NSMutableDictionary * paras = [NSMutableDictionary dictionary];
            paras[NSFontAttributeName] = [UIFont systemFontOfSize:10];
            CGSize fontSize = [scaleStr sizeWithAttributes:paras];
            CGPoint currentPoint = CGPointMake(x1 , y1 );
            CGRect fontRect = CGRectMake(currentPoint.x - fontSize.width/2, currentPoint.y - fontSize.height/2, fontSize.width, fontSize.height);
            [scaleStr drawInRect:fontRect withAttributes:paras];
        }
    }
}

@end
