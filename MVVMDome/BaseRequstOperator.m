//
//  BaseRequstOperator.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BaseRequstOperator.h"

@implementation BaseRequstOperator


- (void)addAppNameToUserAgent:(NSMutableURLRequest *)objURLRequest
{
    /*
     必须重设agent，因为AFNetworking中这样定义：
     userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
     
     而服务端需要检测 Eventor 字符串，所以手动修改Agent内容。
     之所以不直接修改afnetworking代码，是怕更新代码版本时很容易忘记修改。
     */
    if (objURLRequest)
    {
        NSString *strValue = [objURLRequest valueForHTTPHeaderField:@"User-Agent"];
        
        NSString *strOld = [NSString stringWithFormat:@"%@/%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey]];
        NSString *strNew = [NSString stringWithFormat:@"%@/%@", AppName, AppVersionNumber];
        NSString *strNewValue = [strValue stringByReplacingOccurrencesOfString:strOld withString:strNew];
        
        [objURLRequest setValue:strNewValue forHTTPHeaderField:@"User-Agent"];
    }else{APP_ASSERT_STOP}
}


@end
