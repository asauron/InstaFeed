//
//  PhotosDetailViewController.m
//  InstaFeed
//
//  Created by Abinaya Sarva on 10/15/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import "PhotosDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotosDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *photoCommentsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSArray *comments;

@end

@implementation PhotosDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoCommentsTableView.dataSource = self;
    self.photoCommentsTableView.delegate = self;
    
    NSString *photoURL = [self.photo valueForKeyPath:@"images.standard_resolution.url"];
    [self.photoImageView setImageWithURL: [NSURL URLWithString:photoURL]];
    self.comments = [self.photo valueForKeyPath:@"comments.data"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [self.comments[indexPath.row] valueForKeyPath:@"text"];
    return cell;
}

@end
