
//
//  TDAllNaviButtonView.m
//  TBRentClient
//
//  Created by tonbright on 2020/1/10.
//  Copyright © 2020 tonbright. All rights reserved.
//

#import "TDAllNaviButtonView.h"

@implementation TDAllNaviButtonView

+ (instancetype)loadNaviView {
    return [[NSBundle mainBundle] loadNibNamed:@"TDAllNaviButtonView" owner:nil options:nil].lastObject;
}

@end
