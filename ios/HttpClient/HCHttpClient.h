//
//  HCHttpClient.h
//  HTTP网络请求
//  Created by hc on 15-12-15.
//  Copyright (c) 2015年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//HTTP REQUEST METHOD TYPE
typedef NS_ENUM(NSInteger, RTHttpRequestType) {
    RTHttpRequestGet,
    RTHttpRequestPost,
    RTHttpRequestDelete,
    RTHttpRequestPut,
    RTHttpRequestPostFile,
};

//文件操作类型 上传or下载
typedef NS_OPTIONS(NSUInteger, RTHttpFileOperationType) {
    RTHttpFileOperationTypeUpload,
    RTHttpFileOperationTypeDownloadWithResumeData,
    RTHttpFileOperationTypeDownloadWithRequest,
};


/****************   RTHttpClient   ****************/
@interface HCHttpClient : NSObject

+ (HCHttpClient *)defaultClient;

/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param prepare    请求前预处理块
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
                prepare:(void(^)(void))prepare
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  文件上传或下载
 *
 *  @param url
 *  @param method            方法类型
 *  @param parameters        参数
 *  @param progress          进度block
 *  @param resumeData        resumeData
 *  @param constructBody     上传表单block
 *  @param destination       <#destination description#>
 *  @param completionHandler <#completionHandler description#>
 *  @param prepare           请求前预处理块
 *  @param success           请求成功处理块
 *  @param failure           请求失败处理块
 */
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
               progress:(void (^)(NSProgress *))progress
             resumeData:(NSData *)resumeData
          constructBody:(void (^)(id<AFMultipartFormData>))constructBody
            destination:(NSURL * (^)(NSURL *,NSURLResponse *))destination
      completionHandler:(void (^)(NSURLResponse *,NSURL *,NSError *))completionHandler
                prepare:(void (^)(void))prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

/**
 *  HTTP请求（HEAD）
 *
 *  @param path
 *  @param parameters
 *  @param success
 *  @param failure
 */
- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//判断当前网络状态
- (BOOL)isConnectionAvailable;


@end
