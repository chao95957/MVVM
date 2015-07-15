//
//  searchModel.h
//  SearchPlastic
//
//  Created by zsl-mac on 14/12/18.
//  Copyright (c) 2014年 zsl-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *keyword;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,assign) int page;
- (NSMutableString *)getUrlWithCity:(NSString *)city time : (NSString *)time keyword : (NSString *)keyword sort: (NSString *)sort page:(int)page;

@end
