//
//  BuyListModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface BuyListModel : MTLModel<MTLJSONSerializing>
//@"city":@"city",
//@"follow" : @"follow",
//@"is_qq" : @"is_qq",
//@"is_supply" : @"is_supply",
//@"manufacturer" : @"manufacturer",
//@"material" : @"material",
//@"name" : @"name",
//@"onsale_number" : @"onsale_number",
//@"price" : @"price",
//@"purchase_id" : @"purchase_id",
//@"purchase_sn" : @"purchase_sn",
//@"status" : @"status",
//@"status_name" : @"status_name",
//@"tel" : @"tel",
//@"update_time" : @"update_time"

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *follow;
@property (nonatomic,copy) NSString *is_qq;
@property (nonatomic,strong) NSNumber *is_supply;
@property (nonatomic,copy) NSString *manufacturer;
@property (nonatomic,copy) NSString *material;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *onsale_number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *purchase_id;
@property (nonatomic,copy) NSString *purchase_sn;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *status_name;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *update_time;



@end
