//
//  MainTabBarVC.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MainTabBarVC.h"
#import "MainNavVC.h"

#import "WXHomeController.h"
#import "WXContactController.h"
#import "WXDiscoverController.h"
#import "WXMeController.h"

@interface MainTabBarVC ()


@end

@implementation MainTabBarVC


#pragma mark - initialize
+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:[[WXHomeController alloc] init] title:@"微信" imageName:@"tabbar_mainframe"];
    [self addChildViewController:[[WXContactController alloc] init] title:@"通讯录" imageName:@"tabbar_contacts"];
    [self addChildViewController:[[WXDiscoverController alloc] init] title:@"发现" imageName:@"tabbar_discover"];
    [self addChildViewController:[[WXMeController alloc] init] title:@"我" imageName:@"tabbar_me"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 创建子控制器
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    
    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSString *selectedImageName = [NSString stringWithFormat:@"%@HL", imageName];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectedImage;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = MGRGBColor(14, 180 , 0);
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}



@end
