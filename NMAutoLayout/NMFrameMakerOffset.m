//
//  NMFrameMakerOffset.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMakerOffset.h"

@interface NMFrameMakerOffset ()

@property (nonatomic, copy) NMFrameMakerOffsetHandler offsetHandler;

@end

@implementation NMFrameMakerOffset

+ (instancetype)offsetWithHandler:(NMFrameMakerOffsetHandler)offsetHandler {
    NMFrameMakerOffset *offset = [[NMFrameMakerOffset alloc] init];
    offset.offsetHandler = offsetHandler;
    return offset;
}

#pragma mark - public methods

- (void (^)(CGFloat))offset {
    return ^(CGFloat offset) {
        if (self.offsetHandler) {
            self.offsetHandler(offset);
        }
    };
}

@end
