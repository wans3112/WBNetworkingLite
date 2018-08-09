//
//  LYNetWorkingConfig.h
//  LYNetWorkingExample
//
//  Created by wans on 2017/9/14.
//  Copyright © 2017年 wans. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYHttpRequestOrder;
@class LYNetWorkingConfig;
@class LYUploadData;

// 网络请求数据返回回调
typedef void (^LYHttpResponse)(id response, NSError *error);

NS_ASSUME_NONNULL_BEGIN



// 调用时，自定义参数参入
typedef void (^LYHttpRequestConfig)(LYHttpRequestOrder *request);
typedef void (^LYHttpConfig)(LYNetWorkingConfig *config);

// 上传时参数传入
typedef void (^LYHttpUploadData)(LYUploadData *uploadData);
// 上传进度回调
typedef void (^LYHttpProgress)(NSProgress *progress);

static  NSString *kLYHttpMethodPost              = @"POST";
static  NSString *kLYHttpMethodGet               = @"GET";
static  NSString *kLYHttpMethodUpload            = @"UPLOAD";
static  NSString *kLYHttpMethodDownLoad          = @"DOWNLOAD";
static  NSString *kLYHttpMethodPut               = @"PUT";
static  NSString *kLYHttpMethodDelete            = @"DELETE";

/**
 无网络时默认错误提示
 */
#define kDefaultNetworkelessMsg                  @"网络不给力"

/**
 默认最大请求并发数
 */
#define kDefaultMaxConCurrentCount               5

/**
 默认超时时间
 */
#define kDefaultTimeoutInterval                  30

@interface LYUploadData : NSObject

/**
 字段名
 */
@property (nonatomic,strong) NSString            *name;

/**
 上传数据内容
 */
@property (nonatomic,strong) NSData              *data;

/**
 数据的格式 eg image/jpg, image/png, application/pdf
 */
@property (nonatomic,strong) NSString            *contentType;

/**
 约定上传服务器的文件名
 */
@property (nonatomic,strong) NSString            *filename;

@end


@interface LYNetWorkingConfig : NSObject

/**
 根域名或ip地址
 */
@property (nonatomic,strong) NSString            *baseUrl;

/**
 超时时间
 */
@property (nonatomic,assign) NSTimeInterval      timeoutInterval;

/**
 默认的httpheader
 */
@property (nonatomic,strong) NSDictionary        *defaultHeaderFields;

/**
 默认的参数
 */
@property (nonatomic,strong) NSDictionary        *defaultParameters;

/**
 是否打印日志，Dubug默认打印，Release默认不打印
 */
@property (nonatomic,assign) BOOL                disEnableLog;

/**
 允许最大请求并发数，当设置为1时，则为同步发送请求。
 */
@property (nonatomic,assign) NSInteger           maxConcurrentCount;

@end


@interface LYHttpRequestOrder : NSObject

/**
 请求路径
 */
@property (nonatomic,strong) NSString            *url;

/**
 请求参数 (字典或者json字符串)
 */
@property (nonatomic,strong) id                  parameters;

/**
 restful风格请求参数 ../{username}/{age}
 */
@property (nonatomic,strong) NSArray             *rf_parameters;

/**
 提交到服务的约定格式模式
 */
@property (nonatomic,strong) NSString            *contentType;

@end

NS_ASSUME_NONNULL_END
