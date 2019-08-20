//
//  BaseHandler.m
//  AFNetworkIng
//
//  Created by 洪聪 on 15/12/8.
//  Copyright © 2015年 test. All rights reserved.
//

#import "BaseHandler.h"
#define ISAVAILABLE @"isAvailable"
#define JSON_AFTER_REGULATE @"json"
#define JSONResponseSerializerWithDataKey @"JSONResponseSerializerWithDataKey"
#define NO_MSG                            @"服务异常，请稍后重试！"
//接口签名的key,取前4+后4位
static NSString * const signKey = @"cefbacbdee0a4c3ebdd0596e20cec29d";
@implementation BaseHandler

+ (NSString *)requestUrlWithHttpPath:(NSString *)path
{
    NSString *serverUrl = nil;
    if(![serverUrl hasPrefix:@"http"]){
        serverUrl = nil;
    }
    if(!serverUrl){
//      serverUrl = @"http://192.168.1.103:9999";
      serverUrl = @"http://apiuser.dev.xpcto.com";
    }

    NSString *serverPath = [serverUrl stringByAppendingString:path];
    
    return [serverPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error complete:(FailedBlock)failed
{
    id json = error.userInfo[JSONResponseSerializerWithDataKey];
    if(!json){
        if (failed) {
            failed(404,NO_MSG);
        }
        return;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    id objJson = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if (failed) {
        if([NSJSONSerialization isValidJSONObject:objJson])
        {
            if([objJson isKindOfClass:[NSDictionary class]]){
                
                if([objJson objectForKey:@"code"]){
                    NSInteger code = [[objJson objectForKey:@"code"] integerValue];
                    NSString* msg = [objJson objectForKey:@"msg"];
                    
                    //临时处理
//                    if(code == CODE_LOGON_FAILURE){
//                        //发出登录信息失效的通知
//                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LOGON_FAILURE object:nil];
//                    }
//
                    failed(code,msg);
                    
                    return;
                }
            }
            
            failed(404,NO_MSG);
        }else{
            failed(404,NO_MSG);
        }
    }
}

+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task data:(id)responseObject complete:(FailedBlock)failed
{
    if(failed){
        if(responseObject != nil){
            if([responseObject isKindOfClass:[NSDictionary class]]){
                if([responseObject objectForKey:@"code"]){
                    NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
                    NSString* msg = [responseObject objectForKey:@"msg"];
                    //临时处理
//                    if(code == CODE_LOGON_FAILURE){
//                        //发出登录信息失效的通知
//                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LOGON_FAILURE object:nil];
//                    }
                    failed(code,msg);
                    return;
                }
            }
        }
        failed(404,NO_MSG);
    }else{
        failed(404,NO_MSG);
    }
}

+ (NSInteger)statusCodeWithTask:(NSURLSessionDataTask *)task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    return statusCode;
}

+ (NSDictionary *)objectsByRegulateJSON:(id)json
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    
    //格式化打印输出至控制台
    //NSString *responseJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    id jsonAfterRegulate = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    BOOL jsonIsAvailable = [NSJSONSerialization isValidJSONObject:jsonAfterRegulate];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:jsonAfterRegulate,JSON_AFTER_REGULATE,[NSNumber numberWithBool:jsonIsAvailable],ISAVAILABLE, nil];
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
           return YES;
    }
    return NO;
}

+ (NSMutableDictionary*)getAuthParameters {
  NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
  [paramsDic setObject:@"" forKey:@"session_id"];
  [paramsDic setObject:@"" forKey:@"appversion"];
  [paramsDic setObject:[NSString stringWithFormat:@"ios_c_%@",@""] forKey:@"fr"];
  
//  //优先从钥匙串中获取 deviceId
//  NSString* udidString = [SAMKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:@"deviceid"];
//  if(udidString == nil || [udidString isEqualToString:@""]){
//    
//    //未获取到就取 udid ,然后存入钥匙串
//    udidString = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    //BASE64加密
//    NSData *originData = [udidString dataUsingEncoding:NSASCIIStringEncoding];
//    udidString = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    [SAMKeychain setPassword:udidString forService:[NSBundle mainBundle].bundleIdentifier account:@"deviceid"];
//    
//  }
  [paramsDic setObject:@"ddddddd" forKey:@"deviceid"];
  
  //    NSInteger cityCode =  [GlobalInfo sharedInstance].curCityData.code;
  //    [paramsDic setObject:[NSNumber numberWithInteger:cityCode] forKey:@"cityCode"];
  [paramsDic setObject:@"340" forKey:@"cityCode"];
  [paramsDic setObject:@"uid" forKey:@"uniqueId"];
  [paramsDic setObject:@"dekey" forKey:@"dvkey"];
  
  [paramsDic setObject:@"idfa" forKey:@"idfa"];
  // 保证接口安全性，添加sign签名，作为公共参数
  NSString *sessionId = [paramsDic valueForKey:@"session_id"];
  NSString *deviceid = [paramsDic valueForKey:@"deviceid"];
  NSString *fr = [paramsDic valueForKey:@"fr"];
  NSString *uniqueId = [paramsDic valueForKey:@"uniqueId"];
  NSString *timestamp =  @"11111";
  NSString *signKeyStr = [NSString stringWithFormat:@"%@%@",[signKey substringToIndex:4],[signKey substringFromIndex:28]];
  NSString *signStr = [NSString stringWithFormat:@"session_id=%@&deviceid=%@&fr=%@&uniqueId=%@&timestamp=%@&%@",sessionId,deviceid,fr,uniqueId,timestamp,signKeyStr];
  //对signStr做md5加密
//  NSString *signKeyMd5 = [NSString md5:signStr];
  [paramsDic setObject:@"sign" forKey:@"sign"];
  [paramsDic setObject:timestamp forKey:@"timestamp"];
  return paramsDic;
}

+ (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
                prepare:(void(^)(void))prepare
                success:(SuccessBlock) success
                failure:(FailedBlock) failed
{
    NSLog(@"🌍🌍🌍请求接口:%@",url);
    if(method == RTHttpRequestGet || method == RTHttpRequestPost){
        NSMutableDictionary *paramsDic = [self getAuthParameters];
        if(parameters){
            [paramsDic addEntriesFromDictionary:parameters];
        }
        parameters = paramsDic;
    }
    NSLog(@"请求参数:%@",parameters);
    [[HCHttpClient defaultClient] requestWithPath:url method:method parameters:parameters prepare:prepare
                                          success:^(NSURLSessionDataTask *task, id responseObject) {
                                              if(responseObject != nil){
                                                  if([responseObject isKindOfClass:[NSDictionary class]]){
                                                      if([responseObject objectForKey:@"code"]){
                                                          NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
                                                          if(code == 0){
                                                             NSLog(@"🌍🌍🌍%@返回数据:\n%@",url,responseObject);
                                                              success(responseObject);
                                                              return;
                                                          }
                                                      }else{
                                                          success(responseObject);
                                                          return;
                                                      }
                                                  }
                                              }
                                              
                                              [self handlerErrorWithTask:task data:responseObject complete:failed];
                                              NSLog(@"🌍🌍🌍%@\n错误信息:%@",url,responseObject);
                                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              NSLog(@"🌍🌍🌍%@\n错误信息:%@",url,error.localizedDescription);
                                              [self handlerErrorWithTask:task error:error complete:failed];
                                          }];
}

+ (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
               progress:(ProgressBlock)progress
             resumeData:(NSData *)resumeData
          constructBody:(ConstructBodyBlock)constructBody
            destination:(DestinationBlock)destination
      completionHandler:(CompletionHandlerBlock)completionHandler
                prepare:(PrepareBlock)prepare
                success:(SuccessBlock)success
                failure:(FailedBlock)failed{
    if(method == RTHttpFileOperationTypeUpload){
        //拼接必备参数
        NSMutableDictionary *paramsDic = [self getAuthParameters];
        if(parameters){
            [paramsDic addEntriesFromDictionary:parameters];
        }
        parameters = paramsDic;
    }
    
    [[HCHttpClient defaultClient] requestWithPath:url method:method parameters:parameters progress:progress resumeData:resumeData constructBody:constructBody destination:destination completionHandler:completionHandler prepare:prepare success:^(NSURLSessionDataTask *task, id responseObject) {
        if(responseObject != nil){
            //上传方法返回数据需要JSON解析
            if(![responseObject isKindOfClass:[NSDictionary class]]){
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            }
            else{
                if([responseObject objectForKey:@"code"]){
                    NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
                    if(code == 0){
                        success(responseObject);
                        return;
                    }
                }else{
                    success(responseObject);
                    return;
                }
            }
        }
        
        [self handlerErrorWithTask:task data:responseObject complete:failed];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self handlerErrorWithTask:task error:error complete:failed];
    }];
    
}




@end
