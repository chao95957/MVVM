//
//  LZCNetworkCenter.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "LZCNetworkCenter.h"

@implementation LZCNetworkCenter

#pragma mark 不带HUD的请求
+ (void)GETRequestDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //请求时间
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //小菊花转动
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        success(operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(operation,error);
    }];
    
}

+ (void)POSTRequestDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        
        success(operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(operation,error);
            
    }];
    
}

+ (void)POSTUploadDataAndProgressWithUrl : (NSString *)url parameters : (NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))data progress : (void (^)(CGFloat progess))progressBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        data(formData);
    } error:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(operation,error);
        
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = (totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        progressBlock(progress);
    }];
    [operation start];
}

+ (void)POSTUploadDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure bodyWithBlock:(void (^)(id<AFMultipartFormData>))data{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    [manage.requestSerializer setTimeoutInterval:30];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        data(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(operation,error);
    }];
    
}

+ (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    
    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        
    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        [operation start];
    }
}


#pragma mark 带HUD的请求






@end
