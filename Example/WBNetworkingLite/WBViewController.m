//
//  WBNetworkingLiteViewController.m
//  WBNetworkingLite
//
//  Created by wans3112 on 08/09/2018.
//  Copyright (c) 2018 wans3112. All rights reserved.
//


#import "WBViewController.h"
#import <WBNetworkingLite/WBNetworkingLite.h>

#define IsOder 1

@interface WBViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation WBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)get:(id)sender {
    
    [WBNetworking GET:^(WBRequestConfig *request) {
        request.url = @"/v2/movie/coming_soon";
    } response:^(id response, NSError *error) {
        
    }];
    
}

- (IBAction)post:(id)sender {
    
    [WBNetworking POST:^(WBRequestConfig *request) {
        request.url = @"/lawyer/login";
        request.parameters = @{@"user":@"13798452435", @"pwd":@"E10ADC3949BA59ABBE56E057F20F883E", @"挖":@"返回键"};
    } response:^(id response, NSError *error) {
        NSLog(@"response:%@", response);
    }];
    
}

- (IBAction)put:(id)sender {
    
    [WBNetworking PUT:^(WBRequestConfig *request) {
        request.url = @"/lawyer/past-case";
        request.rf_parameters = @[@"wans"];
        request.parameters = @{@"username":@"wans",@"password":@"123"};
    } response:^(id response, NSError *error) {
        NSLog(@"response:%@", response);
    }];
    
}

- (IBAction)delete:(id)sender {
    
    [WBNetworking DELETE:^(WBRequestConfig *request) {
        request.url = @"/lawyer/past-case";
        request.rf_parameters = @[@"深圳"];
    } response:^(id response, NSError *error) {
        NSLog(@"response:%@", response);
    }];
    
}

- (IBAction)download:(id)sender {
    
    self.imageView.image = nil;
    self.imageView.layer.backgroundColor =  UIColor.clearColor.CGColor;
    
    [WBNetworking DOWNLOAD:^(WBRequestConfig *request) {
        request.url = @"http://wx1.sinaimg.cn/mw690/7d1ef8f4ly1fkaxhkgfpfg20be05y4qy.gif";
    } progress:^(NSProgress * _Nonnull progress) {
        NSLog(@"progress >> %f", progress.fractionCompleted);
        
        self.imageView.layer.backgroundColor =  UIColor.grayColor.CGColor;
        CGRect bounds = self.imageView.layer.frame;
        bounds.size.height = 128 * progress.fractionCompleted;
        self.imageView.layer.frame = bounds;
        
    } response:^(id  _Nonnull response, NSError * _Nonnull error) {
        self.imageView.image = [UIImage imageWithData:response];
    }];
    
}

- (IBAction)upload:(id)sender {
    
    if ( !self.imageView.image ) {
        NSLog(@"click download button first");
        return;
    }
    
    NSData *data = UIImageJPEGRepresentation(self.imageView.image, 1);
    
    [WBNetworking UPLOAD:^(WBRequestConfig *request) {
        request.url = @"/lawyer/lawyer-logo";
    } uploadData:^(WBUploadData *uploadData) {
        uploadData.name = @"logo";
        uploadData.filename = @"logo.jpg";
        uploadData.contentType = @"image/jpg";
        uploadData.data = data;
    } progress:^(NSProgress *progress) {
        NSLog(@"upload percent >> %f", progress.fractionCompleted);
    } response:^(id response, NSError *error) {
        NSLog(@"response:%@", response);
    }];
    
}

- (IBAction)cancel:(id)sender {
    
    [WBNetworking CANCLE:@"http://wx1.sinaimg.cn/mw690/7d1ef8f4ly1fkaxhkgfpfg20be05y4qy.gif"];
    
}

@end
