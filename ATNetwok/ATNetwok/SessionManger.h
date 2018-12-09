//
//  SessionManger.h
//  NetWork
//
//  Created by Alaa on 12/6/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionManger : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate> {
    NSURLSessionConfiguration *urlSessionconfiguration;
    NSURLSession *urlSession;
}

-(NSURLSession*)urlSession;
-(NSOperationQueue *)setNumberOfConcurrentRequest;
+ sharedSession;

@end
