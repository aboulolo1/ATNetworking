//
//  UIImageView+Image.m
//  NetWork
//
//  Created by Alaa on 12/8/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import "UIImageView+Image.h"
#import "SessionManger.h"
@implementation UIImageView (Image)
UIActivityIndicatorView *indicator;
-(void)setImageWithURL:(NSString *)url
{
    [self setImageWithURL:url completion:^(Boolean sucess) {
      //  NSLog(@"image downloaded");
    }];
    
}
-(void)setImageWithURL:(NSString *)url completion:(downloadCompletion)completion
{
    [self initalizeIndicator];
    NSURL *urlImage = [NSURL URLWithString:url];
    NSURLSessionDownloadTask *task = [[[SessionManger sharedSession]urlSession] downloadTaskWithURL:urlImage completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage* downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];

        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator stopAnimating];
            [indicator removeFromSuperview];
            if (error == nil) {
                
                [self setImage:downloadedImage];
                completion(true);
            }
            else
            {
                completion(false);
            }
        });
        
    }];
    [task resume];
}
-(void)initalizeIndicator
{
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.hidesWhenStopped = YES;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    CGRect frame = indicator.frame;
    frame.origin.x = self.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.frame.size.height / 2 - frame.size.height / 2;
    indicator.frame = frame;
    dispatch_async(dispatch_get_main_queue(), ^{
  
        [indicator startAnimating];
    [self addSubview:indicator];
    });

}
@end
