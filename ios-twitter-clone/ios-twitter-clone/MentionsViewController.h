//
//  MentionsViewController.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/16/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "TweetsViewController.h"

@interface MentionsViewController : TweetsViewController
- (void)setupWithHomeTimeline;
- (void)setupWithMentionsTimeline;

@end
