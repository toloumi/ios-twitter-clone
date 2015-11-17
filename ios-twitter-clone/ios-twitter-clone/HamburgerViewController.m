//
//  HamburgerViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/16/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()
@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic, assign) CGFloat originalTableViewLeftMargin;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view layoutSubviews];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalTableViewLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalTableViewLeftMargin + translation.x;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
            if (velocity.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
            } else {
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        } completion:nil];
        
    }
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
    [self.view layoutIfNeeded];
    _menuViewController = menuViewController;
    
    if (self.menuView) {
        [self.menuView addSubview:self.menuViewController.view];
    }
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    [self.view layoutIfNeeded];
    _contentViewController = contentViewController;
    
    if (self.contentView) {
        [self.contentViewController willMoveToParentViewController:self];
        [self.contentView addSubview:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
        //self.navigationItem.title = self.contentViewController.navigationItem.title;
        //self.navigationItem.rightBarButtonItem = self.contentViewController.navigationItem.rightBarButtonItem;
        //self.navigationItem.leftBarButtonItem = self.contentViewController.navigationItem.leftBarButtonItem;
    }
    
    [self closeHamburgerMenu];
}

- (void)closeHamburgerMenu {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:nil];
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
