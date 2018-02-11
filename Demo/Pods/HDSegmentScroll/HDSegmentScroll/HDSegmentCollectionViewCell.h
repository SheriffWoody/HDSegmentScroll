//
//  HDSegmentCollectionViewCell.h
//  HD-BabyHealth
//
//  Created by hudi on 2017/10/20.
//  Copyright © 2017年 HD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDSegmentCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *mLabel;

- (void)reloadCell:(NSString *)text;

@end
