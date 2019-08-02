//
//  UIView+NMAddition.h
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NMAddition)

@property (nonatomic, assign) CGFloat nm_width;
@property (nonatomic, assign) CGFloat nm_height;
@property (nonatomic, assign) CGFloat nm_x;
@property (nonatomic, assign) CGFloat nm_y;

@property (nonatomic, strong) NSNumber *nm_left;
@property (nonatomic, strong) NSNumber *nm_right;
@property (nonatomic, strong) NSNumber *nm_top;
@property (nonatomic, strong) NSNumber *nm_bottom;

@property (nonatomic, strong) NSNumber *nm_centerX;
@property (nonatomic, strong) NSNumber *nm_centerY;

/**
 禁用RTL（特殊场景下允许在阿拉伯语中不开启RTL）
 */
@property (nonatomic, assign, readwrite) BOOL nm_forbidRTL;

/**
 是否开启RTL
 */
@property (nonatomic, assign, readonly)  BOOL nm_enableLayoutRTL;


@end
