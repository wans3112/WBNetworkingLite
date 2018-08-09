//
//  LYNetWorking.h
//  LYExampleProject
//
//  Created by wans on 2017/5/4.
//  Copyright © 2017年 wans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYNetWorkingConfig.h"
#import "LYHMReachability.h"

@interface LYNetWorking : NSObject

+ (void)setupHttpConfig:(LYHttpConfig)config;//!< 配置网络库，根域名，默认Header,超时时间等属性
+ (void)updateHttpConfig:(LYHttpConfig)config;//!< 更新网络库配置，只会更新，不会替换，如删除，将对应的value置空。
+ (LYNetWorkingConfig *)httpConfig;//!< 获取网络库配置


/**
 get请求
 
 @param request 请求参数
 @param response 完成回调
 
 */
+ (void)GET:(LYHttpRequestConfig)request response:(LYHttpResponse)response;


/**
 post请求

 @param request 请求参数
 @param response 完成回调
 
 */
+ (void)POST:(LYHttpRequestConfig)request response:(LYHttpResponse)response;


/**
 put请求
 
 @param request 请求参数
 @param response 完成回调
 
 */
+ (void)PUT:(LYHttpRequestConfig)request response:(LYHttpResponse)response;

/**
 delete请求
 
 @param request 请求参数
 @param response 完成回调
 
 */
+ (void)DELETE:(LYHttpRequestConfig)request response:(LYHttpResponse)response;

/**
 下载请求

 @param request 请求参数
 @param progress 进度百分比
 @param response 完成回调
 
 */
+ (void)DOWNLOAD:(LYHttpRequestConfig)request progress:(LYHttpProgress)progress response:(LYHttpResponse)response;


/**
 上传请求

 @param request 请求参数
 @param uploadData 上传数据
 @param progress 进度百分比
 @param response 完成回调
 
 */
+ (void)UPLOAD:(LYHttpRequestConfig)request uploadData:(LYHttpUploadData)uploadData  progress:(LYHttpProgress)progress response:(LYHttpResponse)response;

/**
 取消请求

 @param url 请求地址
 */
+ (void)CANCLE:(NSString *)url;

@end
