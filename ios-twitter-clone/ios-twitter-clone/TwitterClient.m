//
//  TwitterClient.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString *const kTwitterConsumerKey = @"xF7SIVh7aYxPT8BgrQkqsEvjL";
NSString *const kTwitterConsumerSecret = @"uCAfiMOGfP2tO71eDXct3m9bLSjYFTUTdkkBuYNG47n1MP9kQ8";
NSString *const kTwitterConsumerBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterConsumerBaseUrl]
                                                  consumerKey:kTwitterConsumerKey
                                               consumerSecret:kTwitterConsumerSecret];
        }
    });

    return instance;
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion{
    self.loginCompletion = completion;

    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token"
                                                       method:@"GET"
                                                  callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"]
                                                        scope:nil
                                                      success:^(BDBOAuth1Credential *requestToken) {
                                                          NSLog(@"Fetch Success");
                                                          
                                                          NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
                                                          
                                                          [[UIApplication sharedApplication] openURL:authUrl];
                                                      }failure:^(NSError *error) {
                                                          self.loginCompletion(nil, error);
                                                      }];
}

- (void)openUrl:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token"
                                                      method:@"POST"
                                                requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query]
                                                     success:^(BDBOAuth1Credential *accessToken) {
                                                         [self.requestSerializer saveAccessToken:accessToken];
                                                         
                                                         [self GET:@"1.1/account/verify_credentials.json"
                                                                                  parameters:nil
                                                                                     success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                                                                                         User *user = [[User alloc] initWithDictionary:responseObject];
                                                                                         [User setCurrentUser:user];
                                                                                         self.loginCompletion(user, nil);
                                                         } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                                                             self.loginCompletion(nil, error);
                                                         }];
                                                     } failure:^(NSError *error) {
                                                     }];
}

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)postTweet:(NSDictionary *)params completion:(void (^)(NSDictionary *, NSError *))completion {
    //NSString *escapedString = [[NSString stringWithFormat:@"1.1/statuses/update.json?status=%@", params[@"status"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [self POST:[NSString stringWithFormat:@"1.1/statuses/update.json?status=%@", params[@"status"]] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)retweetWithCompletion:(void (^)(NSDictionary *retweetResponse, NSError *error))completion {
    //1.1/statuses/retweet/:id.json
}

- (void)favoriteWithCompletion:(void (^)(NSDictionary *favoriteResponse, NSError *error))completion {
}
@end
