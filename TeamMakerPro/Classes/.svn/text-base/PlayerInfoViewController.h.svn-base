//
//  PlayerInfoViewController.h
//  TeamMakerPro
//
//  Created by Ben Fairclough on 11-08-06.
//  Copyright 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerInfoViewController : UIViewController <UITableViewDelegate, UINavigationControllerDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    
    BOOL isCanceling;
}

@property (strong, nonatomic) NSArray *attributes;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIButton *imageView;
@property (strong, nonatomic) UIImage *thumbnailImage;

@property (strong, nonatomic) UITextField *txtFirstName;
@property (strong, nonatomic) UITextField *txtLastName;
@property (strong, nonatomic) UITextField *txtEmail;
@property (strong, nonatomic) UITextField *txtHandicap;
@property (strong, nonatomic) UITextField *txtBirthday;

@property (strong, nonatomic) UIPopoverController *surroundingPopoverController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Player *player;

- (void)savePlayer;
- (IBAction)cancelAction:(id)sender;
- (IBAction)chooseImage:(id)sender;

@end
