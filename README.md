# NMAutoLayout

## 一、框架介绍

NMAutoLayout是一个轻量级的自动布局框架，采用简洁优雅的链式语法对Frame布局进行了封装，语法结构类似Masonry，简洁明了并具有高可读性，使用NMAutoLayout能够用简单的语法进行高效的布局。

## 二、NMAutoLayout 常用属性与Masonry的对照表如下

| Masonry | NMAutoLayout | 说明 | 
|:--------------------:|:--------------------:|:---------------:|
| view.mas_left| view.nm_left| 左侧| 
| view.mas_top| view.nm_top| 上侧| 
| view.mas_right| view.nm_right| 右侧| 
| view.mas_bottom| view.nm_bottom| 下侧| 
| view.mas_width| view.nm_width| 宽| 
| view.mas_height| view.nm_height| 高| 
| view.mas_centerX| view.nm_centerX| 横向中点| 
| view.mas_centerY| view.nm_centerY| 纵向中点| 

## 三、使用NMAutoLayout进行Autolayout布局

```objc 
// **使用坐标绝对布局（NSNumber）**
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.left.equalTo(@(10.f));
    make.top.equalTo(@(20.f));
    make.width.equalTo(@(60.f));
    make.height.equalTo(@(20.f));
}];
// **使用参照物进行布局（父子或同级元素）（推荐） **
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.top.equalTo(self.headerImageView).margin(20.f);
    make.centerX.equalTo(self.headerImageView);
    make.width.equalTo(self);
    make.height.equalTo(self);
}];
// **使用基本数据类型布局 **
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.right.nm_equalTo(10);
    make.centerY.nm_equalTo(30.f);
    make.size.nm_equalTo(CGSizeMake(50.f, 30.f));
}];
```

NMAutoLayout 的相对布局是基于父子或同级元素，不能有跨层级的约束。可以通过nm_makeFrame关联View的left, right, top, bottom, centerX, centerY, width, height 进行布局。

### 1、使用UIView/NSView进行布局

```objc 
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.top.equalTo(self.view1).margin(10.f);
    make.left.equalTo(self.view1).margin(10.f);
    make.width.equalTo(self.view2);
    make.height.equalTo(self.view2);
}];
```
### 2、直接使用NSNumber进行布局
```objc 
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.left.equalTo(@(10.f));
    make.top.equalTo(@(20.f));
    make.width.equalTo(@(60.f));
    make.height.equalTo(@(20.f));
}];
```

### 3、直接使用CGFloat进行布局
```objc 
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.right.nm_equalTo(10.f);
    make.centerY.nm_equalTo(30.f);
    make.width.nm_equalTo(60.f);
    make.height.nm_equalTo(20.f);
}];
```
### 4、使用edges, size, center进行布局

make.edges 相当于同时设置NMFrameTypeTop，NMFrameTypeLeft， NMFrameTypeRight，NMFrameTypeBottom
make.size 相当于同时设置 NMFrameTypeWidth， NMFrameTypeHeight
make.center 相当于同时设置NMFrameTypeCenterX，NMFrameTypeCenterY 

```objc 
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    make.edges.equalTo(self);
    make.size.equalTo(self);
    make.center.equalTo(self);
}];
```
相当于
```objc 
[self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
    //edges
    make.left.equalTo(self);
    make.top.equalTo(self);
    make.width.equalTo(self);
    make.height.equalTo(self);
    //size
    make.width.equalTo(self);
    make.height.equalTo(self);
    //center
    make.centerX.equalTo(self);
    make.centerY.equalTo(self);
}];
```

## 四、NMAutoLayout 布局注意事项
- UILabel、UIImageView可以不用设置高度和宽度,内部设置了sizeToFit根据内容自适应大小。
- NMMakeFrameBlock内部处理了弱引用，外部调用不用考虑循环引用的问题。

## 五、NMAutoLayout 与 Masonry 比较

### 1、性能：
NMAutoLayout是基于Frame的封装，而Masonry是基于NSAutoLayout的封装，性能上NMAutoLayout相对Masonry是更优的。因为系统NSAutoLayout本身也是将约束条件计算后转化为视图的frame，再应用到视图上，虽然在iOS12以后NSAutoLayout算法改进后性能基本等同于frame布局，但仍存在一些问题。NSAutoLayout性能相关的讨论可参考类似的文章。

- [从 Auto Layout 的布局算法谈性能](https://draveness.me/layout-performance#)
- [iOS开发针对对Masonry下的FPS优化讨论](https://www.cnblogs.com/ludashi/p/7760471.html)

### 2、API易用性与可维护性：

Masonry的诞生原因就是iOS系统的NSAutoLayout的语法非常不优雅，对开发者不友好导致的，尽管做了抽象的封装但仍不能避免NSAutoLayout使用上的问题，例如：Masonry中设置约束有冲突会导致以下类似警告或者崩溃。

```objc 
2018-03-28 17:50:55.761481+0800 OMI[7256:2846471] [LayoutConstraints] Unable to simultaneously satisfy constraints.
Probably at least one of the constraints in the following list is one you don't want.
Try this:
(1) look at each constraint and try to figure out which you don't expect;
(2) find the code that added the unwanted constraint or constraints and fix it.
(
"<MASLayoutConstraint:0x1c80bc0e0 SettingsGenderSelectView:0x11be22d30.width == UITableViewCellContentView:0x11be229d0.width>",
"<MASLayoutConstraint:0x1c00adec0 SelectionIndicator:0x11bd160d0.left == OMISingleSelectionView:0x11bd15ed0.left + 20>",
"<MASLayoutConstraint:0x1c00ae220 UILabel:0x11bd16a70.left == OMISelectionIndicator:0x11bd160d0.right + 14>",
"<MASLayoutConstraint:0x1c00ae280 UILabel:0x11bd16a70.right == OMISingleSelectionView:0x11bd15ed0.right + 10>",
"<MASLayoutConstraint:0x1c00af540 SingleSelectionView:0x11bd15ed0.width == OMISettingsGenderSelectView:0x11be22d30.width>",
"<NSLayoutConstraint:0x1c8284d80 UITableViewCellContentView:0x11be229d0.width == 0>"
)
```
Masonry还有一些更新约束constraints的方法，例如mas_remakeConstraints、mas_updateConstraints都有特定的使用场景，以及通过install和uninstall方法来使用和删除该约束，这些API给普通开发者带来一定的负担。


### 3、API规范性：

很多使用Masonry的开发者习惯将UI初始化与Masonry的布局放到一起，这种是不符合iOS系统布局规范的。  例如下边这种代码：
```objc 
self.textLabel = [[UILabel alloc] init];
[self addSubview:self.textLabel];
[self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self);
    make.left.equalTo(self);
}];
```
而mas_remakeConstraints、mas_updateConstraints这种API设计又增加了代码的复杂度和布局的混乱，iOS系统优雅简洁的UI布局是要确保初始化加载与UI布局相分离的，使用NMAutoLayout可以这样设计，不用考虑Masonry中的remake、updateConstraints之类的繁琐问题。

```objc 
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = [UIColor blueColor];
    [self addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel nm_makeFrame:^(NMFrameMaker *make) {
        make.left.equalTo(self).margin(10.f);
        make.top.equalTo(self).margin(10.f);
    }];
}
```

## 六、结语

NMAutoLayout框架是虎牙海外项目组Nimo团队自研的自动布局框架，设计思想借鉴了Masonry的链式语法结构，底层原理基于Frame，在性能和API友好易用性上超越了Masonry，当前NMAutoLayout框架可以完全满足基本的UI布局需要，后续还会扩展更多的API以满足个性化的需要。

## 七、快速使用

- Pod或直接把NMAutoLayout文件拖入项目
```objc 
pod 'NMAutoLayout', '~>1.0.1'
```
- 导入头文件
```objc
#import "NMAutoLayout.h"
```
