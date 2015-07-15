//
//  CustomTabBarController.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "GoodsViewController.h"
#import "BuyViewController.h"
#import "MoreViewController.h"
#import "InformationViewController.h"
#import "BaseNavigationController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewController];
    
}

/**
 *  @author Tankch, 15-07-06 16:07:28
 *
 *  初始化 ViewController
 */
- (void)initViewController
{
    NSArray *VCNameArray = @[[HomeViewController class],[GoodsViewController class],[BuyViewController class],[InformationViewController class],[MoreViewController class]];
    NSArray *imageArray = @[@"mv_tabbar_home",@"mv_tabbar_goods",@"mv_tabbar_buy",@"mv_tabbar_information",@"mv_tabbar_more"];
    
    NSMutableArray *ViewControllers = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < VCNameArray.count; i++) {
        UIViewController *rvc = InitVCFromXib(VCNameArray[i]);
        //自定义tabbar title
//        rvc.title = @"自定义";
        rvc.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        
//        rvc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:rvc];
        
        [ViewControllers addObject:Nav];
    }
    //赋值
    self.viewControllers = ViewControllers;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
