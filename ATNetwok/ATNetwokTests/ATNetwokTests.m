//
//  ATNetwokTests.m
//  ATNetwokTests
//
//  Created by Alaa on 12/8/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ATNetworking.h"
#import "SessionManger.h"
#import "UIImageView+Image.h"
#import "Reachability.h"
@interface ATNetwokTests : XCTestCase

@end

@implementation ATNetwokTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testReqestWithMethoGet
{
    XCTestExpectation *exp = [self expectationWithDescription:@"testReqestWithMethoGet"];

    [ATNetworking requestWithMethod:@"get" url:@"http://itunes.apple.com/search?entity=software&term=orange" parameters:nil headers:nil result:^(NSData *data, NSURLResponse *response, NSError *err) {
        XCTAssertNotNil(data);
            XCTAssertNil(err);
            [exp fulfill];
    }];
   
    [self waitForExpectationsWithTimeout:40 handler: nil];
    
}

-(void)testNumberOfConcurrentRequestWithWifiAndCellular
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        XCTAssertEqual([[SessionManger sharedSession] urlSession].delegateQueue.maxConcurrentOperationCount, 6);

    }
    else if (status == ReachableViaWWAN)
    {
        XCTAssertEqual([[SessionManger sharedSession] urlSession].delegateQueue.maxConcurrentOperationCount, 2);

    }

}

-(void)testImageWithUrl
{
    XCTestExpectation *exp = [self expectationWithDescription:@"testImageWithUrl"];
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImageWithURL:@"https://is2-ssl.mzstatic.com/image/thumb/Purple4/v4/12/b1/28/12b128c9-1566-b69e-8790-15b5004a52f7/source/100x100bb.jpg" completion:^(Boolean sucess) {
        XCTAssertEqual(sucess, YES);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler: nil];

}

-(void)testParameter
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"software" forKey:@"entity"];
    [parameters setObject:@"orange" forKey:@"term"];
    NSString *paramParseing = [ATNetworking buildQueryStringFromDictionary:parameters];
    NSString *excepected = @"?entity=software&term=orange";
    XCTAssertEqual([excepected isEqualToString:paramParseing],YES);
}
@end
