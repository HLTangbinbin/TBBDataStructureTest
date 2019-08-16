//
//  HCHttpClient.m
//  Created by hc on 15-12-15.
//  Copyright (c) 2015年 ZLY. All rights reserved.
//

#import "HCHttpClient.h"
#import "HCJSONResponseSerializerWithData.h"
//#import <AFNetworking/AFSecurityPolicy.h>
//#import <AFNetworking/AFHTTPSessionManager.h>
//#import <Reachability/Reachability.h>
#import <netinet/in.h>
//#import <AdSupport/AdSupport.h>
//#import "AppDelegate.h"
//#import "APIConfig.h"

@interface HCHttpClient()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation HCHttpClient

- (id)init{
    if (self = [super init]){
        self.manager = [AFHTTPSessionManager manager];
        //设置请求头
        self.manager.requestSerializer.timeoutInterval = 10;
        [self.manager.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [self.manager.requestSerializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Content-Encoding"];
        [self.manager.requestSerializer setHTTPShouldHandleCookies:NO];
        self.manager.securityPolicy.allowInvalidCertificates = YES;
        self.manager.securityPolicy.validatesDomainName = NO;
        
#ifdef SERVER_TYPE
        
#else
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"mm" ofType:@"cer"];
//        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        // 是否允许,NO-- 不允许无效的证书
//        [securityPolicy setAllowInvalidCertificates:YES];
//        // 设置证书
//        [securityPolicy setPinnedCertificates:certSet];
//        self.manager.securityPolicy = securityPolicy;
  
#endif
        
        //请求参数序列化类型
        //        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //        [self.manager.requestSerializer setHTTPShouldHandleCookies:NO];
        //响应结果序列化类型
        HCJSONResponseSerializerWithData* responseSerializer = [HCJSONResponseSerializerWithData serializer];;
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        self.manager.responseSerializer = responseSerializer;
        
        //        self.manager.responseSerializer.acceptableContentTypes = [NSSetsetWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        
        
        
        
    }
    return self;
}

+ (HCHttpClient *)defaultClient
{
    static HCHttpClient *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(NSDictionary *)parameters
                prepare:(void(^)(void))prepare
                success:(void (^)(NSURLSessionDataTask *, id))success
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //预处理
    if (prepare) {
        prepare();
    }
    
    
    switch (method) {
        case RTHttpRequestGet:
        {
            [self.manager GET:url parameters:parameters progress:nil success:success failure:failure];
        }
            break;
        case RTHttpRequestPost:
        {
            [self.manager POST:url parameters:parameters progress:nil success:success failure:failure];
        }
            break;
        case RTHttpRequestDelete:
        {
            [self.manager DELETE:url parameters:parameters success:success failure:failure];
        }
            break;
        case RTHttpRequestPut:
        {
            [self.manager PUT:url parameters:parameters success:success failure:failure];
        }
            break;
        default:
            break;
            
            //    if ([self isConnectionAvailable]) {
            //
            //    }else{
            //        //发出网络异常通知广播
            //        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
            //    }
    }
}

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
                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    //预处理
    if (prepare) {
        prepare();
    }
    
    if ([self isConnectionAvailable]) {
        switch (method) {
            case RTHttpFileOperationTypeUpload:
            {
                [self.manager POST:url parameters:parameters constructingBodyWithBlock:constructBody progress:progress success:success failure:failure];
            }
                break;
                
            case RTHttpFileOperationTypeDownloadWithResumeData:
            {
                [self.manager downloadTaskWithResumeData:resumeData progress:progress destination:destination completionHandler:completionHandler];
                
            }
                break;
                
            case RTHttpFileOperationTypeDownloadWithRequest:
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                [self.manager downloadTaskWithRequest:request progress:progress destination:destination completionHandler:completionHandler];
                
            }
                break;
            default: break;
        }
    }
}

- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    if ([self isConnectionAvailable]) {
        [self.manager HEAD:url parameters:parameters success:success failure:failure];
    }else{
        //发出网络异常通知广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
}

//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (void)cancelRequest
{
    [_manager.operationQueue cancelAllOperations];
}



@end
