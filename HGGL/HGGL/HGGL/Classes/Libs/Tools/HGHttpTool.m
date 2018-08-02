//
//  HGHttpTool.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "HGHttpTool.h"
#import "AFNetworking.h"
@implementation HGHttpTool
+(void)POSTWithURL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSArray * cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [HGUserDefaults objectForKey:HGUserCookie]];
    NSHTTPCookieStorage * cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie * cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    config.timeoutIntervalForRequest = 120;
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    if ([URLString containsString:@"Mentee/getMyClass.do"]) {
//        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    }

//    NSString *url = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *url = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [mgr POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，稍后重试"];
        if (failure) {
            failure(error);
        }
        
    }];
    
}
+(void)PostWithURL:(NSString *)URLString parameters:(id)parameters withImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
