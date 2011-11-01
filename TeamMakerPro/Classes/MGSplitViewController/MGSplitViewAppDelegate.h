//
//  MGSplitViewAppDelegate.h
//  MGSplitView
//
//  Created by Matt Gemmell on 26/07/2010.
//  Copyright Instinctive Code 2010.
//

#import <UIKit/UIKit.h>

@class MasterViewController;
@class DetailViewController;
@class MGSplitViewController;

@interface MGSplitViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MGSplitViewController *splitViewController;
    MasterViewController *masterViewController;
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MGSplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet MasterViewController *masterViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
