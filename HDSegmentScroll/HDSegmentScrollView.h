//
//  HDSegmentScrollView.h
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/23.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDScrollView.h"
#import "HDSegmentControl.h"

@class HDSegmentScrollView;

@protocol HDSegmentScrollViewDataSource <NSObject>

- (NSArray <NSString *>*)titlesForSegmentScrollView:(HDSegmentScrollView *)segmentScrollView;

- (UIView *)segmentScrollView:(HDSegmentScrollView *)segmentScrollView viewForIndex:(NSUInteger)index;

@end

@protocol HDSegmentScrollViewDelegate <NSObject>

@optional
- (void)segmentScrollView:(HDSegmentScrollView *)segmentScrollView didChange:(NSInteger)index;

@end

@interface HDSegmentScrollView : UIView
@property (nonatomic, assign) HDSegmentType mSegmentType;
@property (nonatomic, weak) id<HDSegmentScrollViewDelegate> mDelegate;
@property (nonatomic, weak) id<HDSegmentScrollViewDataSource> mDataSource;

@property (nonatomic, assign) NSInteger mSelectIndex;           //当前选中的位置

@property (nonatomic, strong) NSArray *mTitleWidths;            //每个item的宽度 HDSegmentType_Constant时管用
@property (nonatomic, assign) UIEdgeInsets mSegmentInset;       //Segment边距
@property (nonatomic, assign) CGFloat mLineMargin;              //下划线距离两边边距 mLineFixString为NO时管用
@property (nonatomic, assign) BOOL mLineFixString;              //下划线长度跟文字长度一样

@property (nonatomic, strong) DKColorPicker mLineColor;         //下划线的颜色
@property (nonatomic, strong) DKColorPicker mLinebgColor;       //下划线底部颜色，有的需求会要显示浅灰色底儿

@property (nonatomic, strong) DKColorPicker mNormalTextColor;   //文字默认颜色
@property (nonatomic, strong) DKColorPicker mSelectedTextColor; //当前选中item的文字颜色

@property (nonatomic, strong) DKColorPicker mNormalBgColor;     //默认背景颜色
@property (nonatomic, strong) DKColorPicker mSelectedBgColor;   //当前选中的item的背景颜色

- (void)setMSelectIndex:(NSInteger)mSelectIndex animated:(BOOL)animated;
@end
