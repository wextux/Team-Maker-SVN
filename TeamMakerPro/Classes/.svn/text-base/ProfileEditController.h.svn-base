//
//  ProfileEditController.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-15.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"


@interface ProfileEditController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) Profile *profile;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *editableItems;
@property (strong, nonatomic) UITextField *txtNameField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profile:(Profile *)newProfile tabBarController:(UITabBarController *)newTabBarController;
- (IBAction)doneSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;

@end
