//
//  MainNavVC.m
//  MGWeChat
//
//  Created by ming on 16/8/16.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MainNavVC.h"

@interface MainNavVC ()<UIGestureRecognizerDelegate,UIGestureRecognizerDelegate>

@end

@implementation MainNavVC


+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
//
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:att];
//
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [appearance setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:itemAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    [appearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark ========= 添加全屏滑动手势 ==========
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setp1:需要获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // setp2:创建全屏滑动手势~调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // step3:设置手势代理~拦截手势触发
    pan.delegate = self;
    
    // step4:别忘了~给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // step5:将系统自带的滑动手势禁用
    self.interactivePopGestureRecognizer.enabled = NO;
}

// steo6:还记得刚刚设置的代理吗？下面方法什么时候调用？在每次触发手势之前都会询问下代理，是否触发。
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
}
/** 判断是否为根控制器 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 只要不等于1就返回YES，说明此时具有滑动功能
    return self.childViewControllers.count != 1;
}

#pragma mark ========= 拦截控制器的push操作 ==========
/**
 *   拦截控制器的push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count != 0) {
        // 判断当前控制器是否为根控制器，如果不是，就执行下列代码 backBtn.setImage(UIImage(named: "v2_goback"), forState: .Normal)
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
        [viewController.navigationItem setLeftBarButtonItem:leftItem animated:YES];
        
        // 隐藏下面的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }else{
        viewController.hidesBottomBarWhenPushed = NO;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

// 监听按钮的点击
- (void)leftBtnClick{
    [self popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)test{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    //        [leftBtn setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
    [leftBtn sizeToFit];
    /** 想让 导航栏的左按钮向左偏一点的方法 */
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
    /** 想让按钮的内容水平居左 */
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;  /** 想让按钮的内容水平居左 */
//     [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
//    leftItem.width = -5;
}
@end
