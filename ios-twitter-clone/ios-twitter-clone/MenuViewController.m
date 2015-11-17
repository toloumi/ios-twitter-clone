//
//  MenuViewController.m
//  ios-twitter-clone
//
//  Created by  Minett on 11/16/15.
//  Copyright © 2015  Minett. All rights reserved.
//

#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "MentionsViewController.h"
#import "ProfileViewController.h"
#import "MenuCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UINavigationController *profileNavController;
@property (strong, nonatomic) UINavigationController *timelineNavController;
@property (strong, nonatomic) UINavigationController *mentionsNavController;
@property (strong, nonatomic) NSArray *menuNavControllers;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCellId"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TweetsViewController *tvc = [storyboard instantiateViewControllerWithIdentifier:@"TweetsViewController"];
    MentionsViewController *mtvc = [storyboard instantiateViewControllerWithIdentifier:@"MentionsViewController"];
    ProfileViewController *pvc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    self.profileNavController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileNavController"];
    [self.profileNavController setViewControllers:@[ pvc ] animated:YES];
    
    self.mentionsNavController = [storyboard instantiateViewControllerWithIdentifier:@"MentionsNavController"];
    [mtvc setupWithMentionsTimeline];
    [self.mentionsNavController setViewControllers:@[ mtvc ] animated:YES];
    
    self.timelineNavController = [storyboard instantiateViewControllerWithIdentifier:@"TimelineNavController"];
    [tvc setupWithHomeTimeline];
    [self.timelineNavController setViewControllers:@[ tvc ] animated:YES];
    
    self.menuNavControllers = @[self.profileNavController, self.timelineNavController, self.mentionsNavController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCellId"];
    
    if (cell) {
        cell.menuCellTitle.text = @[ @"Profile", @"Home Timeline", @"Mentions" ][indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.hamburgerViewController setContentViewController:self.menuNavControllers[indexPath.row]];
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
