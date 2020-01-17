//
//  TDMyCouponChannelListModel.h
//  TBRentClient
//
//  Created by tonbright on 2020/1/14.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDMyCouponChannelListModel : NSObject

@property (nonatomic, assign) BOOL isSelect;//点击状态

//频道ID
@property (nonatomic, copy) NSString *channelid;
//频道名称
@property (nonatomic, copy) NSString *channelname;
//此分类优惠券数
@property (nonatomic, copy) NSString *total;
//频道明细项目列表
@property (nonatomic, copy) NSArray *itemlist;

@end

@interface TDMyCouponChannelItemListModel : NSObject

//频道id
@property (nonatomic, copy) NSString *channelid;
//频道明细ID
@property (nonatomic, copy) NSString *seqid;
//标题
@property (nonatomic, copy) NSString *itemtitle;
//子标题
@property (nonatomic, copy) NSString *itemsubtitle;
//内容描述
@property (nonatomic, copy) NSString *content;
//子系统id
@property (nonatomic, copy) NSString *systemid;
//关联对象类型
@property (nonatomic, copy) NSString *objecttype;
//关联对象类型名称
@property (nonatomic, copy) NSString *objecttypenm;
//关联对象id
@property (nonatomic, copy) NSString *objectid;
//关联对象描述
@property (nonatomic, copy) NSString *objectdesc;
//图片链接
@property (nonatomic, copy) NSString *linkurl;
//跳转区分
@property (nonatomic, copy) NSString *gototype;
//跳转链接
@property (nonatomic, copy) NSString *gotourl;
//跳转原生的辅助参数
@property (nonatomic, copy) NSString *extraparam;
//排序
@property (nonatomic, copy) NSString *sortby;
@end



NS_ASSUME_NONNULL_END
