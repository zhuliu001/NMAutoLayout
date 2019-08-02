//
//  UIView+NMAddition.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "UIView+NMAddition.h"
#import <objc/runtime.h>



@implementation UIView (NMAddition)

#pragma mark - getter

- (CGFloat)superviewWidth {
    return self.superview.nm_width;
}

- (CGFloat)nm_width {
    return self.frame.size.width;
}

- (CGFloat)nm_height {
    return self.frame.size.height;
}

- (CGFloat)nm_x {
    if (self.nm_enableLayoutRTL) {
        return [self superviewWidth] - CGRectGetMaxX(self.frame);
    }
    return self.frame.origin.x;
}

- (CGFloat)nm_y {
    return self.frame.origin.y;
}

- (NSNumber *)nm_centerX {
    return @(self.center.x);
}

- (NSNumber *)nm_centerY {
    return @(self.center.y);
}

- (NSNumber *)nm_left {
    if (self.nm_enableLayoutRTL) {
        return @([self superviewWidth] - CGRectGetMaxX(self.frame));
    }
    return @(CGRectGetMinX(self.frame));
}

- (NSNumber *)nm_right {
    if (self.nm_enableLayoutRTL) {
        return @([self superviewWidth] - CGRectGetMinX(self.frame));
    }
    return @(CGRectGetMaxX(self.frame));
}

- (NSNumber *)nm_top {
    return @(CGRectGetMinY(self.frame));
}

- (NSNumber *)nm_bottom {
    return @(CGRectGetMaxY(self.frame));
}

#pragma mark - setter

- (void)setNm_width:(CGFloat)nm_width {
    CGRect frame = self.frame;
    frame.size.width = nm_width;
    self.frame = frame;
}

- (void)setNm_height:(CGFloat)nm_height {
    CGRect frame = self.frame;
    frame.size.height = nm_height;
    self.frame = frame;
}
- (void)setNm_x:(CGFloat)nm_x {
    CGRect frame = self.frame;
    frame.origin.x = nm_x;
    self.frame = frame;
}

- (void)setNm_y:(CGFloat)nm_y {
    CGRect frame = self.frame;
    frame.origin.y = nm_y;
    self.frame = frame;
}

- (void)setNm_centerX:(NSNumber *)nm_centerX {
    CGPoint center = self.center;
    center.x = nm_centerX.floatValue;
    self.center = center;
}

- (void)setNm_centerY:(NSNumber *)nm_centerY {
    CGPoint center = self.center;
    center.y = nm_centerY.floatValue;
    self.center = center;
}

- (void)setNm_left:(NSNumber *)nm_left {
    self.nm_x = nm_left.floatValue;
}

- (void)setNm_right:(NSNumber *)nm_right {
    CGRect frame = self.frame;
    frame.origin.x = nm_right.floatValue - CGRectGetWidth(self.frame);
    self.frame = frame;
}

- (void)setNm_top:(NSNumber *)nm_top {
    self.nm_y = nm_top.floatValue;
}

- (void)setNm_bottom:(NSNumber *)nm_bottom {
    CGRect frame = self.frame;
    frame.origin.x = nm_bottom.floatValue - CGRectGetHeight(self.frame);
    self.frame = frame;
}

#pragma mark - Getter/Setter

- (BOOL)nm_enableLayoutRTL {
    return (UIView.appearance.semanticContentAttribute == UISemanticContentAttributeForceRightToLeft) && !self.nm_forbidRTL;
}

- (BOOL)nm_forbidRTL {
    return [objc_getAssociatedObject(self, @selector(nm_forbidRTL)) boolValue];
}

- (void)setNm_forbidRTL:(BOOL)nm_forbidRTL {
    objc_setAssociatedObject(self, @selector(nm_forbidRTL), @(nm_forbidRTL), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
