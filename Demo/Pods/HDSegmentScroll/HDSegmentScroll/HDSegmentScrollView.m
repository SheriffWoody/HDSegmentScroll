//
//  HDSegmentScrollView.m
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/23.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import "HDSegmentScrollView.h"
#import "Masonry.h"
#import "DKNightVersion.h"

@interface HDSegmentScrollView()
<
HDScrollViewDelegate,
HDScrollViewDataSource,
HDSegmentControlDataSource,
HDSegmentControlDelegate
>
@property (nonatomic, strong) HDScrollView *mScrollView;
@property (nonatomic, strong) HDSegmentControl *mSegmentControl;
@end

@implementation HDSegmentScrollView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mSegmentControl];
        [self addSubview:self.mScrollView];
        
        [self.mSegmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@48);
        }];
        
        [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.mSegmentControl.mas_bottom);
        }];
    }
    return self;
}

#pragma mark - Setter

- (void)setMSegmentType:(HDSegmentType)mSegmentType{
    _mSegmentType = mSegmentType;
    self.mSegmentControl.mSegmentType = _mSegmentType;
}

- (void)setMTitleWidths:(NSArray *)mTitleWidths{
    _mTitleWidths = mTitleWidths;
    self.mSegmentControl.mTitleWidths = mTitleWidths;
}

- (void)setMSegmentInset:(UIEdgeInsets)mSegmentInset{
    _mSegmentInset = mSegmentInset;
    self.mSegmentControl.mSegmentInset = mSegmentInset;
}

- (void)setMLineMargin:(CGFloat)mLineMargin{
    _mLineMargin = mLineMargin;
    self.mSegmentControl.mLineMargin = mLineMargin;
}

- (void)setMLineFixString:(BOOL)mLineFixString{
    _mLineFixString = mLineFixString;
    self.mSegmentControl.mLineFixString = mLineFixString;
}

- (void)setMLineColor:(DKColorPicker)mLineColor{
    _mLineColor = mLineColor;
    self.mSegmentControl.mLineColor = mLineColor;
}

- (void)setMLinebgColor:(DKColorPicker)mLinebgColor{
    _mLinebgColor = mLinebgColor;
    self.mSegmentControl.mLinebgColor = mLinebgColor;
}

- (void)setMNormalTextColor:(DKColorPicker)mNormalTextColor{
    _mNormalTextColor = mNormalTextColor;
    self.mSegmentControl.mNormalTextColor = mNormalTextColor;
}

- (void)setMSelectedTextColor:(DKColorPicker)mSelectedTextColor{
    _mSelectedTextColor = mSelectedTextColor;
    self.mSegmentControl.mSelectedTextColor = mSelectedTextColor;
}

- (void)setMNormalBgColor:(DKColorPicker)mNormalBgColor{
    _mNormalBgColor = mNormalBgColor;
    self.mSegmentControl.mNormalBgColor = mNormalBgColor;
}

- (void)setMSelectedBgColor:(DKColorPicker)mSelectedBgColor{
    _mSelectedBgColor = mSelectedBgColor;
    self.mSegmentControl.mSelectedBgColor = mSelectedBgColor;
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex{
    _mSelectIndex = mSelectIndex;
    [self setMSelectIndex:mSelectIndex animated:YES];
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex animated:(BOOL)animated{
    _mSelectIndex = mSelectIndex;
    [self.mScrollView setMSelectIndex:_mSelectIndex animated:animated];
}

#pragma mark - Getter

- (HDSegmentControl *)mSegmentControl{
    if (_mSegmentControl == nil) {
        _mSegmentControl = [[HDSegmentControl alloc]init];
        _mSegmentControl.mDataSource = self;
        _mSegmentControl.mDelegate = self;
        _mSegmentControl.mSelectIndex = 0;
        _mSegmentControl.mSegmentType = HDSegmentType_Variable_Center;
        _mSegmentControl.mLineFixString = YES;
    }
    return _mSegmentControl;
}

- (HDScrollView *)mScrollView{
    if (_mScrollView == nil) {
        _mScrollView = [[HDScrollView alloc]init];
        _mScrollView.mDataSource = self;
        _mScrollView.mDelegate = self;
    }
    return _mScrollView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self.mScrollView reloadScrollView];
    }
}

- (void)dealloc{
    NSLog(@"================%@ dealloc===============",[self class]);
}

#pragma mark - HDScrollViewDataSource

- (NSInteger)numberOfViewInScrollView:(HDScrollView *)scrollView{
    return [self.mDataSource titlesForSegmentScrollView:self].count;
}

- (UIView *)scrollView:(HDScrollView *)scrollView viewAtIndex:(NSInteger)index{
    return [self.mDataSource segmentScrollView:self viewForIndex:index];
}

- (void)scrollView:(HDScrollView *)scrollView didChange:(NSInteger)index{
    self.mSegmentControl.mSelectIndex = index;
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(segmentScrollView:didChange:)]) {
        [self.mDelegate segmentScrollView:self didChange:index];
    }
}

#pragma mark - HDSegmentControlDataSource

- (NSArray <NSString *>*)titlesForSegment:(HDSegmentControl *)segment{
    return [self.mDataSource titlesForSegmentScrollView:self];
}

#pragma mark - HDSegmentControlDelegate

- (void)clickSegment:(HDSegmentControl *)segment atIndex:(NSInteger)index{
    self.mScrollView.mSelectIndex = index;
}

@end
