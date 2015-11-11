//
//  Tweet.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSArray *)tweetsWithArray: (NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *tweetDict in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:tweetDict]];
    }
    return tweets;
}

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.text = dictionary[@"text"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:dictionary[@"created_at"]];
        self.author = [[User alloc] initWithDictionary:dictionary[@"user"]];
    }
    return self;
}

@end
