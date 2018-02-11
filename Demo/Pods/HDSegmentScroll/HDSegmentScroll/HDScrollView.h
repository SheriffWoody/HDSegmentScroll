//
//  HDScrollView.h
//  HD-BabyHealth
//
//  Created by hudi on 2017/9/27.
//Copyright © 2017年 HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDScrollView;

@protocol HDScrollViewDataSource <NSObject>

- (NSInteger)numberOfViewInScrollView:(HDScrollView *)scrollView;
- (UIView *)scrollView:(HDScrollView *)scrollView viewAtIndex:(NSInteger)index;

@end

@protocol HDScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(HDScrollView *)scrollView didChange:(NSInteger)index;

@end

@interface HDScrollView : UIView
@property (nonatomic, weak) id <HDScrollViewDelegate> mDelegate;
@property (nonatomic, weak) id <HDScrollViewDataSource> mDataSource;
@property (nonatomic, assign) NSInteger mSelectIndex;

- (void)setMSelectIndex:(NSInteger)mSelectIndex animated:(BOOL)animated;

- (void)reloadScrollView;
@end
