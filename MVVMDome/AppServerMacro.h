//
//  AppServerMacro.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#ifndef MVVMDome_AppServerMacro_h
#define MVVMDome_AppServerMacro_h

/**
 *  @author Tankch, 15-07-06 15:07:32
 *
 *  这个用于存储APP 接口API
 */

#define LINE @"http://app.zhaosuliao.com"
#define REALM_NAME @"http://www.zhaosuliao.com"
//
//#define LINE @"http://apptest.zhaosuliao.com:7788"
//#define REALM_NAME @"http://apptest.zhaosuliao.com:7788"

//现货资源
#define PL_GOODS_URL [NSString stringWithFormat:@"%@%@",LINE,@"/?app=product"]


#endif
