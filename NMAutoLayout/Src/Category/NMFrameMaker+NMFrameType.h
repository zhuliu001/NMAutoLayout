//
//  NMFrameMaker+NMFrameType.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMaker.h"

@interface NMFrameMaker (NMFrameType)

- (NMFrameMakerType *)left;
- (NMFrameMakerType *)right;
- (NMFrameMakerType *)top;
- (NMFrameMakerType *)bottom;
- (NMFrameMakerType *)center;
- (NMFrameMakerType *)centerX;
- (NMFrameMakerType *)centerY;
- (NMFrameMakerType *)width;
- (NMFrameMakerType *)height;
- (NMFrameMakerType *)size;
- (NMFrameMakerType *)edges;

@end
