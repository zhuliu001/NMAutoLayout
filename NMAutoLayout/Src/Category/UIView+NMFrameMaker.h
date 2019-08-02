//
//  UIView+NMFrameMaker.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <UIKit/UIKit.h>

//category
#import "NMFrameMaker+NMFrameType.h"
#import "UIView+NMAddition.h"

typedef void(^NMMakeFrameBlock)(NMFrameMaker *make);

@interface UIView (NMFrameMaker)

- (void)nm_makeFrame:(NMMakeFrameBlock)makeBlock;

@end
