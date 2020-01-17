//
//  TDCouponNaviView.h
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDCouponProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TDCouponNaviView : UIView

@property (nonatomic, strong)NSMutableArray *titleAry;

@property (nonatomic, assign)NSInteger currentIndex;

@property (nonatomic, assign) id<TDCouponProtocol>delegate;

-(void)reloadCollectionData;

@end

NS_ASSUME_NONNULL_END
