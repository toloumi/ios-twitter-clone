//
//  TweetCell.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class TweetCell;
extern NSString *const kTweetCellId;

@protocol TweetCellDelegate

- (void)tweetCell:(TweetCell *)cell userTouched:(User *)user;

@end

@interface TweetCell : UITableViewCell
@property (nonatomic, weak) id delegate;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *screenName;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;

@property (strong, nonatomic) NSString *tweetUserId;

- (void)onImageTap:(UITapGestureRecognizer *)sender;

@end
