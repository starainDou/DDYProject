//
//  DDYWaterFallVC.m
//  DDYProject
//
//  Created by LingTuan on 17/9/13.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYWaterFallVC.h"
#import "DDYWaterFallCell.h"
#import "DDYWaterFallHeader.h"
#import "DDYWaterfallLayout.h"

static NSString *cellID = @"DDYWaterFallCellID";
static NSString *headID = @"DDYWaterFallHeadID";
static NSString *FootID = @"DDYWaterFallFootID";

@interface DDYWaterFallVC ()<UICollectionViewDataSource, UICollectionViewDelegate, DDYWaterFallLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DDYWaterFallVC

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self loadData];
}

- (void)setupCollectionView
{
    DDYWaterfallLayout *layout = [[DDYWaterfallLayout alloc] init];
    layout.itemRenderDirection = DDYWaterfallDirectionShortestFirst;
    layout.headerHeight = 44;
//    layout.columnCount = 3;
//    layout.minimumColumnSpacing = 10;
//    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:DDYRect(0, 64, DDYSCREENW, DDYSCREENH-64) collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = DDYBackColor;
    
    [_collectionView registerClass:[DDYWaterFallCell class] forCellWithReuseIdentifier:cellID];
    [_collectionView registerClass:[DDYWaterFallHeader class] forSupplementaryViewOfKind:DDYCollectionSectionHeader withReuseIdentifier:headID];
    [self.view addSubview:_collectionView];
    
//    [_collectionView performBatchUpdates:^{
//        // 更新collection的约束一定要写在reload完成之前,否则会导致crash
//    } completion:^(BOOL finished) {
//        // 注意防止循环调用该方法
//        CGFloat h = _collectionView.collectionViewLayout.collectionViewContentSize.height;
//        // 不能超过某个临界值，这里不能超过屏幕高度
//        _collectionView.ddy_h = h > DDYSCREENH ? DDYSCREENH : h;
//    }];
}

#pragma mark - UICollectionViewDataSource Delegate
#pragma mark 组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
#pragma mark 每组item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *itemArray = self.dataArray[section];
    return itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDYWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSArray *itemArray = self.dataArray[indexPath.section];
    [cell loadTitle:DDYStrFormat(@"%ld-%ld-%@", indexPath.section, indexPath.row, itemArray[indexPath.row])];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    DDYWaterFallHeader *reusableView = nil;
    if ([kind isEqualToString:DDYCollectionSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headID forIndexPath:indexPath];
        reusableView.title = DDYStrFormat(@"%ld",indexPath.section);
    }
    return reusableView;
}

#pragma mark - DDYCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArray = self.dataArray[indexPath.section];
    NSString *heightStr = DDYStrFormat(@"%@",itemArray[indexPath.row]);
    return CGSizeMake([heightStr floatValue], [heightStr floatValue]);
}

- (void)loadData {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<50; i++) {
        // arc4random_uniform(50)
        [arr addObject:@((arc4random()%6)*10+50)];
    }
    [self.dataArray  addObject:arr];
    [self.dataArray  addObject:arr];
    [self.dataArray  addObject:arr];
    [self.collectionView reloadData];
}

@end
