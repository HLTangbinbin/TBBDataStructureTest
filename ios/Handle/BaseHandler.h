//
//  BaseHandler.h
//  AFNetworkIng
//
//  Created by 洪聪 on 15/12/8.
//  Copyright © 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCHttpClient.h"

// 请求返回出错的时候传入
#define CompleteBlockErrorCode  -1


@interface BaseHandler : NSObject
/**
 *  Handler处理完成后调用的Block
 *  count 表示返回的数据数量
 */
typedef void (^CompleteBlock)(NSInteger count);

/**
 *  请求开始前预处理Block
 */
typedef void(^PrepareBlock)(void);

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id responseObject);

typedef void (^SuccessBlockAndNumber)(id responseObject,NSInteger number);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(NSInteger statusCode, NSString* msg);

/**
 *  进度Block
 */
typedef void (^ProgressBlock)(NSProgress *);

/**
 *  结构化数据Block
 */
typedef void (^ConstructBodyBlock)(id<AFMultipartFormData>);

/**
 *  DestinationBlock
 */
typedef NSURL * (^DestinationBlock)(NSURL *,NSURLResponse *);

/**
 *  完成回调Block
 */
typedef void (^CompletionHandlerBlock)(NSURLResponse *,NSURL *,NSError *);
//completionHandler:(void (^)(NSURLResponse *,NSURL *,NSError *))completionHandler

/**
 *  上传文件处理成功时调用的Block
 */
typedef void (^FileOperationSuccessBlock)(NSURLSessionDataTask * task,id responseObject);


/**
 *  获取请求URL
 *
 *  @param path
 *  @return 拼装好的URL
 */
+ (NSString *)requestUrlWithHttpPath:(NSString *)path;


+ (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
                prepare:(void(^)(void))prepare
                success:(SuccessBlock) success
                failure:(FailedBlock) failure;

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
                failure:(FailedBlock)failure;

/**
 *  异常错误处理
 *
 *  @param task
 *  @param error
 *  @param failed
 */
+ (void)handlerErrorWithTask:(NSURLSessionDataTask *)task error:(NSError *)error complete:(FailedBlock)failed;

/**
 *  获取json的statusCode
 *
 *  @param task
 */
+ (NSInteger)statusCodeWithTask:(NSURLSessionDataTask *)task;

+ (NSDictionary *)objectsByRegulateJSON:(id)json;

//post上传的固定参数
+ (NSMutableDictionary*)getAuthParameters;

@end
