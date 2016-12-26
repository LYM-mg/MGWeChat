//
//  AppDelegate.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarVC.h"
#import "LYMGuideTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "UMSocial.h" 
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 3DTouch
    [self setup3DTouch:application];
    
    // 友盟分享
    [self setupUMSocial];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    CATransition *transiction = [CATransition animation];
    transiction.type = @"rippleEffect";
    transiction.duration = 3.5;
    
    [self.window.layer addAnimation:transiction forKey:nil];
    
    self.window.rootViewController = [LYMGuideTool chooseRootViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 3DTouch
- (void)setup3DTouch:(UIApplication *)application{
    if (IOS9) {
        // 创建标签的ICON图标。
        UIApplicationShortcutIcon *firstItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
        // 创建一个标签，并配置相关属性。
        UIMutableApplicationShortcutItem *firstItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"First" localizedTitle:@"添加" localizedSubtitle:nil icon:firstItemIcon userInfo:nil];
        UIApplicationShortcutIcon *secondItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        UIMutableApplicationShortcutItem *secondItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"Second" localizedTitle:@"分享" localizedSubtitle:nil icon:secondItemIcon userInfo:nil];
        
        // 自定义创建标签的ICON图标。
        UIApplicationShortcutIcon *thirdItemIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@""];
        UIMutableApplicationShortcutItem *thirdItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"Third" localizedTitle:@"自定义" localizedSubtitle:nil icon:thirdItemIcon userInfo:nil];
        application.shortcutItems = @[firstItem,secondItem,thirdItem];
    }
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqual:@"add"])
    { MGPS(@"执行添加事件"); }
    else if([shortcutItem.type isEqual:@"share"])
    { MGPS(@"执行分享的操作 ");}
}

#pragma mark - 友盟分享
- (void)setupUMSocial{
    /// MOB
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"1634a9175f0b0"
             withSecret:@"343c2ce5b24e7087ad77874ce026c564"];
    
    /// 友盟
    //设置友盟社会化组件appkey
    //    [UMSocialData setAppKey:@"57b4941267e58e197c000884"];
    
    
    
    // 短信验证，appKey和appSecret从后台申请得
//    [SMSSDK registerApp:@"1611c80d9edc0"
//             withSecret:@"ed8256cf1d354ca20772486ee2f2016b"];
    
    // 设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57b4941267e58e197c000884"];
    
    // 打开调试log的开关
    [UMSocialData openLog:NO];
    
    // 如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    // 设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxceb8ec0a6d9dc22a" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3741778105"
                                              secret:@"f1a443691c88263068c4a33eb37fde1b"
                                         RedirectURL:@"https://github.com/LYM-mg"];
    
    // 设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    // 设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
}


/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UMSocialSnsService applicationDidBecomeActive];
}

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    // 其他平台 UMShareToTencent,UMShareToRenren,UMShareToDouban,
    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite, nil];
    
    //这里你可以把分享平台UMShareToSina换成其他平台
    [[UMSocialDataService defaultDataService] postSNSWithTypes:arr content:@"ming" image:nil location:nil urlResource:nil presentedController:self.window.rootViewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抱歉" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
