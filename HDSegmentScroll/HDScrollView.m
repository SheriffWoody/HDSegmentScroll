//
//  HDScrollView.m
//  HD-BabyHealth
//
//  Created by hudi on 2017/9/27.
//Copyright © 2017年 HD. All rights reserved.
//

#import "HDScrollView.h"
#import <Masonry.h>

@interface HDScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) NSMutableArray *mSubViews;
@property (nonatomic, assign) NSInteger mPageIndex;
@end

@implementation HDScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mScrollView];
        [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"================%@ dealloc===============",[self class]);
}

- (NSMutableArray *)mSubViews{
    if (_mSubViews == nil) {
        _mSubViews = [NSMutableArray array];
    }
    return _mSubViews;
}

- (UIScrollView *)mScrollView{
    if (_mScrollView == nil) {
        _mScrollView = [[UIScrollView alloc]init];
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        _mScrollView.pagingEnabled = YES;
        _mScrollView.scrollsToTop = NO;
        _mScrollView.delegate = self;
        _mScrollView.bounces = NO;
        UIView *contentView = [[UIView alloc]init];
        contentView.tag = 10;
        [_mScrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_mScrollView);
            make.height.equalTo(_mScrollView);
        }];
    }
    return _mScrollView;
}

- (void)reloadScrollView{
    for (UIView *view in self.mSubViews) {
        [view removeFromSuperview];
    }
    [self.mSubViews removeAllObjects];
    UIView *lastView;
    UIView *contentView = [self.mScrollView viewWithTag:10];
    for (NSInteger i = 0; i< [self.mDataSource numberOfViewInScrollView:self]; i++) {
        UIView *view = [self.mDataSource scrollView:self viewAtIndex:i];
        [self.mScrollView addSubview:view];
        [self.mSubViews addObject:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(lastView ? lastView.mas_right : @0);
            make.height.equalTo(contentView.mas_height);
            make.width.equalTo(self.mScrollView);
        }];
        lastView = view;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right);
    }];
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex{
    [self setMSelectIndex:mSelectIndex animated:YES];
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex animated:(BOOL)animated{
    _mSelectIndex = mSelectIndex;
    [self.mScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.mScrollView.frame) * mSelectIndex, 0) animated:animated];
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(scrollView:didChange:)]) {
        [self.mDelegate scrollView:self didChange:_mSelectIndex];
    }
    self.mPageIndex = mSelectIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    if (page != self.mPageIndex) {
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(scrollView:didChange:)]) {
            [self.mDelegate scrollView:self didChange:page];
        }
    }
    self.mPageIndex = page;
}

@end
