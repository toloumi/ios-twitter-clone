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
#import "UIImageView+AFNetworking.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOut)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeTweet)];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        _tweets = tweets;
        
        [self.tableView reloadData];
    }];
    
    
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
        cell.userName.text = tweet.author.name;
        cell.tweetText.text = tweet.text;
        cell.timestamp.text = [NSString stringWithFormat:@"%@", tweet.createdAt];
        [cell.userImage setImageWithURL:[NSURL URLWithString:tweet.author.profileImageUrl]];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
