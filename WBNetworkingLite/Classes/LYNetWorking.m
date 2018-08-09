//
//  LYNetWork.m
//  LYExampleProject
//
//  Created by wans on 2017/5/4.
//  Copyright © 2017年 wans. All rights reserved.
//

#import "LYNetWorking.h"
#import "LYNetWorkingManager.h"
#import "objc/runtime.h"

@interface LYNetWorking ()

@end

@implementation LYNetWorking

+ (void)POST:(LYHttpRequestConfig)request response:(LYHttpResponse)response {

    [[self class] request:request method:kLYHttpMethodPost response:response];
}

+ (void)GET:(LYHttpRequestConfig)request response:(LYHttpResponse)response {
    
    [[self class] request:request method:kLYHttpMethodGet response:response];
}

+ (void)PUT:(LYHttpRequestConfig)request response:(LYHttpResponse)response {
    [[self class] request:request method:kLYHttpMethodPut response:response];
}

+ (void)DELETE:(LYHttpRequestConfig)request response:(LYHttpResponse)response {
    [[self class] request:request method:kLYHttpMethodDelete response:response];
}

+ (void)UPLOAD:(LYHttpRequestConfig)request uploadData:(LYHttpUploadData)uploadData progress:(LYHttpProgress)progress response:(LYHttpResponse)response {
    
    [[self class] request:request method:kLYHttpMethodUpload uploadData:uploadData progress:progress response:response];
}

+ (void)DOWNLOAD:(LYHttpRequestConfig)request progress:(LYHttpProgress)progress response:(LYHttpResponse)response {
    
    [[self class] request:request method:kLYHttpMethodDownLoad uploadData:nil progress:progress response:response];
}

+ (void)request:(LYHttpRequestConfig)request method:(NSString *)method response:(LYHttpResponse)response {
    [[self class] request:request method:method uploadData:nil progress:nil response:response];
}

+ (void)request:(LYHttpRequestConfig)request method:(NSString *)method uploadData:(LYHttpUploadData)uploadData progress:(LYHttpProgress)progress response:(LYHttpResponse)response {
    
    if ( ![LYHMReachability isReachable] && response ) {
        
        [[self class] handerWithPrepareWhenNOInternet:response];
        
        return;
    }
    
    // 全局信号量，用于控制请求最大并发数
    static dispatch_semaphore_t seqeue_semaphore;
    if ( !seqeue_semaphore ) {
        seqeue_semaphore = dispatch_semaphore_create(httpConfig.maxConcurrentCount);
    }
    
    // 设置最大并发数
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 如果超出最大并发数，则等待资源释放
        dispatch_semaphore_wait(seqeue_semaphore, DISPATCH_TIME_FOREVER);

        LYNetWorkingManager *requestManager = [[LYNetWorkingManager alloc] initWithRequest:request method:method];
        [requestManager configUploadData:uploadData];
        [requestManager configProgress:progress];
        [requestManager excuteTaskResponse:^(id  _Nonnull responseData, NSError * _Nonnull error) {
            
            if ( response ) {
                response(responseData, error);
            }
            // 释放资源，通知等待请求开始执行
            dispatch_semaphore_signal(seqeue_semaphore);
        }];
    });
    
}

+ (void)CANCLE:(NSString *)url {

    NSAssert(url.length > 0, @"无效请求地址");
    
    NSURLSessionTask *task = [LYNetWorkingManager taskWithKey:url];
    
    if ( task ) {
        [task cancel];
        
        [LYNetWorkingManager removeTaskWithKey:url];
    }
}


/**
 监测没有网络时回调
 
 @param response 失败回调
 */
+ (void)handerWithPrepareWhenNOInternet:(LYHttpResponse)response {
    
    NSError *error = [NSError errorWithDomain:@"" code:-1000 userInfo:@{@"msg":kDefaultNetworkelessMsg}];
    
    response(nil, error);
}

#pragma mark - Getter&&Setter

// 网络库全局配置
static LYNetWorkingConfig   *httpConfig;

+ (LYNetWorkingConfig *)httpConfig {
    
    return httpConfig;
}

+ (void)setupHttpConfig:(LYHttpConfig)config {
    
    LYNetWorkingConfig *tempConfig = [LYNetWorkingConfig new];
    config(tempConfig);
    
    // 去除为空的字段
    tempConfig.defaultHeaderFields = fetchValidValues(tempConfig.defaultHeaderFields);
    tempConfig.defaultParameters = fetchValidValues(tempConfig.defaultParameters);
    
    httpConfig = tempConfig;
}

+ (void)updateHttpConfig:(LYHttpConfig)config {
    
    LYNetWorkingConfig *tempConfig = [LYNetWorkingConfig new];
    config(tempConfig);
    
    // 如果已经配置属性，则只更新属性
    // 更新默认根域名
    if ( tempConfig.baseUrl.length > 0 ) {
        httpConfig.baseUrl = tempConfig.baseUrl;
    }
    
    // 更新默认HeaderFields
    if ( tempConfig.defaultHeaderFields.count > 0 ) {
        
        NSMutableDictionary *existHeaderFields = httpConfig.defaultHeaderFields.mutableCopy;
        [existHeaderFields addEntriesFromDictionary:tempConfig.defaultHeaderFields];
        
        httpConfig.defaultHeaderFields = fetchValidValues(existHeaderFields);
    }
    
    // 更新默认Parameters
    if ( tempConfig.defaultParameters.count > 0 ) {
        
        NSMutableDictionary *existParameters = httpConfig.defaultParameters.mutableCopy;
        [existParameters addEntriesFromDictionary:tempConfig.defaultParameters];
        
        httpConfig.defaultParameters = fetchValidValues(existParameters);
    }
    
}

/**
 去除为空的字段
 
 @param originalValues 原始数据
 @return 有效数据
 */
NSDictionary * fetchValidValues(NSDictionary *originalValues) {
    
    NSMutableDictionary *vaildValues = [NSMutableDictionary dictionary];
    [originalValues enumerateKeysAndObjectsUsingBlock:^(id key, NSString *value, BOOL *stop) {
        if ( value && value.length > 0 ){
            vaildValues[key] = value;
        }
    }];
    
    return vaildValues;
}

@end



