//
//  SecondViewController.m
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/23.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import "SegmentScrollViewController.h"
#import <Masonry.h>
@interface SegmentScrollViewController ()
<
HDSegmentScrollViewDataSource,
HDSegmentScrollViewDelegate
>
@property (nonatomic, strong) HDSegmentScrollView *mSegmentScrollView;
@property (nonatomic, strong) NSArray *mTitles;
@end

@implementation SegmentScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mSegmentScrollView];
    [self.mSegmentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //定位
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mSegmentScrollView setMSelectIndex:self.index animated:NO];
    });
    // Do any additional setup after loading the view.
}

#pragma mark - Getter

- (HDSegmentScrollView *)mSegmentScrollView{
    if (_mSegmentScrollView == nil) {
        _mSegmentScrollView = [[HDSegmentScrollView alloc]init];
        _mSegmentScrollView.mDataSource = self;
        _mSegmentScrollView.mDelegate = self;
    }
    return _mSegmentScrollView;
}

- (NSArray *)mTitles{
    if (self.mSegmentType == HDSegmentType_Constant) {
        return @[@"微信",@"微博",@"短信",@"浏览器"];
    }else{
        return @[@"微信",@"微博",@"短信",@"浏览器",@"印象笔记",@"王者荣耀",@"朋友圈",@"QQ",@"虎牙直播",@"QQ控件"];
    }
}

- (void)setMSegmentType:(HDSegmentType)mSegmentType{
    _mSegmentType = mSegmentType;
    self.mSegmentScrollView.mSegmentType = mSegmentType;
    
    if (mSegmentType == HDSegmentType_Constant) {
        self.mSegmentScrollView.mLineFixString = NO;
        self.mSegmentScrollView.mLineMargin = 20;
        DKColorPicker color = DKColorPickerWithColors([UIColor redColor],[UIColor orangeColor]);
        self.mSegmentScrollView.mSelectedTextColor = color;
        self.mSegmentScrollView.mLineColor = color;
    }
}

#pragma mark - Private Method

- (UIView *)customView:(NSString *)str{
    UIView *view = [[UIView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    return view;
}

#pragma mark - HDSegmentScrollViewDataSource
- (NSArray <NSString *>*)titlesForSegmentScrollView:(HDSegmentScrollView *)segmentScrollView{
    return self.mTitles;
}

- (UIView *)segmentScrollView:(HDSegmentScrollView *)segmentScrollView viewForIndex:(NSUInteger)index{
    NSString *str = [self.mTitles objectAtIndex:index];
    return [self customView:str];
}

- (void)segmentScrollView:(HDSegmentScrollView *)segmentScrollView didChange:(NSInteger)index{
    NSLog(@"滑动到%ld个界面 可以请求数据",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
