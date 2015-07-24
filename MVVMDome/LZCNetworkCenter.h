//
//  LZCNetworkCenter.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/16.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperation.h>
#import <AFNetworking.h>

@interface LZCNetworkCenter : NSObject

/**
 *  @author Tankch, 15-07-16 15:07:47
 *
 *  GET 方式
 *
 *  @param url     请求链接
 *  @param parameter 拼接的参数
 *  @param success 成功block
 *  @param failure 失败block
 */

+ (void)GETRequestDataWithUrl : (NSString *)url parameters : (NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation * operation))success failure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure;


/**
 *  @author Tankch, 15-07-16 15:07:06
 *
 *  POST 方式 不带文件上传
 *
 *  @param url        请求链接
 *  @param parameters 上传的参数
 *  @param success    成功block
 *  @param failure    失败block
 */
+ (void)POSTRequestDataWithUrl : (NSString *)url parameters : (NSDictionary *)parameters success : (void(^)(AFHTTPRequestOperation *operation))success failure : (void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

/**
 *  @author Tankch, 15-07-16 17:07:54
 *
 *  POST 方式 带文件上传和上传进度
 *
 *  @param url           请求链接
 *  @param parameters    上传的参数
 *  @param success       成功的block
 *  @param failure       失败的block
 *  @param data         上传的文件 转成formData
 *  @param progressBlock 进度条 bytesWritten 写入文件的大小 totalBytesWritten 已经写入文件的大小
 */
+ (void)POSTUploadDataAndProgressWithUrl : (NSString *)url parameters : (NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *operation))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *))failure constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))data progress:(void (^)(CGFloat progess))progressBlock;


/**
 *  @author Tankch, 15-07-16 17:07:01
 *
 *  POST 方式 带文件上传
 *
 *  @param url        请求链接
 *  @param parameters 上传的参数
 *  @param success    成功block
 *  @param failure    失败block
 *  @param data       上传的数据
 */
+ (void)POSTUploadDataWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(AFHTTPRequestOperation *operation))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure bodyWithBlock : (void (^)(id <AFMultipartFormData> formData))data;

/**
 *  @author Tankch, 15-07-17 10:07:41
 *
 *  下载文件
 *
 *  @param aUrl      文件的链接
 *  @param aSavePath 保存的位置
 *  @param aFileName 保存文件名字
 *  @param aTag      标签
 */
+ (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;


@end
