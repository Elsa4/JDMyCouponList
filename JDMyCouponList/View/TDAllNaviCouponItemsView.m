//
//  TDAllNaviCouponItemsView.m
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "TDAllNaviCouponItemsView.h"
#import "TDCouponNaviCollectionCell.h"
#import "TDAllNaviCouponItemsLayout.h"
#import "TDMyCouponChannelListModel.h"

#define Width [UIScreen mainScreen].bounds.size.width
//我的优惠券界面
#define naviItemHeight 47

#define naviAllBtnW 60

#define naviAllItemsH 40 //按钮高度和上间距10

@interface TDAllNaviCouponItemsView()<UICollectionViewDelegate, UICollectionViewDataSource>{
    NSInteger isSelecIndex;
    UIView *bgView;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TDAllNaviCouponItemsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
    
    }
    return self;
}

-(void)reloadCollectionData{
    [self initUI];
    [self.collectionView reloadData];
}

-(void)initUI {
   
  
    NSInteger rows = 0;
    if (_titleAry.count % 3 == 0) {
        rows = _titleAry.count/3;
    }else{
        rows = _titleAry.count/3 + 1;
    }
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width,rows*naviAllItemsH + 10)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self setCornerWithbyRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerWithRadius:20 width:Width];
    [self addSubview:bgView];
    
    TDAllNaviCouponItemsLayout *layout = [[TDAllNaviCouponItemsLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width,rows*naviAllItemsH) collectionViewLayout:layout];
    [bgView addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    UITapGestureRecognizer *emptyTap = [[UITapGestureRecognizer alloc] init];
    emptyTap.cancelsTouchesInView = NO;
    [bgView addGestureRecognizer:emptyTap];
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TDCouponNaviCollectionCell class]) bundle:nil]forCellWithReuseIdentifier:@"TDCouponNaviCollectionCell"];
          [[NSNotificationCenter defaultCenter] addObserver:self
                                                   selector:@selector(scrollToItem:)
                                                       name:@"MYCouponAllItemNSNotification"
                                                     object:nil];
    isSelecIndex = _currentIndex;

}

-(void)scrollToItem:(NSNotification *)info{
    NSDictionary *dic = info.userInfo;
    NSInteger item = [dic[@"index"] integerValue];
    
    TDMyCouponChannelListModel *deSelectModel = _titleAry[isSelecIndex];
     deSelectModel.isSelect = NO;
    _titleAry[isSelecIndex] = deSelectModel;
    
    TDMyCouponChannelListModel *selectModel = _titleAry[item];
    selectModel.isSelect = YES;
    _titleAry[item] = selectModel;
    [_collectionView reloadData];
    isSelecIndex = item;
}

-(void)tap:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TDCouponNaviCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TDCouponNaviCollectionCell" forIndexPath:indexPath];
    TDMyCouponChannelListModel *model = _titleAry[indexPath.item];
       cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)", model.channelname, model.total];
       if (model.isSelect) {
           [self setUIWithTextCorlor:[UIColor redColor] backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:11 weight:UIFontWeightBold] cell:cell];
       }else{
           [self setUIWithTextCorlor:[UIColor lightGrayColor] backgroundColor:[UIColor cyanColor] font:[UIFont systemFontOfSize:11 weight:UIFontWeightMedium] cell:cell];
       }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    TDMyCouponChannelListModel *deSelectModel = _titleAry[isSelecIndex];
    deSelectModel.isSelect = NO;
    
    TDMyCouponChannelListModel *selectModel = _titleAry[indexPath.item];
    selectModel.isSelect = YES;
    _titleAry[isSelecIndex] = deSelectModel;
    _titleAry[indexPath.item] = selectModel;
    [_collectionView reloadData];
    
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.item];
    NSDictionary *dic = @{@"index":index};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYCouponItemNSNotification" object:self userInfo:dic];
    isSelecIndex = indexPath.item;
    
    if ([_delegate respondsToSelector:@selector(loadData:index:)]) {
        [_delegate loadData:selectModel.channelid index:indexPath.item];
    }
}

-(void)setUIWithTextCorlor:(UIColor *)color backgroundColor:(UIColor *)bgColor font:(UIFont *)font cell:(TDCouponNaviCollectionCell *)cell{
    cell.titleLabel.textColor = color;
    cell.titleLabel.font = font;
    cell.titleLabel.backgroundColor = bgColor;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCornerWithbyRoundingCorners:(UIRectCorner)corner cornerWithRadius:(CGFloat)radius width:(CGFloat)width{

    if (width == 0) {
        width = bgView.bounds.size.width;//是否全部宽度裁剪
    }
    CGRect oldRect = bgView.bounds;
    oldRect.size.width = width;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oldRect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = oldRect;
    bgView.layer.mask = maskLayer;
}
@end
