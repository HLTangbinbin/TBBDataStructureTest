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
#import "XpjxModule.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"AwesomeProject"
                                            initialProperties:nil];
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  self.view = rootView;
//  [self requestWithPath1];
//  [self requestWithPath2];
//  [self requestWithPath3];
//  [self requestWithPath4];
//  [self requestWithPath5];
//  [self requestWithPath6];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSDictionary *dict = @{@"sessionId":@"aaaaa",@"type":[NSNumber numberWithBool:YES],@"page":[NSNumber numberWithInteger:32],@"money":[NSNumber numberWithDouble:12.34]};
    [XpjxModule getSessionIdWithName:@"getSessionIdNotification" andContent:dict];
  });
}

- (void)requestWithPath1 {
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
- (void)requestWithPath2 {
  [MobileApiHandler requestWithPath2:path2 prepare:nil success:^(NSArray *oneEntitys) {
    OneEntity *oneEntity = oneEntitys.firstObject;
    PhoneEntity *computerEntity = oneEntity.computer;
    NSArray *phoneArr = oneEntity.phone;
    PhoneEntity *phoneEntity = phoneArr[0];
    NSLog(@"请求回来的dataArr数据%@",oneEntitys);
    NSLog(@"请求回来的oneEntity数据%@",oneEntity);
    NSLog(@"请求回来的computer数据%@",computerEntity);
    NSLog(@"请求回来的phoneArr数据%@",phoneArr);
    NSLog(@"请求回来的phoneEntity数据%@",phoneEntity);
    NSLog(@"请求回来的sex数据%ld",(long)oneEntity.sex);
    
  } failed:^(NSInteger statusCode, NSString *msg) {
    NSLog(@"请求数据失败******%@",msg);
  }];
}

- (void)requestWithPath3 {
  [MobileApiHandler requestWithPath3:path3 prepare:nil success:^(NSArray *oneEntitys) {
    OneEntity *oneEntity = oneEntitys.firstObject;
    PhoneEntity *computerEntity = oneEntity.computer;
    NSArray *phoneArr = oneEntity.phone;
    PhoneEntity *phoneEntity = phoneArr[0];
    NSLog(@"请求回来的dataArr数据%@",oneEntitys);
    NSLog(@"请求回来的oneEntity数据%@",oneEntity);
    NSLog(@"请求回来的computer数据%@",computerEntity);
    NSLog(@"请求回来的phoneArr数据%@",phoneArr);
    NSLog(@"请求回来的phoneEntity数据%@",phoneEntity);
    NSLog(@"请求回来的sex数据%ld",(long)oneEntity.sex);
    
  } failed:^(NSInteger statusCode, NSString *msg) {
    NSLog(@"请求数据失败******%@",msg);
  }];
}

- (void)requestWithPath4 {
  [MobileApiHandler requestWithPath4:path4 prepare:nil success:^(id responseObject) {
    NSLog(@"请求回来的数据%@",[responseObject objectForKey:@"data"]);
    
  } failed:^(NSInteger statusCode, NSString *msg) {
    NSLog(@"请求数据失败******%@",msg);
  }];
}

- (void)requestWithPath5 {
  [MobileApiHandler requestWithPath5:path5 prepare:nil success:^(id responseObject) {
    NSLog(@"请求回来的data%@",[responseObject objectForKey:@"data"]);
    
  } failed:^(NSInteger statusCode, NSString *msg) {
    NSLog(@"请求数据失败******%@",msg);
  }];
}

- (void)requestWithPath6 {
  [MobileApiHandler requestWithPath6:path6 prepare:nil success:^(id responseObject) {
    NSLog(@"请求回来的data%@",[responseObject objectForKey:@"data"]);
    
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
