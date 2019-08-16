//
//  MobileApiHandler.m
//  BlueRhino
//
//  Created by 洪聪 on 16/2/22.
//  Copyright © 2016年 BlueRhino. All rights reserved.
//

#import "MobileApiHandler.h"
#import "OneEntity.h"



@implementation MobileApiHandler

+ (void)requestWithPath1:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
    NSString *str_url = [self requestUrlWithHttpPath:path];
    [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
        OneEntity* entity = [OneEntity parseObjectWithKeyValues:responseObject[@"data"]];
        success(entity);
    } failure:failed];
    
}

+ (void)requestWithPath2:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
  NSString *str_url = [self requestUrlWithHttpPath:path];
  [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
    success(responseObject);
  } failure:failed];
  
}

+ (void)requestWithPath3:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
  NSString *str_url = [self requestUrlWithHttpPath:path];
  [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
    success(responseObject);
  } failure:failed];
  
}

+ (void)requestWithPath4:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
  NSString *str_url = [self requestUrlWithHttpPath:path];
  [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
    success(responseObject);
  } failure:failed];
  
}

+ (void)requestWithPath5:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
  NSString *str_url = [self requestUrlWithHttpPath:path];
  [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
    success(responseObject);
  } failure:failed];
  
}

+ (void)requestWithPath6:(NSString *)path prepare:(PrepareBlock)prepare success:(SuccessBlock)success failed:(FailedBlock)failed
{
  NSString *str_url = [self requestUrlWithHttpPath:path];
  [BaseHandler requestWithPath:str_url method:RTHttpRequestPost parameters:nil prepare:prepare success:^(id responseObject) {
    success(responseObject);
  } failure:failed];
  
}


@end
