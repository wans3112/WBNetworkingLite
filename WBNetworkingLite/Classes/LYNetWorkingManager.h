//
//  LYNetWorkingManager.h
//  LYExampleProject
//
//  Created by wans on 2017/5/9.
//  Copyright © 2017年 wans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYNetWorkingConfig.h"

@interface LYNetWorkingManager : NSObject

/**
 初始化

 @param request 请求配置
 @param method 请求类型
 @return 实例
 */
- (instancetype)initWithRequest:(LYHttpRequestConfig)request method:(NSString *)method;



/**
 配置进度百分比

 @param progressBlock 进度回调
 */
- (void)configProgress:(LYHttpProgress)progressBlock;

/**
 配置上传内容

 @param uploadDataBlock 上传数据配置
 */
- (void)configUploadData:(LYHttpUploadData)uploadDataBlock;


/**
 执行请求并设置回调

 @param response 完成回调
 */
- (void)excuteTaskResponse:(LYHttpResponse)response;


/**
 获取task实例

 @param key 标识
 @return task实例
 */
+ (NSURLSessionTask *)taskWithKey:(NSString *)key;

/**
 移除task实例

 @param key 标识
 */
+ (void)removeTaskWithKey:(NSString *)key;

@end


