//
//  FriendSearchResultVC.h
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultSelectedDelegate <NSObject>

-(void)selectPersonWithUserId:(NSString *)userId userName:(NSString *)userName photo:(NSString *)photo phoneNO:(NSString *)phoneNO;

@end


@interface FriendSearchResultVC : UIViewController<UISearchResultsUpdating>

-(void)updateAddressBookData:(NSArray *)AddressBookDataArray;//得到数据

@property(nonatomic,weak)id<SearchResultSelectedDelegate>delegate;

@end
