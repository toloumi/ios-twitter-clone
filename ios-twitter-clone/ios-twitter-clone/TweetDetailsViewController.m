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
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
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
    _favoriteButton.selected = self.tweet.favorited;
    _retweetButton.selected = self.tweet.retweeted;
    
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
    [[TwitterClient sharedInstance] toggleRetweet:self.tweet WithCompletion:^(NSDictionary *retweetResponse, NSError *error) {
        self.retweetButton.selected = !self.retweetButton.selected;
        //NSLog(@"%@",retweetResponse);
    }];
}

- (IBAction)onFavorite:(id)sender {
    [[TwitterClient sharedInstance] toggleFavoriteTweet:self.tweet WithCompletion:^(NSDictionary *favoriteResponse, NSError *error) {
        //NSLog(@"%@",favoriteResponse);
        self.favoriteButton.selected = !self.favoriteButton.selected;
    }];
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
