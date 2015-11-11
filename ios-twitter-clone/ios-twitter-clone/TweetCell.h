//
//  TweetCell.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kTweetCellId;

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;

@end
