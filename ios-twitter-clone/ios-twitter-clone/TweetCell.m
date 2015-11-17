//
//  TweetCell.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "TweetCell.h"
#import "TwitterClient.h"

NSString *const kTweetCellId = @"TweetCellId";

@interface TweetCell ()

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)onImageTap:(UITapGestureRecognizer *)sender {
    [[TwitterClient sharedInstance] fetchUserById:self.tweetUserId andScreenName:self.screenName.text WithCompletion:^(User *user, NSError *error) {
        if (self.delegate && user) {
            [self.delegate tweetCell:self userTouched:user];
        }
    }];
}

@end
