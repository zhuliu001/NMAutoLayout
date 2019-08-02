//
//  NMFrameMakerMargin.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^NMFrameMakerMarginHandler)(CGFloat margin);

@interface NMFrameMakerMargin : NSObject

+ (instancetype)marginWithHandler:(NMFrameMakerMarginHandler)marginHandler;

- (void (^)(CGFloat))margin;

@end
