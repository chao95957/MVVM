//
//  ThreeViewModel.h
//  RACDome
//
//  Created by zsl-mac on 15/7/22.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface ThreeViewModel : NSObject
@property (nonatomic,copy) NSString *sendString;
@property (nonatomic,strong) NSNumber *isRequestFinished;   //请求是否完成
@property (nonatomic,copy) NSError *RequestError;       //请求失败
@property (nonatomic,copy) NSString *title;             //viewcontroller 界面的属性


@property (nonatomic,strong) RACCommand *operationCommand;
- (RACCommand *)startTiemCommand;
- (RACCommand *)cancleButtonCommand;

@end
