
//  LYMGuideTool.m
//  MGLoveFreshBeen
//
//  Created by ming on 15/10/28.
//  Copyright (c) 2014年 ming. All rights reserved.
//

#import "LYMGuideTool.h"
#import "MineLoginVC.h"
#import "MainTabBarVC.h"
#import "LYMSaveTool.h"
#import "MGUserAccountTool.h"

#define LYMversionKey @"version"


@implementation LYMGuideTool

/**
 *  选择窗口根控制器
 *
 *  @return 要返回的控制器
 */
+ (UIViewController *)chooseRootViewController
{
    /// 没有登录
    if ([[MGUserAccountTool shareInstance] isUserLogin] == NO) {
        // 进入登录控制器
        MineLoginVC *loginVC = [UIStoryboard storyboardWithName:@"Login" bundle:nil].instantiateInitialViewController;
        return loginVC;
    }else
    {
        // 进入新界面控制器
        MainTabBarVC *tabBarVC = [[MainTabBarVC alloc] init];
        
        return tabBarVC;
    }
}

@end

/// 第一种方式取得版本号
/*
 
 //    NSString *path = [[NSBundle mainBundle] pathForResource:@"info.plist" ofType:nil];
 //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
 //    NSLog(@"--%@",dict);
 
 // 获取当前版本号
 //    NSString *currentVersion = dict[@"CFBundleShortVersionString"];
 */

//    UIViewController *vc = nil;

