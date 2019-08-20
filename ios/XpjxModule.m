//
//  AlipayReactInterface.m
//  xpjx
//
//  Created by 岩  熊 on 2018/9/28.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "XpjxModule.h"

#define WeakSelf __weak typeof(self) weakSelf = self;


static  NSString* const RCTTypeLookBigPic = @"lookBigPic";

@interface XpjxModule()<RCTBridgeModule,UIActionSheetDelegate>

@end

@implementation XpjxModule
RCT_EXPORT_MODULE()
//RCT_EXPORT_METHOD(initSchemeToJS:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
//
//}

RCT_EXPORT_METHOD(handleMessage:(NSDictionary *)msg resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  dispatch_async(dispatch_get_main_queue(), ^{
    NSString *RCTTypeString = [msg objectForKey:@"type"];
    NSString *dataString = [msg objectForKey:@"data"];
    if ([RCTTypeString isEqualToString:RCTTypeLookBigPic]){
      
      NSDictionary *BigPic =  [msg objectForKey:@"productImage"];
      NSString *index = [NSString stringWithFormat:@"%@",[BigPic objectForKey:@"index"]];
      NSArray *picArray = [BigPic objectForKey:@"path"];
      
    }
  });
  
}


+ (id)allocWithZone:(struct _NSZone *)zone {
  static XpjxModule *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
    [defaultCenter addObserver:self
                      selector:@selector(sendCustomEvent:)
                          name:@"sendCustomEventNotification"
                        object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payStatusAndType:) name:@"getPayResultsNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSessionId:) name:@"getSessionIdNotification" object:nil];
  }
  return self;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"schemeListener",@"getSessionIdEvent",@"getPayResultsEvent"];
}
-(void)startObserving {
    //在此处偶现通知发送不出去的问题
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSessionId:) name:@"getSessionIdNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payStatusAndType:) name:@"getPayResultsNotification" object:nil];
}
-(void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//传sessionId给RN
- (void)getSessionId:(NSNotification *)notification {
    [self sendEventWithName:@"getSessionIdEvent" body:notification.userInfo];
}
//发送支付结果给RN
- (void)payStatusAndType:(NSNotification *)notification {
    [self sendEventWithName:@"getPayResultsEvent" body:notification.userInfo];
}

+ (void)getSessionIdWithName:(NSString *)name andContent:(NSDictionary *)content {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:content];
}
//支付结果
+ (void)getPayResultsAndType:(NSString *)name andContent:(NSDictionary *)content {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:content];
}
/// 接收通知的方法，接收到通知后发送事件到RN端。RN端接收到事件后可以进行相应的逻辑处理或界面跳转
- (void)sendCustomEvent:(NSNotification *)notification {
  
  [self sendEventWithName:@"schemeListener" body:notification.object];
}

@end