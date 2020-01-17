//
//  ViewController.m
//  JDMyCouponList
//
//  Created by tonbright on 2020/1/17.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "ViewController.h"
#import "TDCouponNaviView.h"
#import "TDAllNaviButtonView.h"
#import "TDAllNaviCouponItemsView.h"
#import "TDMyCouponChannelListModel.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define naviHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

//我的优惠券界面
#define naviItemHeight 47

#define naviAllBtnW 60

#define naviAllItemsH 40 //按钮高度和上间距10

@interface ViewController ()<TDCouponProtocol>

@property (nonatomic, strong) TDCouponNaviView *naviTitleView;
@property (nonatomic, strong) TDAllNaviButtonView *naviBtnView;
@property (nonatomic, strong) TDAllNaviCouponItemsView *allItemsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.naviTitleView];
      NSMutableArray *array = [NSMutableArray array];
      
      for (int i = 0; i < 10; i++) {
          TDMyCouponChannelListModel *model = [TDMyCouponChannelListModel new];
          model.isSelect = (i == 0) ? YES : NO;
          model.channelname = @"全部";
          model.total = [NSString stringWithFormat:@"%d",i];
          [array addObject:model];
      }
    _naviTitleView.titleAry = array;
    _allItemsView.titleAry = array;
    [_naviTitleView reloadCollectionData];
    [_allItemsView reloadCollectionData];
}

//顶部的title
-(TDCouponNaviView *)naviTitleView{
    if (!_naviTitleView) {
        _naviTitleView = [[TDCouponNaviView alloc] initWithFrame:CGRectMake(0, naviHeight, Width, naviItemHeight)];
        _naviTitleView.backgroundColor = [UIColor greenColor];
        [_naviTitleView addSubview:self.naviBtnView];
        [self.view addSubview:self.allItemsView];
        _allItemsView.hidden = YES;
        _naviTitleView.delegate = self;
    }
    return _naviTitleView;
}

//顶部右侧的按钮
-(TDAllNaviButtonView *)naviBtnView{
    if (!_naviBtnView) {
        _naviBtnView = [TDAllNaviButtonView loadNaviView];
        _naviBtnView.frame = CGRectMake(Width - naviAllBtnW, 0, naviAllBtnW, naviItemHeight - 1);
        [_naviBtnView.allBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBtnView;
}

//隐藏的所有title
-(TDAllNaviCouponItemsView *)allItemsView{
    if (!_allItemsView) {
        _allItemsView = [[TDAllNaviCouponItemsView alloc] initWithFrame:CGRectMake(0, naviItemHeight + naviHeight, Width, Height - naviItemHeight - naviHeight)];
        _allItemsView.delegate = self;
    }
    return _allItemsView;
}

#pragma mark - allBtnAction 按钮点击
-(void)allBtnAction:(UIButton *)sender {
    _allItemsView.hidden = !_allItemsView.hidden;
}

@end
