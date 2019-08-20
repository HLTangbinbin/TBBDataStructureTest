//
//  MobileApiHandler.h
//  BlueRhino
//
//  Created by 洪聪 on 16/2/22.
//  Copyright © 2016年 BlueRhino. All rights reserved.
//

#import "BaseHandler.h"

#define path1  @"/index/index/singlePerson"
#define path2  @"/index/index/manyPerson"
#define path3  @"/index/index/emptyArray"
#define path4  @"/index/index/emptyString"
#define path5  @"/index/index/nullData"
#define path6  @"/index/index/emptyData"


@interface MobileApiHandler : BaseHandler

+ (void)requestWithPath1:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)requestWithPath2:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)requestWithPath3:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)requestWithPath4:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)requestWithPath5:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
+ (void)requestWithPath6:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
