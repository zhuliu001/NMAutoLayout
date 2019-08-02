//
//  NMFrameMakerOffset.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^NMFrameMakerOffsetHandler)(CGFloat offset);

@interface NMFrameMakerOffset : NSObject

+ (instancetype)offsetWithHandler:(NMFrameMakerOffsetHandler)offsetHandler;

- (void (^)(CGFloat))offset;

@end
