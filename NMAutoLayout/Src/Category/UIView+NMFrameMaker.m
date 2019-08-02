//
//  UIView+NMFrameMaker.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "UIView+NMFrameMaker.h"

@implementation UIView (NMFrameMaker)

- (void)nm_makeFrame:(NMMakeFrameBlock)makeBlock {
    NMFrameMaker *maker = [NMFrameMaker makerWithView:self];
    makeBlock(maker);
    [maker commit];
}

@end
