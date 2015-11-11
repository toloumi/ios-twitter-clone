//
//  ComposeTweetViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/10/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeTweetViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *remainingChars;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UITextView *tweetText;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) User *user;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Compose Tweet";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    self.navigationController.navigationBar.translucent = NO;
    
    _user = [User currentUser];
    _username.text = self.user.name;
    _remainingChars.text = @"0";
    _tweetText.text = @"";
    [_profileImage setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    
    self.tweetText.delegate = self;
    [self.tweetText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTweet {
    //Post tweet using method on TwitterClient
    [[TwitterClient sharedInstance] postTweet:@{@"status":self.tweetText.text} completion:^(NSDictionary *tweetResponse, NSError *error) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.remainingChars.text = [NSString stringWithFormat:@"%ld", [textView.text length]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return [[textView text] length] - range.length + text.length <= 140;
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
