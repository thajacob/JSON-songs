//
//  ViewController.m
//  Top Songs JSON
//
//  Created by jakub skrzypczynski on 06/10/2016.
//  Copyright © 2016 test project. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *jsonFeed;
@property (strong, nonatomic) NSDictionary *songFeed;
@property (strong, nonatomic) NSMutableArray *songList;
@property (strong, nonatomic) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    [self fetchJasonFeed];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.songList count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
    return cell;

}

-(void)fetchJasonFeed

{
    self.jsonFeed = nil;
    self.songFeed = nil;
    self.songList = nil;
    
    self.session = [NSURLSession sharedSession];
    NSURL *myURL = [NSURL URLWithString:@"https://itunes.apple.com/gb/rss/topalbums/limit=50/json"];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)  {
        self.jsonFeed =[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@",self.jsonFeed);
        self.songFeed = [self.jsonFeed objectForKey:@"feed"];
        self.songList = [self.songFeed objectForKey:@"entry"];
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
    }];
    [dataTask resume];
        
        
    }
    
    
    






@end
