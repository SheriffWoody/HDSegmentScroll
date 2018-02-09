//
//  segmentControlViewController.m
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/24.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import "SegmentControlViewController.h"
#import "HDSegmentControl.h"

@interface SegmentControlViewController ()
<
HDSegmentControlDataSource,
HDSegmentControlDelegate
>
@property (nonatomic, strong) HDSegmentControl *mSegmentControl1;
@property (nonatomic, strong) HDSegmentControl *mSegmentControl2;
@property (nonatomic, strong) HDSegmentControl *mSegmentControl3;
@property (nonatomic, strong) HDSegmentControl *mSegmentControl4;
@property (nonatomic, strong) HDSegmentControl *mSegmentControl5;
@end

@implementation SegmentControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mSegmentControl1];
    [self.view addSubview:self.mSegmentControl2];
    [self.view addSubview:self.mSegmentControl3];
    [self.view addSubview:self.mSegmentControl4];
    [self.view addSubview:self.mSegmentControl5];
    
    [self.mSegmentControl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@30);
        make.height.equalTo(@48);
    }];
    
    [self.mSegmentControl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mSegmentControl1.mas_bottom).offset(40);
        make.height.equalTo(@48);
    }];
    
    [self.mSegmentControl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mSegmentControl2.mas_bottom).offset(40);
        make.height.equalTo(@48);
    }];
    
    [self.mSegmentControl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.width.equalTo(@120);
        make.top.equalTo(self.mSegmentControl3.mas_bottom).offset(40);
        make.height.equalTo(@48);
    }];
    
    [self.mSegmentControl5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mSegmentControl4.mas_bottom).offset(40);
        make.height.equalTo(@48);
    }];
    // Do any additional setup after loading the view.
}

#pragma mark - Getter

- (HDSegmentControl *)mSegmentControl1{
    if (_mSegmentControl1 == nil) {
        _mSegmentControl1 = [[HDSegmentControl alloc]init];
        _mSegmentControl1.mDataSource = self;
        _mSegmentControl1.mDelegate = self;
        _mSegmentControl1.mSelectIndex = 0;
        _mSegmentControl1.mSegmentType = HDSegmentType_Constant;
        _mSegmentControl1.mLineFixString = YES;
    }
    return _mSegmentControl1;
}

- (HDSegmentControl *)mSegmentControl2{
    if (_mSegmentControl2 == nil) {
        _mSegmentControl2 = [[HDSegmentControl alloc]init];
        _mSegmentControl2.mDataSource = self;
        _mSegmentControl2.mDelegate = self;
        _mSegmentControl2.mSelectIndex = 0;
        _mSegmentControl2.mSegmentType = HDSegmentType_Variable;
        _mSegmentControl2.mLineFixString = NO;
    }
    return _mSegmentControl2;
}

- (HDSegmentControl *)mSegmentControl3{
    if (_mSegmentControl3 == nil) {
        _mSegmentControl3 = [[HDSegmentControl alloc]init];
        _mSegmentControl3.mDataSource = self;
        _mSegmentControl3.mDelegate = self;
        _mSegmentControl3.mSelectIndex = 0;
        _mSegmentControl3.mSegmentType = HDSegmentType_Variable_Center;
        _mSegmentControl3.mLineFixString = YES;
    }
    return _mSegmentControl3;
}

- (HDSegmentControl *)mSegmentControl4{
    if (_mSegmentControl4 == nil) {
        _mSegmentControl4 = [[HDSegmentControl alloc]init];
        _mSegmentControl4.mDataSource = self;
        _mSegmentControl4.mDelegate = self;
        _mSegmentControl4.mSelectIndex = 0;
        _mSegmentControl4.mSegmentType = HDSegmentType_Constant;
        _mSegmentControl4.mLineFixString = YES;
    }
    return _mSegmentControl4;
}

- (HDSegmentControl *)mSegmentControl5{
    if (_mSegmentControl5 == nil) {
        _mSegmentControl5 = [[HDSegmentControl alloc]init];
        _mSegmentControl5.mDataSource = self;
        _mSegmentControl5.mDelegate = self;
        _mSegmentControl5.mSelectIndex = 0;
        _mSegmentControl5.mSegmentType = HDSegmentType_Constant;
        _mSegmentControl5.mLineFixString = NO;
        _mSegmentControl5.mSegmentInset = UIEdgeInsetsMake(0,70, 0, 70);
        _mSegmentControl5.mLineMargin = 20;
    }
    return _mSegmentControl5;
}

#pragma mark - HDSegmentControlDataSource

- (NSArray <NSString *>*)titlesForSegment:(HDSegmentControl *)segment{
    if (segment == self.mSegmentControl1) {
        return @[@"微信",@"微博",@"短信",@"浏览器"];
    }else if(segment == self.mSegmentControl4){
        return @[@"微信",@"微博"];
    }else if(segment == self.mSegmentControl5){
        return @[@"微信",@"微博"];
    }else{
        return @[@"微信",@"微博",@"短信",@"浏览器",@"印象笔记",@"王者荣耀",@"朋友圈",@"QQ",@"虎牙直播",@"QQ控件"];
    }

}

#pragma mark - HDSegmentControlDelegate

- (void)clickSegment:(HDSegmentControl *)segment atIndex:(NSInteger)index{
    NSLog(@"选择%ld",index);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
