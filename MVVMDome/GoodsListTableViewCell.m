//
//  GoodsListTableViewCell.m
//  MVVMDome
//
//  Created by zsl-mac on 15/7/7.
//  Copyright (c) 2015年 ZhaoSuLiao. All rights reserved.
//

#import "GoodsListTableViewCell.h"

@interface GoodsListTableViewCell ()

@property (nonatomic, strong) GoodsCellViewModel *cellViewModel;

@end


@implementation GoodsListTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//XIB 添加Cell
+ (GoodsListTableViewCell *)cellFromXib
{
    GoodsListTableViewCell *cell;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"GoodsListTableViewCell" owner:self options:nil];
    APP_ASSERT(nib && nib.count > 0)
    cell = (GoodsListTableViewCell *)[nib objectAtIndex:0];
    return cell;
}

//返回cell的高度
+ (CGFloat)cellHeight
{
    return 65;
}

//这个方法防止数据错乱问题
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.fristLabel.text = @"";
    self.secondLabel.text = @"";
    self.priceLabel.text = @"";
    self.createTimeLabel.text = @"";
    self.tokenLabel.text = @"";
    
}


- (void)showWithViewModel:(GoodsCellViewModel *)viewModel
{
    APP_ASSERT(viewModel);
    _cellViewModel = viewModel;
    if (_cellViewModel) {
        
        //cell 界面设置
        self.fristLabel.text = [viewModel fristLabelText];
        self.secondLabel.text = [viewModel secondLabelText];
        self.priceLabel.text = [viewModel priceLabelText];
        self.createTimeLabel.text = [viewModel createLabelText];
        self.tokenLabel.text = [viewModel tokenLabelText];
        if (IPhone6P) {
            _rightLayout.constant = 60;
            //        _leftLayout.constant = -56;
        }else if (iPhone6)
        {
            _rightLayout.constant = 45;
        }
    }
    
}


@end
