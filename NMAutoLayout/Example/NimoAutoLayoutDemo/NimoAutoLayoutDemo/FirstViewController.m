//
//  FirstViewController.m
//  NimoAutoLayoutDemo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "FirstViewController.h"
#import "AutoLayoutTestView.h"
#import "UIView+NMFrameMaker.h"


@interface FirstViewController ()

@property (nonatomic, strong) AutoLayoutTestView *testView;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testView = [[AutoLayoutTestView alloc] init];
    [self.view addSubview:self.testView];
    [self.testView setTipTitle:@"This is NimoAutoLayout Example"
                       content:@"This example tell us how to use api and auto layout view easyly."];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.testView nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.view).margin(10);
        make.top.equalTo(self.view).margin(40);
        make.width.equalTo(@(self.view.nm_width - 20));
        make.height.equalTo(@(100));
    }];
}

- (AutoLayoutTestView *)testView {
    if (!_testView) {
        _testView = [[AutoLayoutTestView alloc] init];
    }
    return _testView;
}


@end
