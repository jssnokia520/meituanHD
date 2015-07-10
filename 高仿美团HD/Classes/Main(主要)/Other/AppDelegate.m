//
//  AppDelegate.m
//  高仿美团HD
//
//  Created by JiShangsong on 15/7/10.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "AppDelegate.h"
#import "JSSHomeController.h"
#import "JSSNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JSSNavigationController *navigationVc = [[JSSNavigationController alloc] initWithRootViewController:[[JSSHomeController alloc] init]];
    [self.window setRootViewController:navigationVc];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
