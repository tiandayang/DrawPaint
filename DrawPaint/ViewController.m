//
//  ViewController.m
//  DrawPaint
//
//  Created by 田向阳 on 2017/12/18.
//  Copyright © 2017年 田向阳. All rights reserved.
//

#import "ViewController.h"
#import "DYBarChart.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - ViewcontrollerLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControllerFirstData];
    [self createUI];
    [self loadData];
}

#pragma mark - LoadData
- (void)loadData
{
    
}

- (void)initControllerFirstData
{
    self.title = NSLocalizedString(@"", nil);
}

#pragma mark - Action

#pragma mark - CreateUI
- (void)createUI
{
    DYBarChart * pie = [[DYBarChart alloc] initWithFrame:CGRectMake(20, 64, 200, 200)chartType:DYChartTypePie];
    pie.values = @[@12,@24,@36,@48,@60];
    pie.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:pie];
    
    DYBarChart *bar = [[DYBarChart alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.frame), self.view.frame.size.height - 450)chartType:DYChartTypeBar];
    bar.values = @[@12,@24,@36,@48,@60];
    bar.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:bar];
}

@end
