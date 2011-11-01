//
//  TeamViewController.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-11.
//  Copyright (c) 2011 Superna. All rights reserved.
//

#import "TeamViewController.h"
#import "PlayersViewController.h"
#import "ProfileEditController.h"
#import "Team.h"
#import "Profile.h"
#import "TeamCell.h"


@interface TeamViewController () 

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation TeamViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize profile = _profile;
@synthesize teams, teamCell;
@synthesize cellNib;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil profile:(Profile *)newProfile
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _profile = newProfile;
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES]; 
        self.teams = [_profile.teams sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
        self.title = _profile.name;
    }
    return self;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.cellNib = [UINib nibWithNibName:@"TeamCell_iPhone" bundle:nil];
    } else {
        self.cellNib = [UINib nibWithNibName:@"TeamCell_iPad" bundle:nil];
    }
    
    
    UIBarButtonItem *editProfile = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editProfile:)];
    self.navigationItem.rightBarButtonItem = editProfile;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    self.title = _profile.name;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 80;
    } else {
        Team *team = [self.teams objectAtIndex:indexPath.row];
        return ((44 * [team.players count]) > 210) ? (44 * [team.players count]) : 210;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (_profile != nil) ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    
    TeamCell *cell = (TeamCell *)[tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = teamCell;

    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Display dark and light background in alternate rows -- see tableView:willDisplayCell:forRowAtIndexPath:.
    cell.useDarkBackground = YES;//(indexPath.row % 2 == 0);
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)configureCell:(TeamCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    Team *team = [self.teams objectAtIndex:indexPath.row];
    cell.teamNameLabel.text = team.name;
    //[cell.logoImage setImage:team.thumbnailPic];
    [cell.logoImage setImage:[UIImage imageNamed:@"icon"]];
    cell.numOfPlayersLabel.text = [NSString stringWithFormat:@"%d Players",[team.players count]];
    NSSortDescriptor *lastNameSD = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *firstNameSD = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    cell.players = [team.players sortedArrayUsingDescriptors:[NSArray arrayWithObjects:lastNameSD, firstNameSD, nil]];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        Team *team = [self.teams objectAtIndex:indexPath.row];
        
        PlayersViewController *playersViewController = [[PlayersViewController alloc] initWithNibName:@"PlayersViewController" bundle:nil team:team];
        
        [self.navigationController pushViewController:playersViewController animated:YES];
    } else {
        
    }


}




#pragma mark - Managed Object Context Support


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



#pragma mark - Actions

- (IBAction)editProfile:(id)sender {
    ProfileEditController *profileEditController = [[ProfileEditController alloc] initWithNibName:@"ProfileEditController" bundle:nil profile:_profile tabBarController:self.tabBarController];
    
    profileEditController.managedObjectContext = self.managedObjectContext;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {    
        //profileEditController.modalPresentationStyle = UIModalPresentationFormSheet;
        profileEditController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

        [self.tabBarController presentModalViewController:profileEditController animated:YES];
    } else {
        profileEditController.modalPresentationStyle = UIModalPresentationFormSheet;
        profileEditController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        [self presentModalViewController:profileEditController animated:YES];
    }
    
}



@end
