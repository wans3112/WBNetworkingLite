//
//  LYNetWorkingConfig.m
//  LYNetWorkingExample
//
//  Created by wans on 2017/9/14.
//  Copyright © 2017年 wans. All rights reserved.
//

#import "LYNetWorkingConfig.h"
#import "LYNetWorking.h"

@implementation LYUploadData

@end

@implementation LYNetWorkingConfig

- (NSTimeInterval)timeoutInterval {

    if ( _timeoutInterval == 0 ) {
        
        return kDefaultTimeoutInterval;
    }
    
    return _timeoutInterval;
}

- (NSInteger)maxConcurrentCount {
    
    if ( _maxConcurrentCount == 0 ) {
        
        return kDefaultMaxConCurrentCount;
    }
    
    return _maxConcurrentCount;
}

@end


@implementation LYHttpRequestOrder

- (NSString *)url {

    if ( _url ) {
        // url中文转码，url不允许中文
       _url = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return _url;
}

@end
