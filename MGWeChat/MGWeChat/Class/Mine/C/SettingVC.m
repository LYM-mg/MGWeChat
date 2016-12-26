//
//  SettingVC.m
//  MGWeChat
//
//  Created by ming on 16/8/18.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *settingTableViewView;
}
@end

@implementation SettingVC

#pragma mark - lazy


#pragma mark - 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建UI界面
    [self setUpMainView];
}

#pragma mark - 创建UI界面
- (void)setUpMainView {
    settingTableViewView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    settingTableViewView.delegate = self;
    settingTableViewView.dataSource = self;
    [settingTableViewView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"KSettingCellIdentifier"];
    [self.view addSubview:settingTableViewView];
    [settingTableViewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    settingTableViewView.contentInset = UIEdgeInsetsMake(MGMargin, 0, 0, 0);
    
    settingTableViewView.tableFooterView = [UIView new];
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
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSettingCellIdentifier"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"账号与安全";
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"新消息通知";
            } else  if (indexPath.row == 1){
                cell.textLabel.text = @"隐私";
            } else{
                cell.textLabel.text = @"通用";
            }
            break;
        case 2:
                cell.textLabel.text = @"关于微信";
            break;
        case 3:{
            cell.accessoryType = UITableViewCellAccessoryNone;
            UILabel *exitLabel = [[UILabel alloc] initWithFrame:cell.bounds];
            exitLabel.textAlignment = NSTextAlignmentCenter;
            exitLabel.text = @"退出登录";
            [cell addSubview:exitLabel];
        }
            break;
        default:
            break;
    }
//    cell.textLabel.text = model.titleName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                
            } else  if (indexPath.row == 1){
                
            } else{
                
            }
        }
            break;
        case 2:{
            
        }
            
            break;
        case 3:{
            // 退出登录 跳转到登录控制器
            [[UIApplication sharedApplication].keyWindow setRootViewController:[UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController];
            
            CATransition *transiction = [CATransition animation];
            transiction.type = @"cube";
            transiction.subtype = @"up";
            transiction.duration = 0.5;
            
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:transiction forKey:nil];

        }
            break;
        default:
            break;
    }
}

@end