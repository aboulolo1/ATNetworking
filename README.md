# ATNetworking

installation:

1- download from github

2- open folder ATNetwok and open the project this is the framwork 

3- build project from product->build

4- open product from left menu and showfinder on ATNetwok.framework

5- now you can add it on any project and use it 

how to use it:
first you should import the framework : #import <ATNetwok/ATNetwok.h>

Data Request:

[ATNetworking requestWithMethod:@"get" url:url parameters:parameters headers:headers result:^(NSData *data, NSURLResponse *response, NSError *err) {

}];


upload data:

[ATNetworking uploadDataWithMethod:@"get" url:url parameters:parameters headers:headers data:data result:^(NSData *data, NSURLResponse *response, NSError *err) { 

}];
    
download data:

[ATNetworking downloaddDataWithMethod:@"get" url:url parameters:parameters headers:headers data:data result:^(NSData *data, NSURLResponse *response, NSError *err) { 

}];
    
    
 Dowanload Image With activityIndicator:
 
 [UIImageView setImageWithURL:url]
 
 and you can find folder called test for small project as example 
