//
//  NMFrameMaker+NMFrameType.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMaker+NMFrameType.h"

@implementation NMFrameMaker (NMFrameType)

#pragma mark - public methods

- (NMFrameMakerType *)left {
    self.makerType.currentType = NMFrameTypeLeft;
    return self.makerType;
}

- (NMFrameMakerType *)right {
    self.makerType.currentType = NMFrameTypeRight;
    return self.makerType;
}

- (NMFrameMakerType *)top {
    self.makerType.currentType = NMFrameTypeTop;
    return self.makerType;
}

- (NMFrameMakerType *)bottom {
    self.makerType.currentType = NMFrameTypeBottom;
    return self.makerType;
}

- (NMFrameMakerType *)center {
    self.makerType.currentType = NMFrameTypeCenter;
    return self.makerType;
}

- (NMFrameMakerType *)centerX {
    self.makerType.currentType = NMFrameTypeCenterX;
    return self.makerType;
}

- (NMFrameMakerType *)centerY {
    self.makerType.currentType = NMFrameTypeCenterY;
    return self.makerType;
}

- (NMFrameMakerType *)width {
    self.makerType.currentType = NMFrameTypeWidth;
    return self.makerType;
}

- (NMFrameMakerType *)height {
    self.makerType.currentType = NMFrameTypeHeight;
    return self.makerType;
}

- (NMFrameMakerType *)size {
    self.makerType.currentType = NMFrameTypeSize;
    return self.makerType;
}

- (NMFrameMakerType *)edges {
    self.makerType.currentType = NMFrameTypeEdges;
    return self.makerType;
}

@end
