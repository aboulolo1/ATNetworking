//
//  Networking.h
//  NetWork
//
//  Created by Alaa on 12/6/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATNetworking : NSObject


typedef void(^resultCompletion)(NSData*, NSURLResponse*, NSError*);

+(void)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary*)parameters headers:(NSDictionary*)herders result:(resultCompletion)result;

+(void)uploadDataWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary*)parameters headers:(NSDictionary*)herders data:(NSData*)data result:(resultCompletion)result;

+(void)downloaddDataWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary*)parameters headers:(NSDictionary*)herders data:(NSData*)data result:(resultCompletion)result;

+(NSString *) buildQueryStringFromDictionary:(NSDictionary *)parameters;
@end
