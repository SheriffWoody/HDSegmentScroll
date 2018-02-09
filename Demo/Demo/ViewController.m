//
//  ViewController.m
//  HDSegmentDemo
//
//  Created by hudi on 2017/10/23.
//  Copyright © 2017年 hudi. All rights reserved.
//

#import "ViewController.h"
#import "SegmentScrollViewController.h"
#import "SegmentControlViewController.h"
@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSArray *mDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mDataSource = @[@"HDSegmentType_Constant",@"HDSegmentType_Variable",@"HDSegmentType_Variable_Center"];
    UITableView *tb = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tb.delegate = self;
    tb.dataSource = self;
    [self.view addSubview:tb];
    [tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.mDataSource.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"scrollCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.mDataSource objectAtIndex:indexPath.row];
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"SegmentConrol";
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SegmentScrollViewController *vc = [[SegmentScrollViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.mSegmentType = indexPath.row;
        vc.index = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        SegmentControlViewController *vc = [[SegmentControlViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"HDSegmentScrollView";
    }else if (section == 1) {
        return @"HDSegmentControl";
    }
    return @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
