//
//  NMFrameMaker.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMaker.h"

@interface NMFrameMaker ()

@property (nonatomic, strong, readwrite) NMFrameMakerType *makerType;

@end

@implementation NMFrameMaker

+ (instancetype)makerWithView:(UIView *)view {
    NMFrameMaker *frameMaker = [[NMFrameMaker alloc] init];
    NMFrameMakerType *makerType = [NMFrameMakerType makerTypeWithView:view];
    frameMaker.makerType = makerType;
    return frameMaker;
}

#pragma mark - public methods

- (void)commit {
    [self.makerType commit];
}

@end
