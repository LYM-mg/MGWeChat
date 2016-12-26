//
//  WXContactController.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "WXContactController.h"
#import "FriendSearchResultVC.h"
#import "FriendModel.h"
#import "FriendCell.h"

#import "PinYin4Objc.h"

@interface WXContactController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    FriendSearchResultVC *resultController;

    UITableView *friendTableView;
}
/** 搜索结果控制器 */
@property (nonatomic,strong) UISearchController *searchController;
/** 数据源数组 */
@property (nonatomic,strong) NSMutableArray *friendDataSource;
/** 要更新的数组 */
@property (nonatomic,strong) NSMutableArray *updateArray;
/** 头部字母数组 */
@property(nonatomic,strong) NSArray *lettersArray;

@property(nonatomic,strong) NSMutableDictionary *nameDic;
@property(nonatomic,strong) NSMutableArray *results;
@end

@implementation WXContactController

#pragma mark -  UISearchResultsUpdating

#pragma mark - lazy
- (UISearchController *)searchController{
    if (_searchController == nil) {
        // 2.搜索结果控制器
        resultController = [[FriendSearchResultVC alloc] init];
        // 搜索控制器
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchResultsUpdater = resultController;
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.tintColor = [UIColor greenColor];
        _searchController.searchBar.frame = CGRectMake(_searchController.view.origin.x, _searchController.view.origin.y, MGScreenW, 44);
        _searchController.searchBar.searchTextPositionAdjustment = UIOffsetZero;
    }
    return _searchController;
}

- (NSMutableArray *)friendDataSource{
    if (_friendDataSource == nil) {
        _friendDataSource = [NSMutableArray array];
    }
    return _friendDataSource;
}

- (NSMutableArray *)updateArray{
    if (_updateArray == nil) {
        _updateArray = [NSMutableArray array];
    }
    return _updateArray;
}

- (NSArray *)lettersArray{
    if (!_lettersArray) {
        _lettersArray = [NSArray array];
    }
    return _lettersArray;
}

- (NSMutableDictionary *)nameDic{
    if (!_nameDic) {
        _nameDic = [NSMutableDictionary dictionary];
    }
    return _nameDic;
}

#pragma mark - 控制器生命周期

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // 1.创建UI界面
    [self setUpMainView];
    
    // 2.加载数据
    [self loadAddressBookData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - 加载数据
- (void)loadAddressBookData{
    NSData *friendsData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AddressBook" ofType:@"json"]]];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:friendsData options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *eachDict in jsonDict[@"friends"][@"row"]) {
        [self.friendDataSource addObject:[FriendModel friendModelWithDict:eachDict]];
    }
    [self handleLettersArray];
    // 刷新数据
    [friendTableView reloadData];
}

/**
 *  处理字母 头部数组
 */
- (void)handleLettersArray {
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
    
    for(FriendModel *friends  in self.friendDataSource)
    {
        HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
        formatter.caseType = CaseTypeLowercase;
        formatter.vCharType = VCharTypeWithV;
        formatter.toneType = ToneTypeWithoutTone;
        
        NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:friends.userName withHanyuPinyinOutputFormat:formatter withNSString:@""];
        [tempDic setObject:friends forKey:[[outputPinyin substringToIndex:1] uppercaseString]];
    }
    
    self.lettersArray = tempDic.allKeys;
    
    for (NSString *letter in self.lettersArray) {
        NSMutableArray *tempArry = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i<self.friendDataSource.count; i++) {
            FriendModel *friends = self.friendDataSource[i];
            HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
            formatter.caseType = CaseTypeUppercase;
            formatter.vCharType = VCharTypeWithV;
            formatter.toneType = ToneTypeWithoutTone;
            
            
            NSString *outputPinyin = [PinyinHelper toHanyuPinyinStringWithNSString:friends.userName withHanyuPinyinOutputFormat:formatter withNSString:@""];
            if ([letter isEqualToString:[[outputPinyin substringToIndex:1] uppercaseString]]) {
                [tempArry addObject:friends];
                
            }
            
        }
        [self.nameDic setObject:tempArry forKey:letter];
    }
    
    self.lettersArray = tempDic.allKeys;
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 characterAtIndex:0] > [obj2 characterAtIndex:0]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    self.lettersArray = [[NSMutableArray alloc]initWithArray:[self.lettersArray sortedArrayUsingComparator:cmptr]];
}

#pragma mark - 创建UI界面
- (void)setUpMainView{
    // 1.friendTableView
    friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MGScreenW, self.view.height - MGNavHeight) style:UITableViewStylePlain];
    [friendTableView registerClass:[FriendCell class] forCellReuseIdentifier:KFriendCellIdentifier];
    friendTableView.delegate = self;
    friendTableView.dataSource = self;
    [self.view addSubview:friendTableView];
    friendTableView.tableFooterView = [UIView new];
    
    // 2.头部
    friendTableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == friendTableView) {
        return self.lettersArray.count;
    }else{
        return 1;
    }
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == friendTableView) {
        NSArray *nameArray = [self.nameDic objectForKey:self.lettersArray[section]];
        return nameArray.count;
    }else{
        return self.friendDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:KFriendCellIdentifier];
    
    if (tableView == friendTableView) {
            FriendModel *friendModel = [[self.nameDic objectForKey:[self.lettersArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
            cell.friendModel = friendModel;
    }else{
        NSString *userName = self.results[indexPath.row];
        FriendModel *friends = [[FriendModel alloc] init];
        for (NSInteger i = 0 ;i<self.friendDataSource.count; i++) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            
            if ([userName isEqualToString:friends.userName]) {
                [tempArray addObject:friends];
            }
            
            FriendModel *friendModel = [tempArray objectAtIndex:0];
            cell.friendModel = friendModel;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==friendTableView) {
        return 20.0;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.lettersArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == friendTableView) {
        NSInteger count = 0;
        for(NSString *letter in self.lettersArray)
        {
            if([letter isEqualToString:title])
            {
                return count;
            }
            count++;
        }
        return 0;
    }
    else{
        return 0;
    }
}

// 右边字母索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView==friendTableView) {
        return self.lettersArray;
        
    }else{
        return nil;
    }
}
#pragma mark
#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

}

// 文字改变的时候 搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.updateArray removeAllObjects];
    
    // 搜索文字为nil
    if (searchText.length == 0) return;
    
    
    if ([PinyinHelper isIncludeChineseInString:searchText]) { // 中文
        for(int i=0;i<self.friendDataSource.count;i++) {
            FriendModel *friends = self.friendDataSource[i];
            if ([friends.userName rangeOfString:searchText].location!=NSNotFound) {
                [self.updateArray addObject:friends];
            }
        }
    }else{ // 拼音
        for(int i=0; i<self.friendDataSource.count; i++) {
            HanyuPinyinOutputFormat *formatter =  [[HanyuPinyinOutputFormat alloc] init];
            formatter.caseType = CaseTypeUppercase;
            formatter.vCharType = VCharTypeWithV;
            formatter.toneType = ToneTypeWithoutTone;
            
            FriendModel *friends = self.friendDataSource[i];
            
            NSString *outputPinyin=[[PinyinHelper toHanyuPinyinStringWithNSString:friends.userName withHanyuPinyinOutputFormat:formatter withNSString:@""] lowercaseString];
            
            
            if ([[outputPinyin lowercaseString]rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
                [self.updateArray addObject:friends];
            }
        }
    }
    NSLog(@"%@",self.updateArray);
    [resultController updateAddressBookData:self.updateArray];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchController.searchBar.showsCancelButton = YES;
    UIButton *canceLBtn = [self.searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor colorWithRed:14.0/255.0 green:180.0/255.0 blue:0.0/255.0 alpha:1.00] forState:UIControlStateNormal];
//    [searchBar setShowsCancelButton:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}


@end
