
//
//  TDMyCouponChannelListModel.m
//  TBRentClient
//
//  Created by tonbright on 2020/1/14.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "TDMyCouponChannelListModel.h"

@implementation TDMyCouponChannelListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"itemlist" : [TDMyCouponChannelItemListModel class],
    };
}
@end
@implementation TDMyCouponChannelItemListModel


@end


