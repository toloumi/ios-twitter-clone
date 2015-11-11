//
//  TweetDetailsViewController.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailsViewController : UIViewController

- (instancetype)initWithTweet:(Tweet *)tweet;
@end
