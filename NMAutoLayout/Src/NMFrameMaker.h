//
//  NMFrameMaker.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <Foundation/Foundation.h>

//type
#import "NMFrameMakerType.h"

@interface NMFrameMaker : NSObject

@property (nonatomic, strong, readonly) NMFrameMakerType *makerType;

+ (instancetype)makerWithView:(UIView *)view;

- (void)commit;

@end
