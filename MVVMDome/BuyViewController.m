//
//  BuyViewController.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "BuyViewController.h"
#import <MJRefresh.h>


@interface BuyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"采购信息";
    
    _buyListViewModel = [[BuyListViewModel alloc]init];
    
    
    [self initUI];
    //添加头文件
    [self addHeadRefreshAndFootRefresh];
    [self bindingViewAndViewModel];
    
    
}
#pragma mark 初始化UI
- (void)initUI
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark 绑定上拉刷新和下拉刷新
- (void)addHeadRefreshAndFootRefresh
{
    @weakify(self);
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        //刷新数据
        [self.buyListViewModel refreshList];
        [self.tableview reloadData];
        
    }];
    [self.tableview.header beginRefreshing];
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //下拉刷新 加载更多
        [self.buyListViewModel loadMore];
        
    }];
    
}

#pragma mark binding view and Viewmodel
- (void)bindingViewAndViewModel
{
    @weakify(self);
    [RACObserve(self.buyListViewModel, isNoMore)subscribeNext:^(NSNumber* isNoMore) {
        @strongify(self);
        if ([isNoMore boolValue]) {
            NSLog(@"没有更多数据");
            [self.tableview.footer noticeNoMoreData];
        }
        
    }];
    
    //考虑线程问题 直接运行
//    [[[RACObserve(self.buyListViewModel, appendItemCount) ignore:nil]deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber* itemCount) {
//        @strongify(self);
//        if ([itemCount intValue]>0) {
//            [self.tableview reloadData];
//        }
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//    }];
//      不考虑线程问题 直接运行scribeNext 子线程会执行
//    [RACObserve(self.buyListViewModel, appendItemCount)subscribeNext:^(NSNumber* itemCount) {
//        @strongify(self);
//        if ([itemCount intValue]>0) {
//            [self.tableview reloadData];
//        }
//        [self.tableview.header endRefreshing];
//        [self.tableview.footer endRefreshing];
//        
//    }];
    
    //考虑到线程 
    [[RACObserve(self.buyListViewModel, appendItemCount)deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber* itemCount) {
        @strongify(self);
        if ([itemCount intValue]>0) {
            [self.tableview reloadData];
        }
        [self.tableview.header endRefreshing];
        [self.tableview.footer endRefreshing];
        
    }];
    
    [[[[RACObserve(self.buyListViewModel, isRequestError)ignore:nil]deliverOn:RACScheduler.mainThreadScheduler] filter:^BOOL(NSNumber* value) {
        return ([value boolValue] == YES);
    }]subscribeNext:^(NSNumber* value) {
        NSLog(@"请求错误");
        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.buyListViewModel itemCount];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indefitycell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefitycell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefitycell];
    }
    
    return cell;
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
