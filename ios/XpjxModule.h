//
//  AlipayReactInterface.h
//  xpjx
//
//  Created by 岩  熊 on 2018/9/28.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>
@interface XpjxModule : RCTEventEmitter
+ (void)getSessionIdWithName:(NSString *)name andContent:(NSDictionary *)content;
+ (void)getPayResultsAndType:(NSString *)name andContent:(NSDictionary *)content;
@end
