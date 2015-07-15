//
//  GoodsDetailViewModel.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/9.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsDetailViewModel.h"
#import "GoodsDetailRequestOperator.h"
#import "GoodDetailModel.h"

@interface GoodsDetailViewModel ()

@property (nonatomic,strong) GoodsDetailRequestOperator *detailRequestOperator;
@property (nonatomic,copy) NSString *eventID;
@property (nonatomic,strong) RACSignal *textfieldSignal;
@property (nonatomic,strong) NSNumber *islongText;

@end


@implementation GoodsDetailViewModel

- (id)initWitheventID : (NSString *)eventID
{
    self = [super init];
    if (self) {
        APP_ASSERT(StringNotEmpty(eventID));
        
        _eventID = eventID;
        _detailRequestOperator = [[GoodsDetailRequestOperator alloc]init];
        _textfieldSignal = RACObserve(self, textfieldString);
        [self textChangeformTextField];
        
    }
    return self;
    
}

- (void)requestData
{
    @weakify(self);
    [[_detailRequestOperator getDetailByID:_eventID] subscribeNext:^(GoodDetailModel *model) {
        @strongify(self);
        
        //判断是否有model过来
        if (model != nil) {
            self.fristString = model.companyName;
            self.secondString = model.manufacturer;
            self.threeString = model.material;
            self.fourString = model.linkman;
        }else
        {
            self.requsetError = @"error";
        }
        
    }error:^(NSError *error) {
        @strongify(self);
        self.isrequestFinshed = @(YES);
    }completed:^{
        @strongify(self);
        self.isrequestFinshed = @(YES);
    }];
    
    
}

- (RACCommand *)getSubmitButtonCommand
{
    //按钮的commmand
    RACCommand *submitButtonCommand = [[RACCommand alloc]initWithEnabled:[self requestFinshSignal] signalBlock:^RACSignal *(NSString* input) {
        //如果textfield .text长度>0 则执行
        [self requestData];
        return [RACSignal empty];
    }];
    return submitButtonCommand;
}

- (RACSignal *)requestFinshSignal
{
    //条件信息
    RACSignal *signal = [RACObserve(self, islongText)map:^id(NSNumber *islong) {
        return (islong && islong.boolValue) ? @(YES) : @(NO);
    }];
    return signal;
}

- (void)textChangeformTextField
{
    
    @weakify(self);
    [[_textfieldSignal map:^id(NSString *string) {
        @strongify(self);
        return string.length > 0 ? (self.islongText = @(YES)):(self.islongText = @(NO));
    }]subscribeNext:^(id x) {
        
    }];
}

- (BOOL)isValidUsername : (NSString *)text
{
    //长度大于0
    if (text.length>0) {
        return YES;
    }
    return NO;
}



@end
