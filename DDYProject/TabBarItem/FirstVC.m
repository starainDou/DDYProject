//
//  FirstVC.m
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "FirstVC.h"
#import "BtnTestVC.h"
#import "RuntimeVC.h"
#import "TableViewInScrollViewVC.h"
#import "TextViewTestVC.h"
#import "DDYQRCodeVC.h"
#import "FilterTestVC.h"
#import "DDYCameraVC.h"
#import "DDYWaterFallVC.h"
#import "DDYWaveVC.h"

@interface FirstVC ()<UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FirstVC

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepare];
    [self setupTableView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ [self loadData]; });
}

- (void)prepare
{
    // 64当起点布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, DDYSCREENH - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
        // 3DTouch Peek 预览 遵循UIViewControllerPreviewingDelegate
        if (IOS_9_LATER && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            DDYInfoLog(@"3DTouch可用,给cell注册peek(预览)和pop功能");
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = DDYFont(14);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [NSClassFromString(self.dataArray[indexPath.row]) vc];
    [self.navigationController pushViewController:vc.hideBar(YES) animated:YES];
}

#pragma mark Peek预览
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    // 获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    // 设定预览的界面
    BtnTestVC *childVC = [[BtnTestVC alloc] init];
    childVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
    // 调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect rect = CGRectMake(0, 0, DDYSCREENW,40);
    previewingContext.sourceRect = rect;
    // 返回预览界面
    return childVC;
}

#pragma mark Pop用力按则进入
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

- (void)loadData
{
    [self.dataArray addObject:@"BtnTestVC"];
    [self.dataArray addObject:@"RuntimeVC"];
    [self.dataArray addObject:@"TableViewInScrollViewVC"];
    [self.dataArray addObject:@"TextViewTestVC"];
    [self.dataArray addObject:@"DDYQRCodeVC"];
    [self.dataArray addObject:@"FilterTestVC"];
    [self.dataArray addObject:@"DDYCameraVC"];
    [self.dataArray addObject:@"DDYWaterFallVC"];
    [self.dataArray addObject:@"DDYWaveVC"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - 控制旋转屏幕
#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}


@end
