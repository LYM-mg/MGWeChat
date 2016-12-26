//
//  WXMeController.m
//  仿微信主框架
//
//  Created by ming on 15/12/18.
//  Copyright © 2015年 ming. All rights reserved.
//

#import "WXMeController.h"
#import "DiscoverModel.h"
#import "MineHeaderView.h"

#import "SettingVC.h"

@interface WXMeController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mineTableViewView;
    MineHeaderView *mineHeaderView;
}
/** 发现数据源 */
@property (nonatomic,strong) NSArray *mineDataSource;
@end

@implementation WXMeController

#pragma mark - lazy
- (NSArray *)mineDataSource{
    if (!_mineDataSource) {
        _mineDataSource = [DiscoverModel objectArrayWithFilename:@"Mine.plist"];
    }
    return _mineDataSource;
}

#pragma mark - 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建UI界面
    [self setUpMainView];
}

#pragma mark - 创建UI界面
- (void)setUpMainView {
    mineTableViewView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    mineTableViewView.delegate = self;
    mineTableViewView.dataSource = self;
    [mineTableViewView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"KPersonCenterCellIdentifier"];
    [self.view addSubview:mineTableViewView];
    [mineTableViewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    mineTableViewView.contentInset = UIEdgeInsetsMake(MGMargin, 0, 0, 0);
    mineTableViewView.tableFooterView = [UIView new];
    
    mineHeaderView = [MineHeaderView mineHeaderView];
    [mineHeaderView mineHeaderViewWithHander:^{
        MGPS(@"点击了HeaderView");
    }];
    mineTableViewView.tableHeaderView = mineHeaderView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    mineHeaderView.frame = CGRectMake(0, 0, MGScreenW, 70);
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MGMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

// 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mineDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *groupArr = self.mineDataSource[section];
    return groupArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KPersonCenterCellIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *groupArr = self.mineDataSource[indexPath.section];
    DiscoverModel *model = groupArr[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:model.iconName];
    cell.textLabel.text = model.titleName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row==0) {
                
            }else if (indexPath.row==1){
                
            }else if (indexPath.row==2){
                
            }else if (indexPath.row==3){
                
            }
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = MGRandomColor;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:{
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = MGRandomColor;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            SettingVC *settingVC = [[SettingVC alloc]init];
            [self.navigationController pushViewController:settingVC animated:YES];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
