//
//  AppDelegate.m
//  Interpret
//
//  Created by 乔杰 on 2018/1/30.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "AppDelegate.h"

#import "HomeViewController.h"
#import "MeViewController.h"

#import "IQKeyboardManager.h"

@interface AppDelegate ()

@property (nonatomic, strong) RDVTabBarController *tabBarController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   
    [IQKeyboardManager sharedManager].enable = YES;
    
    [self showRootViewController];
    
    [self customizeInterface];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

    
    
}


#pragma mark - 设置视图控制器
- (void)showRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = White_color;
    
    if (![[LoginUser sharedLoginUser] userIsLogin]) {
        
        [self setUpViewControllers];
    }else {
        
        LoginViewController *vc = [[LoginViewController alloc] init];
        
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: vc];
    }
    
    [self.window makeKeyAndVisible];
    
}


//设置TabBar
- (void)setUpViewControllers {
    
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController: home];
    
    MeViewController *me = [[MeViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController: me];
    
    self.tabBarController = [[RDVTabBarController alloc] init];
    
    self.window.rootViewController  = self.tabBarController;
    
    [self.tabBarController setViewControllers:@[
                                                nav1,
                                                nav2,
                                                ]];
    RDVTabBar *tabBar = [self.tabBarController tabBar];
    [tabBar setHeight: TabBar_Height];
    tabBar.translucent = YES;
    [self customizeTabBarForController:self.tabBarController];
}

//设置tabBar标签栏
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    UIImage *finishedImage = [ImageHelper imageWithColor: Navigation_bar_tint_color];
    UIImage *unfinishedImage = [ImageHelper imageWithColor: Navigation_bar_tint_color];
    NSArray *tabBarItemImages =
    @[ @"tabBar_1", @"tabBar_2"];
    NSArray *tabBarItemTitles = @[@"首页", @"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        [item setBackgroundSelectedImage: finishedImage
                     withUnselectedImage: unfinishedImage];
        //设置tabBar标签栏中各item的的选中图片和未选中图片
        UIImage *selectedimage = [UIImage
                                  imageNamed:[NSString stringWithFormat:@"%@_hilight",
                                              [tabBarItemImages
                                               objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage
                                    imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                [tabBarItemImages
                                                 objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage
           withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        //设置标签栏标题的选中颜色和未选中时的颜色
        NSDictionary *unSeletedTittleAttributes = nil;
        unSeletedTittleAttributes = @{
                                      NSFontAttributeName : [UIFont boldSystemFontOfSize:12],
                                      NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                      };
        
        [item setUnselectedTitleAttributes:unSeletedTittleAttributes];
        
        NSDictionary *seletedTittleAttributes = nil;
        
        seletedTittleAttributes = @{
                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:12],
                                    NSForegroundColorAttributeName : Main_color
                                    };
        [item setSelectedTitleAttributes:seletedTittleAttributes];
        index++;
    }
}

- (void)customizeInterface {
    
    //设置导航器的通用背景显示（背景颜色、文本大小、字体、颜色）
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    backgroundImage = [ImageHelper imageWithColor: Navigation_bar_tint_color];
    
    textAttributes = @{
                       NSFontAttributeName : [UIFont systemFontOfSize:18],
                       NSForegroundColorAttributeName : Navigation_bar_title_color,
                       };
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setTintColor: Navigation_bar_tint_color];
    //隐藏导航栏底部线条
    [navigationBarAppearance setShadowImage:[UIImage new]];
}

#pragma mark - 第三方平台配置



@end
