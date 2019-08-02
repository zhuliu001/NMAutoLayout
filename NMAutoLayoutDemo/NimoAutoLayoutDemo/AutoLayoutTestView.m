//
//  AutoLayoutTestView.m
//  NimoAutoLayoutDemo
//
//  Created by nimo on 2019/7/31.
//  Copyright © 2019 nimo. All rights reserved.
//

#import "AutoLayoutTestView.h"
#import "NMAutoLayout.h"


static CGFloat const kTipDotViewWidth   = 10.f;
static CGFloat const kSubviewMargin     = 10.f;


@interface AutoLayoutTestView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation AutoLayoutTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews {
    _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    _bgView.layer.cornerRadius = 3.0f;
    _bgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bgView];

    _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    _headerImageView.backgroundColor = [UIColor clearColor];
    [_bgView addSubview:_headerImageView];
    
    _dotView = [[UIView alloc] initWithFrame:CGRectZero];
    _dotView.backgroundColor = [UIColor redColor];
    _dotView.layer.cornerRadius = kTipDotViewWidth / 2;
    [_bgView addSubview:_dotView];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor blueColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    [_bgView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.textColor = [UIColor greenColor];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.numberOfLines = 0;
    [_bgView addSubview:_contentLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView nm_makeFrame:^(NMFrameMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.headerImageView nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.bgView).margin(kSubviewMargin);
        make.centerY.equalTo(self.bgView);
    }];
    [self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.headerImageView.nm_right).margin(kSubviewMargin);
        make.top.equalTo(self.bgView).margin(20);
    }];
    [self.contentLabel nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.headerImageView.nm_right).margin(kSubviewMargin);
        make.top.equalTo(self.titleLabel.nm_bottom).margin(kSubviewMargin);
        make.width.equalTo(@(self.bgView.nm_width - self.headerImageView.nm_right.floatValue - kSubviewMargin));
        make.height.equalTo(@(40));
    }];
    [self.dotView nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self.titleLabel.nm_right).margin(kSubviewMargin);
        make.top.equalTo(self.titleLabel);
        make.size.nm_equalTo(CGSizeMake(kTipDotViewWidth, kTipDotViewWidth));
    }];
}



- (void)setTipTitle:(NSString *)title content:(NSString *)content {
    self.titleLabel.text = title;
    self.contentLabel.text = content;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
