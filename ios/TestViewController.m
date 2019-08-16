//
//  TestViewController.m
//  AwesomeProject
//
//  Created by tbb_mbp13 on 2019/8/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "TestViewController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "MobileApiHandler.h"
#import "OneEntity.h"
#import "PhoneEntity.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
//                                                   moduleName:@"AwesomeProject"
//                                            initialProperties:nil];
//  
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//  self.view = rootView;
  [MobileApiHandler requestWithPath1:path1 prepare:nil success:^(OneEntity *entity) {
    NSArray *phoneArr = [NSArray array];
    PhoneEntity *computerEntity = [[PhoneEntity alloc] init];
    computerEntity = entity.computer;
    phoneArr = entity.phone;
    PhoneEntity *phoneEntity = phoneArr[0];
    NSLog(@"请求回来的computer数据%@",computerEntity);
    NSLog(@"请求回来的phone数据%@",phoneEntity);
    NSLog(@"请求回来的phoneArr数据%@",phoneArr);
    NSLog(@"请求回来的sex数据%ld",(long)entity.sex);
    
  } failed:^(NSInteger statusCode, NSString *msg) {
    NSLog(@"请求数据失败******%@",msg);
  }];
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}



@end
