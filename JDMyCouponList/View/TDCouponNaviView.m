
//
//  TDCouponNaviView.m
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "TDCouponNaviView.h"
#import "TDNaviViewCollectionCell.h"
#import "TDMyCouponChannelListModel.h"

#define Width [UIScreen mainScreen].bounds.size.width
//我的优惠券界面
#define naviItemHeight 47

#define naviAllBtnW 60

#define naviAllItemsH 40 //按钮高度和上间距10

@interface TDCouponNaviView()<UICollectionViewDelegate, UICollectionViewDataSource>{
    NSInteger isSelecIndex; //点击的第几个item
}

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TDCouponNaviView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self addSubview:self.lineView];
    }
    return self;
}

-(void)reloadCollectionData {
    [self initUI];
    [_collectionView reloadData];
}
                                   
-(void)initUI {
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < _titleAry.count; i++) {
//        TDMyCouponChannelListModel *model = _titleAry[i];
//        model.isSelect = (i == _currentIndex) ? YES : NO;
//        [array addObject:model];
//    }
//    _titleAry = array;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake((Width - naviAllBtnW)/4, naviItemHeight);
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width - naviAllBtnW,naviItemHeight - 1) collectionViewLayout:layout];
    _collectionView.contentSize = CGSizeMake((Width - naviAllBtnW)/4 * _titleAry.count, naviItemHeight - 1);
    [self addSubview:_collectionView];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TDNaviViewCollectionCell class]) bundle:nil]forCellWithReuseIdentifier:@"TDNaviViewCollectionCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollToItem:)
                                                 name:@"MYCouponItemNSNotification"
                                               object:nil];
    isSelecIndex = _currentIndex;

}

-(void)scrollToItem:(NSNotification *)info{
    NSDictionary *dic = info.userInfo;
    NSInteger item = [dic[@"index"] integerValue];
    
    //取消上一个item
    TDMyCouponChannelListModel *deSelectModel = _titleAry[isSelecIndex];
     deSelectModel.isSelect = NO;
    _titleAry[isSelecIndex] = deSelectModel;
    
    //选中点击的item
    TDMyCouponChannelListModel *selectModel = _titleAry[item];
    selectModel.isSelect = YES;
    _titleAry[item] = selectModel;
    [_collectionView reloadData];
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    isSelecIndex = item;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TDNaviViewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TDNaviViewCollectionCell" forIndexPath:indexPath];
    TDMyCouponChannelListModel *model = _titleAry[indexPath.item];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)", model.channelname, model.total];
    if (model.isSelect) {
        [self setUIWithTextCorlor:[UIColor redColor] hidden:NO font:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] cell:cell];
    }else{
        [self setUIWithTextCorlor:[UIColor lightGrayColor] hidden:YES font:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] cell:cell];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];

    TDMyCouponChannelListModel *deSelectModel = _titleAry[isSelecIndex];
    deSelectModel.isSelect = NO;
    
    TDMyCouponChannelListModel *selectModel = _titleAry[indexPath.item];
    selectModel.isSelect = YES;
    _titleAry[isSelecIndex] = deSelectModel;
    _titleAry[indexPath.item] = selectModel;
    [_collectionView reloadData];
    
    
    NSString *index = [NSString stringWithFormat:@"%ld",indexPath.item];
    NSDictionary *dic = @{@"index":index};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYCouponAllItemNSNotification" object:self userInfo:dic];
    isSelecIndex = indexPath.item;
    
    if ([_delegate respondsToSelector:@selector(loadData:index:)]) {
        [_delegate loadData:selectModel.channelid index:indexPath.item];
    }
}

-(void)setUIWithTextCorlor:(UIColor *)color hidden:(BOOL)hidden font:(UIFont *)font cell:(TDNaviViewCollectionCell *)cell{
    cell.titleLabel.textColor = color;
    cell.bottomLineView.hidden = hidden;
    cell.titleLabel.font = font;
}

#pragma mark - lazy
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, naviItemHeight - 1, Width, 1)];
        _lineView.backgroundColor = [UIColor yellowColor];
    }
    return _lineView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
