//
//  ViewController.m
//  Test
//
//  Created by Alaa on 12/8/18.
//  Copyright © 2018 Alaa. All rights reserved.
//

#import "ViewController.h"
#import <ATNetwok/ATNetwok.h>
#import "CustomCell.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tb;


@end

@implementation ViewController
NSMutableArray *result;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_tb setDelegate:self];
    [_tb setDataSource:self];
    result = [[NSMutableArray alloc] init];
   
}
-(void)viewWillAppear:(BOOL)animated
{
     [ATNetworking requestWithMethod:@"get" url:@"http://itunes.apple.com/search?entity=software&term=orange" parameters:nil headers:nil result:^(NSData *data, NSURLResponse *response, NSError *err) {
         if (err == nil) {
             NSDictionary *jsonObject=[NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:kNilOptions
                                       error:nil];
             result = [jsonObject objectForKey:@"results"];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [_tb reloadData];

             });

         }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomCell *cell = [_tb dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.name.text = [[result objectAtIndex:indexPath.row] objectForKey:@"description"];
    cell.imge.image = [UIImage imageNamed:@"og-default"];
    [cell.imge setImageWithURL:[[result objectAtIndex:indexPath.row] objectForKey:@"artworkUrl512"]];
  
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [result count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

@end
