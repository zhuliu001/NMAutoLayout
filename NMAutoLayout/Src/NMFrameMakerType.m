//
//  NMFrameMakerType.m
//  nimo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "NMFrameMakerType.h"

//category
#import "UIView+NMAddition.h"


@interface NMFrameMakerType ()

@property (nonatomic, strong) NMFrameMakerMargin *makerMargin;
@property (nonatomic, weak, readwrite) UIView *view;

@property (nonatomic, assign) CGFloat finalWidth;
@property (nonatomic, assign) CGFloat finalHeight;
@property (nonatomic, assign) CGFloat finalOffsetX;
@property (nonatomic, assign) CGFloat finalOffsetY;
@property (nonatomic, assign) CGFloat finalCenterX;
@property (nonatomic, assign) CGFloat finalCenterY;
@property (nonatomic, assign) BOOL hasCenterX;
@property (nonatomic, assign) BOOL hasCenterY;
@property (nonatomic, assign) BOOL hasOffsetX;
@property (nonatomic, assign) BOOL hasMinusWidth;

@end

@implementation NMFrameMakerType

+ (instancetype)makerTypeWithView:(UIView *)view {
    NMFrameMakerType *makerType = [[NMFrameMakerType alloc] init];
    makerType.view = view;
    [view sizeToFit];
    makerType.finalWidth = view.nm_width;
    makerType.finalHeight = view.nm_height;
    return makerType;
}

#pragma mark - public methods

- (NMFrameMakerMargin * (^)(id))equalTo {
    return ^(id object) {
        UIView *anotherView;
        NSNumber *number;
        NSValue *value;
        if ([[object class] isSubclassOfClass:[UIView class]]) {
            anotherView = (UIView *)object;
        } else if ([object isKindOfClass:[NSNumber class]]) {
            number = (NSNumber *)object;
        } else if ([object isKindOfClass:[NSValue class]]) {
            value = (NSValue *)object;
        }
        
        NSAssert(!(!anotherView && (number == nil) && !value),
                 @"【%@】+【frame type : %zd】equal to unknown +【object : %@】", self.view, self.currentType, object);
        
#define IS_SUPERVIEW                   (self.view.superview == anotherView)
#define IS_THE_SAME_SUPERVIEW          (self.view.superview == anotherView.superview)
        
        switch (self.currentType) {
            case NMFrameTypeNone: {
                break;
            }
            case NMFrameTypeLeft: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalOffsetX = 0;
                        
                        if (self.view.nm_enableLayoutRTL) {
                            self.finalOffsetX = [self superviewWidth];
                        }
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalOffsetX = CGRectGetMinX(anotherView.frame);
                        if (self.view.nm_enableLayoutRTL) {
                            self.finalOffsetX = CGRectGetMaxX(anotherView.frame);
                        }
                    }
                } else {
                    self.finalOffsetX = number.floatValue;
                    if (self.view.nm_enableLayoutRTL) {
                        self.finalOffsetX = [self superviewWidth] - number.floatValue;
                    }
                }
                
                self.hasOffsetX = YES;
                break;
            }
            case NMFrameTypeRight: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalOffsetX = anotherView.nm_width - self.finalWidth;
                        if (self.view.nm_enableLayoutRTL) {
                            self.finalOffsetX = [self superviewWidth] - self.finalOffsetX;
                        }
                        
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalOffsetX = CGRectGetMaxX(anotherView.frame) - self.finalWidth;
                        
                        if (self.view.nm_enableLayoutRTL) {
                            self.finalOffsetX = [self superviewWidth] - CGRectGetMinX(anotherView.frame);
                        }
                    }
                } else {
                    self.finalOffsetX = number.floatValue - self.finalWidth;
                    
                    if (self.view.nm_enableLayoutRTL) {
                        self.finalOffsetX = [self superviewWidth] - number.floatValue;
                        self.hasMinusWidth = YES;
                    }
                }
                self.hasOffsetX = YES;
                break;
            }
            case NMFrameTypeTop: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalOffsetY = 0;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalOffsetY = CGRectGetMinY(anotherView.frame);
                    }
                } else {
                    self.finalOffsetY = number.floatValue;
                }
                break;
            }
            case NMFrameTypeBottom: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalOffsetY = anotherView.nm_height - self.finalHeight;
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalOffsetY = CGRectGetMaxY(anotherView.frame) - self.finalHeight;
                    }
                } else {
                    self.finalOffsetY = number.floatValue - self.finalHeight;
                }
                break;
            }
            case NMFrameTypeCenter : {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalCenterX = CGRectGetMidX(anotherView.bounds);
                        self.finalCenterY = CGRectGetMidY(anotherView.bounds);
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalCenterX = anotherView.center.x;
                        self.finalCenterY = anotherView.center.y;
                    }
                } else {
                    CGPoint center = value.CGPointValue;
                    self.finalCenterX = center.x;
                    self.finalCenterY = center.y;
                }
                if (self.view.nm_enableLayoutRTL) {
                    self.finalCenterX = [self superviewWidth] - self.finalCenterX;
                }
                self.hasCenterX = YES;
                self.hasCenterY = YES;
                break;
            }
            case NMFrameTypeCenterX: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalCenterX = CGRectGetMidX(anotherView.bounds);
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalCenterX = CGRectGetMidX(anotherView.frame);
                    }
                } else {
                    self.finalCenterX = number.floatValue;
                }
                if (self.view.nm_enableLayoutRTL) {
                    self.finalCenterX = [self superviewWidth] - self.finalCenterX;
                }
                self.hasCenterX = YES;
                break;
            }
            case NMFrameTypeCenterY: {
                if (anotherView) {
                    if (IS_SUPERVIEW) {
                        self.finalCenterY = CGRectGetMidY(anotherView.bounds);
                    } else if (IS_THE_SAME_SUPERVIEW) {
                        self.finalCenterY = CGRectGetMidY(anotherView.frame);
                    }
                } else {
                    self.finalCenterY = number.floatValue;
                }
                self.hasCenterY = YES;
                break;
            }
            case NMFrameTypeWidth: {
                if (anotherView) {
                    self.finalWidth = anotherView.nm_width;
                } else {
                    self.finalWidth = number.floatValue;
                }
                break;
            }
            case NMFrameTypeHeight: {
                if (anotherView) {
                    self.finalHeight = anotherView.nm_height;
                } else {
                    self.finalHeight = number.floatValue;
                }
                break;
            }
            case NMFrameTypeSize: {
                if (anotherView) {
                    self.finalWidth = anotherView.nm_width;
                    self.finalHeight = anotherView.nm_height;
                } else {
                    CGSize size = value.CGSizeValue;
                    self.finalWidth = size.width;
                    self.finalHeight = size.height;
                }
                break;
            }
            case NMFrameTypeEdges: {
                if (anotherView) {
                    self.finalWidth = anotherView.nm_width;
                    self.finalHeight = anotherView.nm_height;
                }
                break;
            }
        }
        return self.makerMargin;
    };
}

- (NMFrameMakerMargin * (^)(id))nm_equalTo {
    return [self equalTo];
}

- (void)commit {
    
    if (self.view.nm_enableLayoutRTL) {
        if (self.hasOffsetX) {
            if (!self.hasMinusWidth) {
                self.finalOffsetX = self.finalOffsetX - self.finalWidth;
            }
        } else {
            self.finalOffsetX = [self superviewWidth] - self.finalWidth;
        }
    }
    
    CGFloat centerX = self.hasCenterX ? self.finalCenterX : (self.finalOffsetX + self.finalWidth / 2);
    CGFloat centerY = self.hasCenterY ? self.finalCenterY : (self.finalOffsetY + self.finalHeight / 2);
    self.view.bounds = CGRectMake(0, 0, self.finalWidth, self.finalHeight);
    self.view.center = CGPointMake(centerX, centerY);
}

#pragma mark - private methods

- (CGFloat)superviewWidth {
    return self.view.superview.nm_width;
}

#pragma mark - getter

- (NMFrameMakerMargin *)makerMargin {
    if (!_makerMargin) {
        __weak typeof(self) weakSelf = self;
        _makerMargin = [NMFrameMakerMargin marginWithHandler:^(CGFloat margin) {
            switch (weakSelf.currentType) {
                case NMFrameTypeNone:
                case NMFrameTypeCenter:
                case NMFrameTypeWidth:
                case NMFrameTypeHeight:
                case NMFrameTypeSize:
                case NMFrameTypeEdges: {
                    break;
                }
                case NMFrameTypeLeft: {
                    if (weakSelf.view.nm_enableLayoutRTL) {
                        weakSelf.finalOffsetX -= margin;
                    } else {
                        weakSelf.finalOffsetX += margin;
                    }
                    
                    break;
                }
                case NMFrameTypeRight: {
                    if (weakSelf.view.nm_enableLayoutRTL) {
                        weakSelf.finalOffsetX += margin;
                    } else {
                        weakSelf.finalOffsetX -= margin;
                    }
                    break;
                }
                case NMFrameTypeTop: {
                    weakSelf.finalOffsetY += margin;
                    break;
                }
                case NMFrameTypeBottom: {
                    weakSelf.finalOffsetY -= margin;
                    break;
                }
                case NMFrameTypeCenterX: {
                    weakSelf.finalCenterX += margin;
                    break;
                }
                case NMFrameTypeCenterY: {
                    weakSelf.finalCenterY += margin;
                    break;
                }
            }
        }];
    }
    return _makerMargin;
}

@end
