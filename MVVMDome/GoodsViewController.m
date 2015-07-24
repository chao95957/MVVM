//
//  GoodsViewController.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/6.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsCellViewModel.h"
#import "GoodsListViewModel.h"
#import "GoodsListTableViewCell.h"
#import <MJRefresh.h>
#import "GoodsDetailViewController.h"

@interface GoodsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) GoodsListViewModel *viewModel;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"现货资源";
    
    _viewModel = [[GoodsListViewModel alloc]init];
    
    [self initUI];
    [self bindHander];
    
}


- (void)initUI
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)bindHander
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //
    [self bindViewModelDataHander];
    //添加上拉刷新和下拉刷新
    [self bindPullToRefreshAndLoadMoreHandler];
    
}

- (void)bindViewModelDataHander
{
    
    @weakify(self);
    //listViewModel 的isNoMore 如果发生变化, 则执行
    [[[RACObserve(self.viewModel, isNoMore) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber* isNoMore) {
        @strongify(self);
        if ([isNoMore boolValue]) {
            //没有更多数据
            [self.tableView.footer noticeNoMoreData];
            
        }
    }];
    
    //listViewModel 的appendItemCount 发现变化 则执行
    [[[RACObserve(self, viewModel.appendItemCount) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSNumber* appendItemCount) {
        @strongify(self);
        if (appendItemCount.integerValue > 0) {
            //tableview 开始刷新
            [self.tableView beginUpdates];
            //计算插入的位置
            NSInteger startInsertPos = self.viewModel.itemCount - appendItemCount.integerValue;
            NSMutableArray *arrRowsAdd = [[NSMutableArray alloc] init];
            for (int i = 0; i < appendItemCount.integerValue; i++)
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(startInsertPos+i) inSection:0];
                [arrRowsAdd addObject:indexPath];
            }
            //刷新插入
            [self.tableView insertRowsAtIndexPaths:arrRowsAdd withRowAnimation:UITableViewRowAnimationNone];
            //结束更新
            [self.tableView endUpdates];
            
            //结束头刷新 和尾刷新
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }
    }];
    
    //请求错误的时候 则执行
    [[[RACObserve(self.viewModel, isRequestError) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(NSError *error) {
        @strongify(self);
        NSLog(@"请求错误");
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 这里list ViewModel 已经做处理了
    return [_viewModel itemCount];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentify = @"cell";
    GoodsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (cell == nil) {
        cell = [GoodsListTableViewCell cellFromXib];
    }
    //根据列表viewModel 获取cell 的viewModel
    GoodsCellViewModel *viewModel = [_viewModel cellViewModelAtIndex:indexPath.row];
    
    //cell 根据viewModel显示
    [cell showWithViewModel:viewModel];
    
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell 本身处理
    return [GoodsListTableViewCell cellHeight];
}

- (void)bindPullToRefreshAndLoadMoreHandler
{
    @weakify(self);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        //上拉刷新,更新界面
        [self.viewModel refreshList];
        [self.tableView reloadData];
    
    }];
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //下拉刷新 加载更多
        [self.viewModel loadMore];
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *rvc = InitVCFromXib([GoodsDetailViewController class]);
    rvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rvc animated:YES];
    
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
