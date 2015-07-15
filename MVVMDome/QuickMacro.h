//
//  QuickMacro.h
//  Arrange
//
//  Created by zsl-mac on 15/7/3.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#ifndef Arrange_QuickMacro_h
#define Arrange_QuickMacro_h

/**
 *  @author Tankch, 15-07-03 11:07:31
 *
 *  这里是放一些方便APP的宏
 */

/**
 *  @author Tankch, 15-07-03 11:07:08
 *
 *  XIB 和 Storyboard宏
 */
#define InitVCFromStoryboard(storyboardName, VCID) [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:VCID];
#define InitVCFromXib(XibName) [[XibName alloc]initWithNibName:NSStringFromClass(XibName) bundle:nil];


/**
 *  @author Tankch, 15-07-03 11:07:00
 *
 *  调试宏
 */



/**
 *  @author Tankch, 15-07-03 11:07:01
 *
 *  颜色宏
 */
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 *  @author Tankch, 15-07-03 11:07:45
 *
 *  字体宏
 */
//字体雅黑
#define YAHEI_FONT(X) [UIFont fontWithName:@"MicrosoftYaHei" size:X]

//View的操作
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y

//图片加载
#define ImageNamed(name) [UIImage imageWithContentsOfFile:[ResourcePath stringByAppendingPathComponent:name]]

//断言
// assert
#ifdef ENABLE_ASSERT_STOP
#define APP_ASSERT_STOP                     {LogRed(@"APP_ASSERT_STOP"); NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);}
#define APP_ASSERT(condition)               {NSAssert(condition, @" ! Assert");}
#else
#define APP_ASSERT_STOP                     do {} while (0);
#define APP_ASSERT(condition)               do {} while (0);
#endif

//判空
#define StringNotEmpty(str)                 (str && (str.length > 0))
#define ArrayNotEmpty(arr)                  (arr && (arr.count > 0))

#endif
