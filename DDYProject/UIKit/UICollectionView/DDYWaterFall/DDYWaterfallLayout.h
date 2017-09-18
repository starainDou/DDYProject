
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, DDYWaterfallDirection) {
  DDYWaterfallDirectionShortestFirst,
  DDYWaterfallDirectionLeftToRight,
  DDYWaterfallDirectionRightToLeft
};

extern NSString *const DDYCollectionSectionHeader;
extern NSString *const DDYCollectionSectionFooter;

#pragma mark - DDYWaterFallLayoutDelegate

@class DDYWaterfallLayout;

@protocol DDYWaterFallLayoutDelegate <UICollectionViewDelegate>
@required

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForHeaderInSection:(NSInteger)section;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForFooterInSection:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumColumnSpacingForSectionAtIndex:(NSInteger)section;

@end

#pragma mark - DDYWaterfallLayout

@interface DDYWaterfallLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, assign) CGFloat minimumColumnSpacing;

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, assign) UIEdgeInsets headerInset;

@property (nonatomic, assign) UIEdgeInsets footerInset;

@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) DDYWaterfallDirection itemRenderDirection;

@property (nonatomic, assign) CGFloat minimumContentHeight;

- (CGFloat)itemWidthInSectionAtIndex:(NSInteger)section;

@end
