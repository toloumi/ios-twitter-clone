//
//  ProfileViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/16/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userScreenName;
@property (strong, nonatomic) IBOutlet UILabel *tweetsCount;
@property (strong, nonatomic) IBOutlet UILabel *followersCount;
@property (strong, nonatomic) IBOutlet UILabel *followingCount;
@property (strong, nonatomic) IBOutlet UITextView *userDescription;

@property (strong, nonatomic) User *profileUser;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setProfileUser:self.profileUser];
    
    self.title = @"Profile";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOut)];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setProfileUser:(User *)profileUser {
    //Reset all info for the based on the profile user
    if (profileUser) {
        _profileUser = profileUser;
    } else {
        _profileUser = [User currentUser];
    }
    
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.profileUser.profileImageUrl]];
    self.userName.text = self.profileUser.name;
    self.userScreenName.text = [NSString stringWithFormat:@"@%@", self.profileUser.screenName];
    self.tweetsCount.text = [self.profileUser.tweetsCount stringValue];
    self.followersCount.text = [self.profileUser.followersCount stringValue];
    self.followingCount.text = [self.profileUser.followingCount stringValue];
    self.userDescription.text = self.profileUser.tagline;
}

- (void)onSignOut {
    [User logout];
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
