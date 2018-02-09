//
//  SecondViewController.h
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/23.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDSegmentScrollView.h"

@interface SegmentScrollViewController : UIViewController
@property (nonatomic, assign) HDSegmentType mSegmentType;
@property (nonatomic, assign) NSInteger index;
@end
