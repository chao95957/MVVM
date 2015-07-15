//
//  GoodsListModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface GoodsListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *linkman;
@property (nonatomic,copy) NSString *manufacturer;
@property (nonatomic,copy) NSString *material;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *modify;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSString *onsale_number;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,copy) NSString *warehouse;
@property (nonatomic,copy) NSString *city;


+ (NSDictionary *)JSONKeyPathsByPropertyKey;


@end
