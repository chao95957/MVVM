//
//  BaseRequstOperator.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <ReactiveCocoa.h>


@interface BaseRequstOperator : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *afRequestManager;


- (void)addAppNameToUserAgent:(NSMutableURLRequest *)objURLRequest;



@end
