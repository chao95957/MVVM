//
//  AppMacro.h
//  Arrange
//
//  Created by zsl-mac on 15/7/3.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#ifndef Arrange_AppMacro_h
#define Arrange_AppMacro_h

/**
 *  @author Tankch, 15-07-03 11:07:57
 *
 *  这里是设备信息宏
 *
 *  @since 1.0
 */

//APP版本号
#define AppVersionNumber [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//APP名称
#define AppName [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
//当前设备名称
#define DeviceName [[UIDevice currentDevice] name]
//当前设备版本号
#define DeviceVersion                           [[UIDevice currentDevice] systemVersion]

//设备大小
#define IPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//APP文件路径
#define ResourcePath     [[NSBundle mainBundle] resourcePath]

//屏幕大小
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


#endif
