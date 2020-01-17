
//
//  TDAllNaviCouponItemsLayout.m
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "TDAllNaviCouponItemsLayout.h"
#define Width [UIScreen mainScreen].bounds.size.width
//我的优惠券界面
#define naviItemHeight 47

#define naviAllBtnW 60

#define naviAllItemsH 40 //按钮高度和上间距10

@interface TDAllNaviCouponItemsLayout()

@property(nonatomic,strong) NSMutableArray *attris;

@end

@implementation TDAllNaviCouponItemsLayout
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;

    for (int i = 0; i < [self.collectionView numberOfSections]; i++) {
        for (int j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *av = [self layoutAttributesForItemAtIndexPath:path];

            [self.attris addObject:av];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attris;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self layoutAttributesForCopyRightlayoutAttributes:layoutAttributes indexPath:indexPath];
    return layoutAttributes;
}

-(void)layoutAttributesForCopyRightlayoutAttributes:(UICollectionViewLayoutAttributes *)attributes indexPath: (NSIndexPath *)indexPath{

    //小模块宽度
    CGFloat width = (Width - 15*2 - 18*2)/3.0;
    //第几行
    NSInteger row = indexPath.item / 3;
    //第几列
    NSInteger col = indexPath.item % 3;
    
    attributes.frame = CGRectMake(15 + (width + 18) * col, naviAllItemsH * row ,width, naviAllItemsH);
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width * [self.collectionView numberOfSections], self.collectionView.frame.size.height);
}

#pragma mark - lazy load
- (NSMutableArray *)attris {
    if (!_attris) {
        _attris = [NSMutableArray array];
    }
    return _attris;
}



@end
