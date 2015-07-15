//
//  GoodsDetailViewModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface GoodsDetailViewModel : NSObject

@property (nonatomic,copy) NSString *fristString;
@property (nonatomic,copy) NSString *secondString;
@property (nonatomic,copy) NSString *threeString;
@property (nonatomic,copy) NSString *fourString;
@property (nonatomic,copy) NSString *textfieldString;


@property (nonatomic,copy) NSString *requsetError;
@property (nonatomic,strong) NSNumber *isrequestFinshed;

- (void)requestData;
- (id)initWitheventID : (NSString *)eventID;
- (RACCommand *)getSubmitButtonCommand;
@end
