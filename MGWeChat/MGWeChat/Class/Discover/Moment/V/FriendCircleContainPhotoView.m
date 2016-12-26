//
//  FriendCircleContainPhotoView.m
//  MGWeChat
//
//  Created by ming on 16/8/19.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "FriendCircleContainPhotoView.h"
#import "FriendCircleViewModel.h"

@interface FriendCircleContainPhotoView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionViewFlowLayout *layout;
}
@end

@implementation FriendCircleContainPhotoView

#pragma mark - 系统方法

- (instancetype)initWithFrame:(CGRect)frame {
    layout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.dataSource = self;
        self.backgroundColor = [UIColor lightGrayColor];
        [self  registerClass:[MGPictureCell class] forCellWithReuseIdentifier:MGPictureCellIdentifier];
    }
    return self;
}


- (void)setFriendCircleViewModel:(FriendCircleViewModel *)friendCircleViewModel{
    self.friendCircleViewModel = friendCircleViewModel;
    
    // 计算配图
    CGSize size = [self caclateFriendCircleContainPhotoView:friendCircleViewModel];
    
    // 计算尺寸
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

/**
 0.没有图片，返回zero
 1.单张图片，返回图片实际大小
 2.多张图片，图片大小固定
 2.1四张图片，会按照田字格实现
 2.2其他图片，按照九宫格显示
 */
/**
 计算配图尺寸
 -paramater status: 数据模型
 */
- (CGSize)caclateFriendCircleContainPhotoView:(FriendCircleViewModel *)viewModel {
    // 1.安全校验
    NSArray *pictures = viewModel.picNamesArray;
    if (pictures) {
        return CGSizeZero;
    }
    
    // 2.取出配图个数
    NSInteger count = pictures.count;
    
    // 3.判断配图个数
    // 3.1没有配图
    if (count == 0) {
        return CGSizeZero;
    }
    // 3.2单张配图
    if (count == 1) {
        NSURL *url = [NSURL URLWithString:[pictures firstObject]];
        UIImage *image = [[[SDWebImageManager sharedManager] imageCache]imageFromDiskCacheForKey:url];
        CGFloat width= image.size.width * 2.5;
        CGFloat height = image.size.height * 2.5;
        layout.itemSize = CGSizeMake(width, height);
        return layout.itemSize;
    }
    
    CGFloat itemWidth = 90;
    CGFloat itemHeight = itemWidth;
    CGFloat margin = MGMargin;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    // 3.3四张配图
    if (count == 4) {
        NSInteger col = 2;
        NSInteger row = col;
        
        CGFloat width = col * itemWidth + (col - 1) * margin;
        CGFloat height = row * itemHeight + (row - 1) * margin;
        return CGSizeMake(width, height);
    }
    // 3.4多张配图
    NSInteger col = 3;
    NSInteger row = (count - 1)/col + 1;
    // 宽度 = 列数 * 宽度 + (列数 - 1) * 宽度
    CGFloat width = col * itemWidth + (col - 1) * margin;
    // 高度 = 行数 * 高度 + (行数 - 1) * 高度
    CGFloat height = row * itemHeight + (row - 1) * margin;
    return CGSizeMake(width, height);
}


- (void)setPictureArr:(NSArray *)pictureArr{
    _pictureArr = pictureArr;
    
    // 计算配图
    CGSize size = [self caclateFriendCircleContainPhotoViews:pictureArr];
    
    // 计算尺寸
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

/**
 0.没有图片，返回zero
 1.单张图片，返回图片实际大小
 2.多张图片，图片大小固定
 2.1四张图片，会按照田字格实现
 2.2其他图片，按照九宫格显示
 */
/**
 计算配图尺寸
 -paramater status: 数据模型
 */
- (CGSize)caclateFriendCircleContainPhotoViews:(NSArray *)arr {
    // 1.安全校验
    NSArray *pictures = arr;
    if (pictures==nil) {
        return CGSizeZero;
    }
    
    // 2.取出配图个数
    NSInteger count = pictures.count;
    
    // 3.判断配图个数
    // 3.1没有配图
    if (count == 0) {
        return CGSizeZero;
    }
    // 3.2单张配图
    if (count == 1) {
        NSURL *url = [NSURL URLWithString:[pictures firstObject]];
        UIImage *image = [[[SDWebImageManager sharedManager] imageCache]imageFromDiskCacheForKey:url];
        CGFloat width= image.size.width * 2.5;
        CGFloat height = image.size.height * 2.5;
        layout.itemSize = CGSizeMake(width, height);
        return layout.itemSize;
    }
    
    CGFloat itemWidth = 90;
    CGFloat itemHeight = itemWidth;
    CGFloat margin = MGMargin;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    // 3.3四张配图
    if (count == 4) {
        NSInteger col = 2;
        NSInteger row = col;
        
        CGFloat width = col * itemWidth + (col - 1) * margin;
        CGFloat height = row * itemHeight + (row - 1) * margin;
        return CGSizeMake(width, height);
    }
    // 3.4多张配图
    NSInteger col = 3;
    NSInteger row = (count - 1)/col + 1;
    // 宽度 = 列数 * 宽度 + (列数 - 1) * 宽度
    CGFloat width = col * itemWidth + (col - 1) * margin;
    // 高度 = 行数 * 高度 + (行数 - 1) * 高度
    CGFloat height = row * itemHeight + (row - 1) * margin;
    return CGSizeMake(width, height);
}


#pragma mark - UICollectionViewDataSource 数据源
static NSString *const MGPictureCellIdentifier = @"MGPictureCellIdentifier";
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictureArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGPictureCellIdentifier forIndexPath:indexPath];
    cell.imageURL = self.pictureArr[indexPath.item];
    return cell;

}
@end


#pragma mark -
#pragma mark - MGPictureCell
@implementation MGPictureCell
- (UIImageView *)peituView{
    if (_peituView == nil) {
        _peituView = [[UIImageView alloc] init];
        _peituView.contentMode = UIViewContentModeScaleAspectFill;
        _peituView.clipsToBounds = YES;
    }
    return _peituView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.peituView];
        [self.peituView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setImageURL:(NSURL *)imageURL{
    _imageURL = imageURL;
    [self.peituView sd_setImageWithURL:imageURL];
}
    
@end
