//
//  TweetDetailsViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "User.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailsViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *tweetText;
@property (strong, nonatomic) Tweet *tweet;

@end

@implementation TweetDetailsViewController

- (instancetype)initWithTweet:(Tweet *)tweet {
    self = [super init];
    
    if (self) {
        _tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_profileImage setImageWithURL:[NSURL URLWithString:self.tweet.author.profileImageUrl]];
    _username.text = self.tweet.author.name;
    _tweetText.text = self.tweet.text;
    
    self.title = @"Tweet";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReply {
}

- (IBAction)onRetweet:(id)sender {
}

- (IBAction)onFavorite:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
