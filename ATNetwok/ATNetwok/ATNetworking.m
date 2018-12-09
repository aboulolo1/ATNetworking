//
//  Networking.m
//  NetWork
//
//  Created by Alaa on 12/6/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import "ATNetworking.h"
#import "SessionManger.h"
@implementation ATNetworking


+(void)uploadDataWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary *)parameters headers:(NSDictionary *)herders data:(NSData*)data result:(resultCompletion)result
{
    NSMutableURLRequest *request = [self getRequestWithUrl:url method:method parameters:parameters headers:herders];
    
    NSURLSessionDataTask *task = [[[SessionManger sharedSession]urlSession]uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        result(data,response,error);
    }];
    
    [task resume];
}
+(void)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary *)parameters headers:(NSDictionary*)herders result:(resultCompletion)result
{
    
    NSMutableURLRequest *request = [self getRequestWithUrl:url method:method parameters:parameters headers:herders];
    
    NSURLSessionDataTask *task = [[[SessionManger sharedSession]urlSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        result(data,response,error);
    }];
    
    [task resume];
}

+(void)downloaddDataWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary *)parameters headers:(NSDictionary *)herders data:(NSData *)data result:(resultCompletion)result
{
    NSMutableURLRequest *request = [self getRequestWithUrl:url method:method parameters:parameters headers:herders];
    
    NSURLSessionDownloadTask *task = [[[SessionManger sharedSession]urlSession]downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (location == nil) {
            result(nil,response,error);
        }
        else
        {
            result([NSData dataWithContentsOfURL:location],response,error);
        }
    }];
    [task resume];
}

+(NSMutableURLRequest*)getRequestWithUrl:(NSString *)url method:(NSString*)method parameters:(NSDictionary *)parameters headers:(NSDictionary*)herders
{
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];

    if (parameters != nil) {
        if ([method isEqualToString:@"get"]) {
            URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,[self buildQueryStringFromDictionary:parameters]]];
            request = [NSMutableURLRequest requestWithURL:URL];
        }
        else
        {
            NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
            [request setHTTPBody:postData];
        }
        
    }
    
    [request setHTTPMethod:method];
    if (herders != nil) {
        for(NSString*key in herders) {
            [request setValue:herders[key] forHTTPHeaderField:key];
        }
    }
    
    return request;
}
+(NSString *) buildQueryStringFromDictionary:(NSDictionary *)parameters {
    NSString *urlVars = @"";
    for (NSString *key in parameters) {
        NSString *value = parameters[key];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        urlVars = [NSString stringWithFormat:@"%@%@%@=%@", urlVars, urlVars.length ? @"&": @"", key, value];
    }
    return [NSString stringWithFormat:@"%@%@", urlVars ? @"?" : @"", urlVars ? urlVars : @""];
}
@end
