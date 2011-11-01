//
//  DetailViewController.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-04.
//  Copyright 2011 Superna. All rights reserved.
//

#import "DetailViewController.h"
#import "MGSplitCornersView.h"
#import "MasterViewController.h"
#import "TeamModalViewController.h"
#import "TeamViewController.h"
#import "Randomizer.h"
#import "Team.h"
#import "Profile.h"
#import "CreateTeamsAlertView.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *popoverController;
- (void)configureView;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)saveContext:(NSManagedObjectContext *)context;
@end

@implementation DetailViewController
@synthesize toolbar = _toolbar;
@synthesize teams = _teams;
@synthesize profile = _profile;
@synthesize popoverController = _myPopoverController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize playerFetchedResultsController = __playerFetchedResultsController;
@synthesize profileFetchedResultsController = __profileFetchedResultsController;
@synthesize searchBar;
@synthesize togglePlayersBarItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Teams", @"Teams");
        self.managedObjectContext = context;
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)configureView
{

	togglePlayersBarItem.title = ([splitController isShowingMaster]) ? @"Hide Players" : @"Show Players";
//	verticalItem.title = (splitController.vertical) ? @"Horizontal Split" : @"Vertical Split";
//	dividerStyleItem.title = (splitController.dividerStyle == MGSplitViewDividerStyleThin) ? @"Enable Dragging" : @"Disable Dragging";
//	masterBeforeDetailItem.title = (splitController.masterBeforeDetail) ? @"Detail First" : @"Master First";
//    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    


    UIBarButtonItem *createTeams = [[UIBarButtonItem alloc] initWithTitle:@"Create Teams" style:UIBarButtonItemStylePlain target:self action:@selector(createTeams)];
    
    self.navigationItem.rightBarButtonItem = createTeams;


    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        togglePlayersBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Hide Players" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMasterView:)];
        
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:togglePlayersBarItem, nil];
        [self toggleMasterView:self.togglePlayersBarItem];
        
    } else {
        
    }
    
    
    

    [self configureView];
    
    /*
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _scrollView.maximumZoomScale = 4.0;
    _scrollView.minimumZoomScale = 0.75;
    _scrollView.scrollEnabled = YES;
    _scrollView.clipsToBounds = YES;
    _scrollView.delegate = self;
    */
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:@"green_background"]]];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[self.profileFetchedResultsController fetchedObjects] count] >= 1) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
//}




#pragma mark - Table View Protocol Methods 

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.profileFetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [self.profileFetchedResultsController.fetchedObjects count];//[_fetchedObjects count];//[sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Profile *profile = [self.profileFetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", profile.name];

}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.profileFetchedResultsController managedObjectContext];
        [context deleteObject:[self.profileFetchedResultsController objectAtIndexPath:indexPath]];
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
    
    //    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Profile *selectedProfile = [[self profileFetchedResultsController] objectAtIndexPath:indexPath];
        
    TeamViewController *teamViewController = [[TeamViewController alloc] initWithNibName:@"TeamViewController" bundle:nil profile:selectedProfile];
    
    teamViewController.managedObjectContext = self.managedObjectContext;

    [self.navigationController pushViewController:teamViewController animated:YES];

}


- (NSIndexPath *)tableView :(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    /*[_searchBar resignFirstResponder];
    [tv becomeFirstResponder];
    
    if (selectable) {
        return indexPath;
    } else {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addressBookUI:)];
        self.navigationItem.rightBarButtonItem = addButton;
        selectable = YES;
        return nil;
    } */
    
    return indexPath;
    
}   

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [cell setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed: @"green_background.png"]]];
//}



#pragma mark - Split view support


- (void)splitViewController:(MGSplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController: (UIPopoverController*)pc
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	/*
	if (barButtonItem) {
		barButtonItem.title = @"Popover";
		NSMutableArray *items = [[toolbar items] mutableCopy];
		[items insertObject:barButtonItem atIndex:0];
		[toolbar setItems:items animated:YES];
	}*/
    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	/*
	if (barButtonItem) {
		NSMutableArray *items = [[toolbar items] mutableCopy];
		[items removeObject:barButtonItem];
		[toolbar setItems:items animated:YES];
	}*/
    self.popoverController = nil;
}


- (void)splitViewController:(MGSplitViewController*)svc 
		  popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}

#pragma mark - CreateTeamsAlertView Protocol Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
    
    if (buttonIndex == 1) {
        Randomizer *randomizer = [[Randomizer alloc] init];
        
        NSArray *players = [[self playerFetchedResultsController] fetchedObjects];
        
        NSArray *teams = [randomizer createTeamsWithPlayers:players numberOfPlayersPerTeam:[[(CreateTeamsAlertView *)alertView enteredText] intValue] intoContext:self.managedObjectContext];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
        
        Profile *profile = [[Profile alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        
        profile.name = @"New Profile";
        profile.dateCreated = [NSDate date];
        profile.teams = [NSSet setWithArray:teams];
        
        _profile = profile;
        _teams = teams;
        
        [self saveContext:self.managedObjectContext];

    } else {
        
    }
    
    
}


- (void)alertViewCancel:(UIAlertView *)alertView 
{
    
}



#pragma mark - Actions

- (void)createTeams {
    CreateTeamsAlertView *teamsAlertView = [[CreateTeamsAlertView alloc] initWithTitle:@"Players per Team:" message:@"\t\t\t\t\t\t" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Create"];
    [teamsAlertView show];
    
}


- (void)showModelTeamView:(Team *)team {

    TeamModalViewController *teamModalViewController = [[TeamModalViewController alloc] initWithNibName:@"TeamModalViewController" bundle:nil];
    teamModalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    teamModalViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;  //transition shouldn't matter
    [self presentModalViewController:teamModalViewController animated:YES];
    teamModalViewController.view.superview.frame = CGRectMake(0,0, 500, 410);//it's important to do this after presentModalViewController
    teamModalViewController.view.superview.center = splitController.view.center;


    //Team *team = [_teams objectAtIndex:indexPath.row];
    
    NSMutableArray *players = [[NSMutableArray alloc] init];
    
    for (Player *player in team.players) {
        [players addObject:player];
    }
    
    
    teamModalViewController.teamNameLabel.text = team.name;
    teamModalViewController.players = players;
}


- (IBAction)toggleMasterView:(id)sender
{
    NSLog(@"Toggle");
	[splitController toggleMasterView:sender];
	[self configureView];
}


- (IBAction)toggleVertical:(id)sender
{
    NSLog(@"Verticle");
	[splitController toggleSplitOrientation:self];
	[self configureView];
}


- (IBAction)toggleDividerStyle:(id)sender
{
    NSLog(@"Divider");
	MGSplitViewDividerStyle newStyle = ((splitController.dividerStyle == MGSplitViewDividerStyleThin) ? MGSplitViewDividerStylePaneSplitter : MGSplitViewDividerStyleThin);
	[splitController setDividerStyle:newStyle animated:YES];
	[self configureView];
}


- (IBAction)toggleMasterBeforeDetail:(id)sender
{
    NSLog(@"Switch");
	[splitController toggleMasterBeforeDetail:sender];
	[self configureView];
}


#pragma mark -
#pragma mark Rotation support


// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self configureView];
}




#pragma mark - Fetched results controller


- (BOOL)saveContext:(NSManagedObjectContext *)context
{
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return YES;
}



- (NSFetchedResultsController *)playerFetchedResultsController
{
    if (__playerFetchedResultsController != nil)
    {
        return __playerFetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *numberSD = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:numberSD, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.playerFetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.playerFetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __playerFetchedResultsController;
}

- (NSFetchedResultsController *)profileFetchedResultsController
{
    if (__profileFetchedResultsController != nil)
    {
        return __profileFetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *dateSD = [[NSSortDescriptor alloc] initWithKey:@"dateCreated" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:dateSD, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.profileFetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.profileFetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __profileFetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == __profileFetchedResultsController)
        [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (controller == __profileFetchedResultsController) {
        switch(type)
        {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                break;
                
            case NSFetchedResultsChangeDelete:
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
                break;
        }     
    }  
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{

    if (controller == __profileFetchedResultsController) {
        UITableView *tableView = self.tableView;
        
        switch(type)
        {
                
            case NSFetchedResultsChangeInsert:
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
                
            case NSFetchedResultsChangeDelete:
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
                
            case NSFetchedResultsChangeUpdate:
                [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
                break;
                
            case NSFetchedResultsChangeMove:
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
                break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == __profileFetchedResultsController)
        [self.tableView endUpdates];
}


@end
