//
//  PhotosViewController.m
//  InstaFeed
//
//  Created by Abinaya Sarva on 10/15/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotosDetailViewController.h"
#import "PhotoTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosViewController ()
@property (weak, nonatomic) IBOutlet UITableView *photosTableView;
@property (nonatomic, strong) NSArray *photos;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosTableView.dataSource = self;
    self.photosTableView.delegate =  self;
    self.photosTableView.rowHeight = 320;
    
    UINib *cellNib = [UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil];
    
    [self.photosTableView registerNib:cellNib forCellReuseIdentifier:@"PhotoTableViewCell"];
    
    NSURL *url = [NSURL URLWithString: @"https://api.instagram.com/v1/media/popular?client_id=69ed004250744e9dbad650b3a8692f37"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL: url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.photos = dictionary[@"data"];
        [self.photosTableView reloadData];
        NSLog(@"response: %@", dictionary);
    }];
}
                                                                                                                                                        

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell" forIndexPath:indexPath];
    NSDictionary *photo = self.photos[indexPath.row];
    NSString *photoURL = [photo valueForKeyPath:@"images.standard_resolution.url"];
    [cell.photoImage setImageWithURL: [NSURL URLWithString:photoURL]];
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PhotosDetailViewController *vc = [[PhotosDetailViewController alloc] init];
    vc.photo = self.photos[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
