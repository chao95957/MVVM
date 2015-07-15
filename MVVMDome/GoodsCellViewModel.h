//
//  GoodsCellViewModel.h
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsListModel.h"

@interface GoodsCellViewModel : NSObject

/**
 *  @author Tankch, 15-07-07 19:07:32
 *
 *  cellModel 获取界面要显示的数据
 *
 *  @return <#return value description#>
 */
- (NSString *)fristLabelText;
- (NSString *)secondLabelText;
- (NSString *)priceLabelText;
- (NSString *)createLabelText;
- (NSString *)tokenLabelText;


/**
 *  @author Tankch, 15-07-07 19:07:29
 *
 *  这里传入 listModel 来获取cell显示的数据
 *
 *  @param model 列表的model
 */
- (void)setDataModel : (GoodsListModel *)model;

@end
