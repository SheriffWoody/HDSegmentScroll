//
//  HDSegmentControl.m
//  HD-BabyHealth
//
//  Created by hudi on 2017/10/20.
//  Copyright © 2017年 HD. All rights reserved.
//

#import "HDSegmentControl.h"
#import "HDSegmentCollectionViewCell.h"

@interface HDSegmentControl()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>

@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) UIView *mLine;
@property (nonatomic, strong) UIView *mLineBg;

@end

@implementation HDSegmentControl

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.mSegmentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.mFont = [UIFont systemFontOfSize:16];
        self.mLineMargin = 0;
        [self addSubview:self.mCollectionView];
        [self.mCollectionView addSubview:self.mLineBg];
        [self.mCollectionView addSubview:self.mLine];
        [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        self.mSegmentType = HDSegmentType_Constant;
        self.mNormalTextColor = DKColorPickerWithKey(C4);
        self.mSelectedTextColor = DKColorPickerWithKey(C8);
        self.mSelectedBgColor = DKColorPickerWithKey(C2);
    }
    return self;
}

- (void)dealloc{
    [self.mCollectionView removeObserver:self forKeyPath:@"contentSize"];
    NSLog(@"================%@ dealloc===============",[self class]);
}

- (UICollectionView *)mCollectionView{
    if (_mCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        _mCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
        _mCollectionView.alwaysBounceVertical = NO;
        _mCollectionView.showsHorizontalScrollIndicator = NO;
        _mCollectionView.dk_backgroundColorPicker = DKColorPickerWithKey(C2);
        [_mCollectionView registerClass:[HDSegmentCollectionViewCell class] forCellWithReuseIdentifier:@"HDSegmentCollectionViewCell"];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([_mCollectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                [_mCollectionView performSelector:@selector(setContentInsetAdjustmentBehavior:) withObject:@(UIScrollViewContentInsetAdjustmentNever)];
            } else {
            }
        }
#pragma clang diagnostic pop
        
        [_mCollectionView addSubview:self.mLineBg];
        [_mCollectionView addSubview:self.mLine];
        
        [_mCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _mCollectionView;
}

- (UIView *)mLine{
    if (_mLine == nil) {
        _mLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.mLineBg.frame.origin.y, 100, 2)];
        _mLine.dk_backgroundColorPicker = DKColorPickerWithKey(C8);
    }
    return _mLine;
}

- (UIView *)mLineBg{
    if (_mLineBg == nil) {
        _mLineBg = [[UIView alloc]init];
    }
    return _mLineBg;
}

- (void)setMLineColor:(DKColorPicker)mLineColor{
    _mLineColor = mLineColor;
    self.mLine.dk_backgroundColorPicker = mLineColor;
}

- (void)setMLinebgColor:(DKColorPicker)mLinebgColor{
    _mLinebgColor = mLinebgColor;
    self.mLineBg.dk_backgroundColorPicker = mLinebgColor;
}

- (void)setMSelectIndex:(NSInteger)mSelectIndex{
    _mSelectIndex = mSelectIndex;
    [self.mCollectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_mSelectIndex inSection:0];
        [self updateLinePosition:indexPath];
    });
   
}

- (NSArray *)mTitleWidths{
    if (_mTitleWidths == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *titles = [self.mDataSource titlesForSegment:self];
        if (titles.count > 0) {
            NSString *string = [titles componentsJoinedByString:@""];
            CGFloat width = CGRectGetWidth(self.frame) - self.mSegmentInset.left - self.mSegmentInset.right;
            CGFloat stringWidth = [self getSizeoffont:self.mFont withMaxWidth:MAXFLOAT ofString:string].width;
            CGFloat per = (width - stringWidth)/titles.count;
            for (NSInteger i = 0;i<titles.count;i++) {
                NSString *str = [titles objectAtIndex:i];
                CGFloat tempwidth = [self getSizeoffont:self.mFont withMaxWidth:MAXFLOAT ofString:str].width + per;
                [arr addObject:@(tempwidth)];
            }
            _mTitleWidths = [NSArray arrayWithArray:arr];
        }
    }
    return _mTitleWidths;
}

- (void)setMSegmentType:(HDSegmentType)mSegmentType{
    _mSegmentType = mSegmentType;
    if (_mSegmentType == HDSegmentType_Constant) {
        self.mCollectionView.scrollEnabled = NO;
    }else{
        self.mCollectionView.scrollEnabled = YES;
    }
    
    if (self.mSegmentType == HDSegmentType_Variable_Center) {
        self.mNormalBgColor = DKColorPickerWithKey(C1);
        self.mCollectionView.dk_backgroundColorPicker = DKColorPickerWithKey(C1);

       }else{
       self.mNormalBgColor = DKColorPickerWithKey(C2);
       self.mCollectionView.dk_backgroundColorPicker = DKColorPickerWithKey(C2);
    }
}

#pragma mark - OtherDelegate
- (void)scrollEndAnimate:(UIScrollView *)scrollView{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.mSelectIndex inSection:0];
    UICollectionViewCell *cell = [self collectionView:self.mCollectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = cell.frame;
    CGRect scrollRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.frame.size.width, scrollView.frame.size.height);
    CGPoint cellStart = rect.origin;
    CGPoint cellEnd = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    if (CGRectContainsPoint(scrollRect, cellStart) || CGRectContainsPoint(scrollRect, cellEnd)) {
        self.mSelectIndex = self.mSelectIndex;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollEndAnimate:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self scrollEndAnimate:scrollView];
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CGFloat count = [self.mDataSource titlesForSegment:self].count;
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"HDSegmentCollectionViewCell";
    NSArray *titles = [self.mDataSource titlesForSegment:self];
    NSString *str = [titles objectAtIndex:indexPath.item];
    HDSegmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.mLabel.font = self.mFont;
    if (indexPath.item == self.mSelectIndex) {
        cell.mLabel.dk_backgroundColorPicker = self.mSelectedBgColor;
        cell.mLabel.dk_textColorPicker  = self.mSelectedTextColor;
    }else{
        cell.mLabel.dk_backgroundColorPicker = self.mNormalBgColor;
        cell.mLabel.dk_textColorPicker = self.mNormalTextColor;
    }
    [cell reloadCell:str];
    return cell;
}

//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titles = [self.mDataSource titlesForSegment:self];
    NSString *str = [titles objectAtIndex:indexPath.item];
    CGSize size= [self getSizeoffont:self.mFont withMaxWidth:collectionView.frame.size.width ofString:str];
    if (self.mSegmentType == HDSegmentType_Constant) {
        CGFloat width = [[self.mTitleWidths objectAtIndex:indexPath.item] floatValue];
        return CGSizeMake(width, CGRectGetHeight(self.frame));
    }else{
        return CGSizeMake(size.width + 30, CGRectGetHeight(self.frame));
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.mSegmentInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mSelectIndex != indexPath.item) {
        self.mSelectIndex = indexPath.item;
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(clickSegment:atIndex:)]) {
            [self.mDelegate clickSegment:self atIndex:self.mSelectIndex];
        }
    }
}

- (void)updateLinePosition:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self collectionView:self.mCollectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = cell.frame;
    CGFloat x = rect.origin.x;
    CGFloat w = rect.size.width;
    if (self.mLineFixString) {
        NSArray *titles = [self.mDataSource titlesForSegment:self];
        NSString *str = [titles objectAtIndex:indexPath.item];
        CGSize size= [self getSizeoffont:self.mFont withMaxWidth:self.mCollectionView.frame.size.width ofString:str];
        w = size.width;
        x = rect.origin.x + (rect.size.width - w)/2.f;
    }else{
        x = x + self.mLineMargin;
        w = w - 2* self.mLineMargin;
    }
    self.mLine.frame = CGRectMake(x, self.mLineBg.frame.origin.y, w, 2);
    
    
    if (self.mSegmentType != HDSegmentType_Constant) {
        CGRect cellInViewRect = [self.mCollectionView convertRect:rect toView:self];
        CGFloat centerX = cellInViewRect.origin.x + cellInViewRect.size.width/2.f;
        CGFloat selfWidth = CGRectGetWidth(self.frame);
        CGFloat selfCenterX = selfWidth/2.f;
        CGFloat span =  centerX - selfCenterX;
        CGFloat contentOffX = self.mCollectionView.contentOffset.x;
        CGFloat finallX = contentOffX + span;
        if (self.mSegmentType == HDSegmentType_Variable_Center) {
            [self.mCollectionView setContentOffset:CGPointMake(finallX, 0) animated:YES];
        }else if (self.mSegmentType == HDSegmentType_Variable){
            if (span < 0) {  //往后退
                if (finallX > 0) {
                    [self.mCollectionView setContentOffset:CGPointMake(finallX, 0) animated:YES];
                }else{
                    [self.mCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }else{  //往前进
                CGFloat maxX = self.mCollectionView.contentSize.width - selfWidth;
                if (finallX < maxX) {
                    [self.mCollectionView setContentOffset:CGPointMake(finallX, 0) animated:YES];
                }else{
                    [self.mCollectionView setContentOffset:CGPointMake(maxX, 0) animated:YES];
                }
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.mCollectionView) {
        self.mLineBg.frame = CGRectMake(0, CGRectGetHeight(self.mCollectionView.frame) - 2, self.mCollectionView.contentSize.width, 2);
    }
}

-(CGSize)getSizeoffont:(UIFont *)font withMaxWidth:(double)maxWidth ofString:(NSString *)str{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size= [str  boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

@end
