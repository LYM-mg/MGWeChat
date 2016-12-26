//
//  WXDiscoverController.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "WXDiscoverController.h"
#import "FriendCircleVC.h"
#import "DiscoverModel.h"
#import "ShakeVC.h"

@interface WXDiscoverController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *discoverTableViewView;
}
/** 发现数据源 */
@property (nonatomic,strong) NSArray *discoverDataSource;

/** 朋友圈 */
@property (nonatomic,strong) FriendCircleVC *friendCircleVC;
/** 摇一摇 */
@property (nonatomic,strong) ShakeVC *shakeVC;

@end

@implementation WXDiscoverController
#pragma mark - lazy
- (NSArray *)discoverDataSource{
    if (!_discoverDataSource) {
        _discoverDataSource = [DiscoverModel objectArrayWithFilename:@"Discover.plist"];
    }
    return _discoverDataSource;
}

///懒加载评论页面（朋友圈页面）
-(FriendCircleVC *)friendCircleVC{
    if (!_friendCircleVC){
        _friendCircleVC = [[FriendCircleVC alloc] init];
    }
    return _friendCircleVC;
}

- (ShakeVC *)shakeVC{
    if (!_shakeVC){
        _shakeVC = [[ShakeVC alloc] init];
    }
    return _shakeVC;
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
    discoverTableViewView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    discoverTableViewView.delegate = self;
    discoverTableViewView.dataSource = self;
    [discoverTableViewView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"KDiscoverCellIdentifier"];
    [self.view addSubview:discoverTableViewView];
    [discoverTableViewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
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
    return self.discoverDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *groupArr = self.discoverDataSource[section];
    return groupArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KDiscoverCellIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSArray *groupArr = self.discoverDataSource[indexPath.section];
    DiscoverModel *model = groupArr[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:model.iconName];
    cell.textLabel.text = model.titleName;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:self.friendCircleVC animated:YES];
    } else if (1 ==  indexPath.section) {
        if (1 ==  indexPath.row) {
            [self.navigationController pushViewController:self.shakeVC animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
