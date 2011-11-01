//
//  TeamMakerProAppDelegate.h
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-04.
//  Copyright 2011 Superna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGSplitViewController;
@class MasterViewController;
@class DetailViewController;

@interface TeamMakerProAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet MGSplitViewController *splitViewController;
@property (nonatomic, strong) IBOutlet MasterViewController *masterViewController;
@property (nonatomic, strong) IBOutlet DetailViewController *detailViewController;

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UINavigationController *teamsNavigationController;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
