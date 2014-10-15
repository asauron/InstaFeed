//
//  PhotosDetailViewController.h
//  InstaFeed
//
//  Created by Abinaya Sarva on 10/15/14.
//  Copyright (c) 2014 Sarva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *photo;

@end
