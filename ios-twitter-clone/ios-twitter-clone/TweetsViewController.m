//
//  TweetsViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeTweetViewController.h"
#import "TweetDetailsViewController.h"
#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+TimeAgo.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL useMentionsTimeLine;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeTweet)];
    self.navigationController.navigationBar.translucent = NO;
    
    if (self.useMentionsTimeLine) {
        [[TwitterClient sharedInstance] mentionsTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            _tweets = tweets;
            
            [self.tableView reloadData];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            _tweets = tweets;
            
            [self.tableView reloadData];
        }];
    }
    
    
    self.tableView.estimatedRowHeight = 10;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:kTweetCellId];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSignOut {
    [User logout];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTweetCellId];
    
    if (cell) {
        Tweet *tweet = self.tweets[indexPath.row];
        cell.delegate = self;
        cell.userName.text = tweet.author.name;
        cell.screenName.text = [NSString stringWithFormat:@"@%@", tweet.author.screenName ];
        cell.tweetText.text = tweet.text;
        cell.timestamp.text = [tweet.createdAt timeAgoSimple];
        cell.tweetUserId = tweet.author.twitterId;
        [cell.userImage setImageWithURL:[NSURL URLWithString:tweet.author.profileImageUrl]];
        
        UITapGestureRecognizer *gRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(onImageTap:)];
        gRecognizer.numberOfTapsRequired = 1;
        [cell.userImage addGestureRecognizer:gRecognizer];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tweets.count == 0) {
        return 0;
    }
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailsViewController *tdvc = [[TweetDetailsViewController alloc] initWithTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:tdvc animated:YES];
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        _tweets = tweets;
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)onComposeTweet {
    //Push on compose tweet view controller
    ComposeTweetViewController *ctvc = [[ComposeTweetViewController alloc] init];
    [self.navigationController pushViewController:ctvc animated:YES];
}

- (void)tweetCell:(TweetCell *)cell userTouched:(User *)user {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ProfileViewController *pvc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [pvc setProfileUser:user];
    
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)setupWithHomeTimeline {
    self.useMentionsTimeLine = NO;
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        _tweets = tweets;
        
        [self.tableView reloadData];
    }];
}

- (void)setupWithMentionsTimeline {
    self.useMentionsTimeLine = YES;
    
    [[TwitterClient sharedInstance] mentionsTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        _tweets = tweets;
        
        [self.tableView reloadData];
    }];
}

@end
