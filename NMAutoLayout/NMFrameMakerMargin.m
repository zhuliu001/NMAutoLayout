//
//  NMFrameMakerMargin.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMakerMargin.h"

@interface NMFrameMakerMargin ()

@property (nonatomic, copy) NMFrameMakerMarginHandler marginHandler;

@end

@implementation NMFrameMakerMargin

+ (instancetype)marginWithHandler:(NMFrameMakerMarginHandler)marginHandler {
    NMFrameMakerMargin *margin = [[NMFrameMakerMargin alloc] init];
    margin.marginHandler = marginHandler;
    return margin;
}

#pragma mark - public methods

- (void (^)(CGFloat))margin {
    return ^(CGFloat margin) {
        if (self.marginHandler) {
            self.marginHandler(margin);
        }
    };
}

@end
