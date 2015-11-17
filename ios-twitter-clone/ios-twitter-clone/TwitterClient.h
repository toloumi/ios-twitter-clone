//
//  TwitterClient.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)mentionsTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)postTweet:(NSDictionary *)params completion:(void (^)(NSDictionary *tweetResponse, NSError *erro))completion;
- (void)toggleRetweet:(Tweet *)tweet WithCompletion:(void (^)(NSDictionary *retweetResponse, NSError *error))completion;
- (void)toggleFavoriteTweet:(Tweet *)tweet WithCompletion:(void (^)(NSDictionary *favoriteResponse, NSError *error))completion;
- (void)fetchUserById:(NSString *)userId andScreenName:(NSString *)screenName WithCompletion:(void (^)(User *user, NSError *error))completion;
@end
