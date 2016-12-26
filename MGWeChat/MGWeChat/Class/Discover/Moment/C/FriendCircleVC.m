//
//  FriendCircleVC.m
//  MGWeChat
//
//  Created by ming on 16/8/17.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleVC.h"
#import "MainNavVC.h"
#import "TZImagePickerController.h"
#import "PublicFriendCircleVC.h"


#import "FriendCircleHeaderView.h"
#import "FriendCircleCell.h"
#import "FriendCircleListViewModel.h"


@interface FriendCircleVC ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,FriendCircleCellDelegate>
{
    UITableView *friendCircleTableView;
//    SDTimeLineRefreshHeader *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    UITextField *_textField;
    CGFloat _totalKeybordHeight;
    NSIndexPath *_currentEditingIndexthPath;
}
/** 朋友圈头部 */
@property (nonatomic,weak) FriendCircleHeaderView *headerView;
@property (nonatomic, strong) FriendCircleListViewModel *statusListViewModel;
@end

@implementation FriendCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupNavBar];
    [self setupTableView];
    
    [self loadFriendCircleData];
    
    // 通知
    [self addNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadFriendCircleData];

}

#pragma mark - 私有方法UI
#pragma mark - 加载数据
- (void)loadFriendCircleData {
    [self.statusListViewModel loadMoreStatusWithCount:8 Completed:^(BOOL isSuccessed) {
        
    }];
    [friendCircleTableView reloadData];
}

#pragma mark - TableView
- (void)setupTableView {
    friendCircleTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [friendCircleTableView registerClass:[FriendCircleCell class] forCellReuseIdentifier:KFriendCircleCellIdentifier];
    friendCircleTableView.dataSource = self;
    friendCircleTableView.delegate = self;
    [self.view addSubview:friendCircleTableView];
    friendCircleTableView.rowHeight = 360;
//    friendCircleTableView.estimatedRowHeight = 300;
//    friendCircleTableView.rowHeight = UITableViewAutomaticDimension;
//    friendCircleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupHeadView];
}

#pragma mark - setupHeadView 头部
- (void)setupHeadView {
    weakSelf(self);
    FriendCircleHeaderView *headerView = [[FriendCircleHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.width, 230);
    [headerView setIconButtonClickHander:^{ // 头像点击
      
    }];
    self.headerView = headerView;
    friendCircleTableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.statusListViewModel.statusList.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:KFriendCircleCellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    
    FriendCircleViewModel *viewModel = self.statusListViewModel.statusList[indexPath.row];
    cell.viewModel = viewModel;
    
    return cell;
}



#pragma mark - rightBarButtonItemClick
- (void)setupNavBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)rightBarButtonItemClick {
    typeof(self) __weak weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"小视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takeVideo];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePictures];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakSelf takeAlbum];
    }];
    [alertController addAction:videoAction];
    [alertController addAction:photoAction];
    [alertController addAction:albumAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 小视频
- (void)takeVideo {
    MGPS(@"小视频");
}

#pragma mark - 拍照
- (void)takePictures {
#if TARGET_IPHONE_SIMULATOR // 模拟器
     MGPS(@"模拟器没有拍照功能，请使用真机试试");
#elif TARGET_OS_IPHONE // 真机
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ipc animated:YES completion:nil];
#endif
}

#pragma mark - 从手机相册选择
- (void)takeAlbum {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *) photos sourceAssets:(NSArray *)assets {
    MGLog(@"%@", photos);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PublicFriendCircleVC *vc = [[PublicFriendCircleVC alloc] initWithImages:photos];
        //        vc.delegate = self;
        [vc setSendButtonClickedBlock:^(NSString *text, NSArray *images) {
            MGLog(@"%@,%@",text,images);
        }];
        MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    });
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *) photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos {
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    PublicFriendCircleVC *vc = [[PublicFriendCircleVC alloc] initWithImages:@[image]];
    [vc setSendButtonClickedBlock:^(NSString *text, NSArray *images) {
        MGLog(@"%@,%@",text,images);
    }];
    MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 通知
// 键盘高度
static CGFloat textFieldH = 40;
- (void)addNotification {
    // 键盘通知
    [MGNotificationCenter addObserverForName:UIKeyboardWillChangeFrameNotification object:self queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *dict = note.userInfo;
        CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        
        CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            textFieldRect = rect;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            _textField.frame = textFieldRect;
        }];
        
        CGFloat h = rect.size.height + textFieldH;
        if (_totalKeybordHeight != h) {
            _totalKeybordHeight = h;
            [self adjustTableViewToFitKeyboard];
        }

    }];
}

- (void)adjustTableViewToFitKeyboard {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [friendCircleTableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = friendCircleTableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    [friendCircleTableView setContentOffset:offset animated:YES];
}


#pragma mark - FriendCircleCellDelegate
- (void)didClickLikeButtonInCell:(FriendCircleCell *)cell{
    MGPS(@"点赞👍");
}

- (void)didClickcCommentButtonInCell:(FriendCircleCell *)cell{
    MGPS(@"评论");
}


@end
