//
//  TDAllNaviButtonView.h
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDAllNaviButtonView : UIView

+ (instancetype)loadNaviView;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@end

NS_ASSUME_NONNULL_END
