//
//  TDCouponProtocol.h
//  TBRentClient
//
//  Created by tonbright on 2020/1/14.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TDCouponProtocol <NSObject>

-(void)loadData:(NSString *)channelId index:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
