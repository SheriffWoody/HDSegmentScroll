//
//  HDSegmentControl.h
//  HD-BabyHealth
//
//  Created by hudi on 2017/10/20.
//  Copyright © 2017年 HD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKNightVersion.h"

typedef NS_ENUM(NSUInteger, HDSegmentType) {
    HDSegmentType_Constant = 0, // 一屏均分
    HDSegmentType_Variable, // 可滚动的
    HDSegmentType_Variable_Center, // 可滚动的 选项在中间的
};

@class HDSegmentControl;

@protocol HDSegmentControlDataSource <NSObject>

- (NSArray <NSString *>*)titlesForSegment:(HDSegmentControl *)segment;

@end

@protocol HDSegmentControlDelegate <NSObject>

- (void)clickSegment:(HDSegmentControl *)segment atIndex:(NSInteger)index;

@end

@interface HDSegmentControl : UIView

@property (nonatomic, assign) HDSegmentType mSegmentType;
@property (nonatomic, weak) id<HDSegmentControlDataSource> mDataSource;
@property (nonatomic, weak) id<HDSegmentControlDelegate> mDelegate;

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

@property (nonatomic, strong) UIFont *mFont;
@end
