//
//  SessionManger.m
//  NetWork
//
//  Created by Alaa on 12/6/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import "SessionManger.h"
#import "Reachability.h"

@implementation SessionManger
static SessionManger *sessionManger = nil;

+(instancetype)sharedSession
{
    if (!sessionManger) {
        sessionManger = [[SessionManger alloc] init];
    }
    return sessionManger;
}

-(NSURLSession*)urlSession
{
    return urlSession;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionManger = [super init];
        NSOperationQueue *queue = [self setNumberOfConcurrentRequest];
        urlSessionconfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        urlSessionconfiguration.HTTPMaximumConnectionsPerHost = 1;
        urlSessionconfiguration.sessionSendsLaunchEvents = true;
        urlSessionconfiguration.discretionary = YES;
        
        urlSession = [NSURLSession sessionWithConfiguration:urlSessionconfiguration delegate:self delegateQueue:queue];

    }
    return self;
}

-(NSOperationQueue *)setNumberOfConcurrentRequest
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        queue.maxConcurrentOperationCount = 6;
    }
    else if (status == ReachableViaWWAN)
    {
        queue.maxConcurrentOperationCount = 2;
    }
    return queue;
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
   didReceiveData:(NSData *)data {
    NSLog(@"receive data");
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
    }
}
@end
