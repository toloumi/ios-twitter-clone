//
//  LoginViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/9/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            TweetsViewController *tweetsController = [storyboard instantiateViewControllerWithIdentifier:@"TweetsViewController"];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tweetsController];
            [self presentViewController:nvc animated:YES completion:nil];
        } else {
            // Present error view
            NSLog(@"Got user completion with error");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
