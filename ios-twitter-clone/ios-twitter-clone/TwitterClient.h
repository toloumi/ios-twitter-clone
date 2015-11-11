//
//  TwitterClient.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)postTweet:(NSDictionary *)params completion:(void (^)(NSDictionary *tweetResponse, NSError *error))completion;
- (void)retweetWithCompletion:(void (^)(NSDictionary *retweetResponse, NSError *error))completion;
- (void)favoriteWithCompletion:(void (^)(NSDictionary *favoriteResponse, NSError *error))completion;
@end
