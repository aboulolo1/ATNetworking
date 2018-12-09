//
//  UIImageView+Image.h
//  NetWork
//
//  Created by Alaa on 12/8/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Image)
typedef void(^downloadCompletion)(Boolean);

-(void)setImageWithURL:(NSString *)url completion:(downloadCompletion)completion;
-(void)setImageWithURL:(NSString *)url;
@end
