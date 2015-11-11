//
//  Tweet.h
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *author;

- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray: (NSArray *)array;
    
@end
