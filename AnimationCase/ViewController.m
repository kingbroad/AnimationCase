//
//  ViewController.m
//  AnimationCase
//
//  Created by TakumiShen on 17/5/19.
//  Copyright © 2017年 Jinzhiqiang. All rights reserved.
//

#import "ViewController.h"
#import "RadarViewController.h"
#import "DingDingViewController.h"
#import "ThumbUpViewController.h"
#import "JellyViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *JCContactTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArr = [NSMutableArray arrayWithArray:@[@"雷达动画",@"仿叮叮动画",@"点赞动画",@"果冻效果"]];
    [self initTableView];
}
//初始化表
-(void)initTableView
{
    self.JCContactTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.JCContactTableView.tableFooterView = [[UIView alloc]init];
    self.JCContactTableView.delegate = self;
    self.JCContactTableView.dataSource = self;
    [self.view addSubview:self.JCContactTableView];
}

#pragma mark ----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
#pragma mark --UITableViewDelegate
//点击行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            RadarViewController *vc = [[RadarViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        case 1:
        {
            DingDingViewController *vc = [[DingDingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            ThumbUpViewController *vc = [[ThumbUpViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            JellyViewController *vc = [[JellyViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
    
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.transform = CATransform3DMakeScale(0.1, 1, 1);
    [UIView animateWithDuration:3 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}






@end
