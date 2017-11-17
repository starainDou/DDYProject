//
//  TestVC.m
//  DDYProject
//
//  Created by LingTuan on 17/10/31.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView {
    
    self.view.backgroundColor = DDY_LightGray;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, 200)];
    view.backgroundColor = DDY_Blue;
    [self.view addSubview:view];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DDYSCREENW, 80)];
    headView.backgroundColor = DDY_ClearColor;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, DDYSCREENW, DDYSCREENH - 90)];
    _tableView.backgroundColor = DDY_ClearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
//    _tableView.tableHeaderView = headView;
    [self.view addSubview:_tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewOrders)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - UITableViewDataSource
#pragma mark NumberOfSections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark NumberOfRows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

#pragma mark CellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellID];
    }
    
    cell.textLabel.text = @"白日依山尽,黄河入海流。欲穷千里目,更上一层楼。";
    
    return cell;
}

- (void)loadNewOrders {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
