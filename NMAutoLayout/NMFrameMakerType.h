//
//  NMFrameMakerType.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <Foundation/Foundation.h>
//boxValue
#import "NMFrameBoxValue.h"
//margin
#import "NMFrameMakerMargin.h"

typedef NS_ENUM(NSInteger, NMFrameType) {
    NMFrameTypeNone,
    NMFrameTypeLeft,
    NMFrameTypeRight,
    NMFrameTypeTop,
    NMFrameTypeBottom,
    NMFrameTypeCenter,
    NMFrameTypeCenterX,
    NMFrameTypeCenterY,
    NMFrameTypeWidth,
    NMFrameTypeHeight,
    NMFrameTypeSize,
    NMFrameTypeEdges
};

#define nm_equalTo(...)                 equalTo(NMBoxValue((__VA_ARGS__)))

@interface NMFrameMakerType : NSObject

@property (assign, nonatomic) NMFrameType currentType;

+ (instancetype)makerTypeWithView:(UIView *)view;

- (NMFrameMakerMargin * (^)(id))equalTo;

- (NMFrameMakerMargin * (^)(id))nm_equalTo;

- (void)commit;

@end
