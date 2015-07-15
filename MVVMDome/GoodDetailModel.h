//
//  GoodDetailModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface GoodDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *linkman;
@property (nonatomic,copy) NSString *manufacturer;
@property (nonatomic,copy) NSString *material;


@end
