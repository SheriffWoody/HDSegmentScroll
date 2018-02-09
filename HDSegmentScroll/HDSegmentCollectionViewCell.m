//
//  HDSegmentCollectionViewCell.m
//  HD-BabyHealth
//
//  Created by hudi on 2017/10/20.
//  Copyright © 2017年 HD. All rights reserved.
//

#import "HDSegmentCollectionViewCell.h"
#import <Masonry.h>
#import <DKNightVersion.h>

@interface HDSegmentCollectionViewCell()

@end

@implementation HDSegmentCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.mLabel];
        [self.mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.dk_backgroundColorPicker = DKColorPickerWithKey(C2);
    }
    return self;
    
}

- (UILabel *)mLabel{
    if (_mLabel == nil) {
        _mLabel = [[UILabel alloc]init];
        _mLabel.dk_backgroundColorPicker = DKColorPickerWithKey(C2);
        _mLabel.textAlignment = NSTextAlignmentCenter;
        _mLabel.dk_textColorPicker = DKColorPickerWithKey(C8);
    }
    return _mLabel;
}

- (void)reloadCell:(NSString *)text{
    self.mLabel.text = text;
}
@end
