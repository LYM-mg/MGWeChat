//
//  FriendSearchResultVC.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendSearchResultVC.h"
#import "FriendCell.h"
#import "FriendModel.h"

@interface FriendSearchResultVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *resultTableView;
    NSMutableArray *dataSource;
    UILabel *footerLabel;
}

@end

@implementation FriendSearchResultVC


- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MGScreenW,self.view.height  - MGNavHeight) style:UITableViewStylePlain];
    [resultTableView registerClass:[FriendCell class] forCellReuseIdentifier:KFriendCellIdentifier];
    
    resultTableView.showsVerticalScrollIndicator = NO;
    resultTableView.bouncesZoom = NO;
    resultTableView.delegate = self;
    resultTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    resultTableView.dataSource = self;
    resultTableView.rowHeight = 55;
    [self.view addSubview:resultTableView];
    
    
    footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, resultTableView.frame.size.width, 40)];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [UIColor lightGrayColor];
    if (dataSource.count==0) {
        footerLabel.text = @"无结果";
        resultTableView.tableFooterView = footerLabel;
    }else{
        footerLabel.text = @"";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section //行数
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:KFriendCellIdentifier];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(dataSource.count>0)
    {
        FriendModel *friendModel = [dataSource objectAtIndex:indexPath.row];
        cell.friendModel = friendModel;
    }else{
        if (dataSource.count==0) {
            footerLabel.text = @"无结果";
            resultTableView.tableFooterView = footerLabel;
        }else{
            footerLabel.text = @"";
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void)updateAddressBookData:(NSArray *)AddressBookDataArray{
    [dataSource removeAllObjects];
    
    [dataSource addObjectsFromArray:AddressBookDataArray];
    
    [resultTableView reloadData];
    if (dataSource.count==0) {
        footerLabel.text = @"无结果";
        resultTableView.tableFooterView = footerLabel;
    }else{
        footerLabel.text = @"";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendModel *friends = [dataSource objectAtIndex:indexPath.row];
    
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(selectPersonWithUserId:userName:photo:phoneNO:)]) {
            [self.delegate selectPersonWithUserId:friends.userId userName:friends.userName photo:friends.photo phoneNO:friends.phoneNO];
        }
    }];
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"Entering:%@ ",searchController.searchBar.text);
}

@end
