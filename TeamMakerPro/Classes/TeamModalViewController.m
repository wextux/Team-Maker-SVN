//
//  TeamModalViewController.m
//  TeamMakerPro
//
//  Created by Will Fairclough on 11-08-05.
//  Copyright 2011 Superna. All rights reserved.
//

#import "TeamModalViewController.h"
#import "Player.h"


@implementation TeamModalViewController
@synthesize tableView = _tableView;
@synthesize teamNameLabel, teamScoreLabel, imageView;
@synthesize players = _players;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Team", @"Team");
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    CGFloat red = 146.0f/255.0f;
//    CGFloat green = 160.0f/255.0f;
//    CGFloat blue = 171.0f/255.0f;
//    
//
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 20)];
//    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(XXX, YYY, XXX, YYY)];
//    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 20)];
//    [labelView setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];
//    [labelView setTextColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
//    labelView.text = @"Players";
//    [headerView addSubview:labelView];
//
//    self.tableView.tableHeaderView = headerView;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table View delegate Methods

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        Player *player = [_players objectAtIndex:indexPath.row];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName];
    }
    
    // Configure the cell.
    
    return cell;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return _players.count;//[_fetchedObjects count];//[sectionInfo numberOfObjects];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (NSIndexPath *)tableView :(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    return indexPath;
}   

#pragma mark Actions

- (IBAction)donePressed:(id)sender {
    [self dismissModalViewControllerAnimated:UIModalTransitionStyleFlipHorizontal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
