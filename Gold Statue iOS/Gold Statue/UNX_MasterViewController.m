//
//  UNX_MasterViewController.m
//  Gold Statue
//
//  Created by Michael Critz on 11/3/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import "UNX_MasterViewController.h"
#import "UNX_DetailViewController.h"

@interface UNX_MasterViewController ()
- (void)configureCell:(UNX_RankedTableCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)insertNewObject:(NSString *)movieTitle;
@property BOOL isUpdatingList;
@end

@implementation UNX_MasterViewController

@synthesize isUpdatingList;

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (
        action == @selector(addMovie)
        ) {
        return YES;
    }
    return NO;
}


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMovie)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (UNX_DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(NSString *)movieTitle
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    UNX_Movie *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    [newManagedObject setValue:@([self.tableView numberOfRowsInSection:0] + 1) forKey:@"rank"];
    [newManagedObject setValue:movieTitle forKey:@"title"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)addMovie
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Favorite Movie" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 || [[[alertView textFieldAtIndex:0] text] isEqualToString:@""]) {
        return;
    }
//    self.isUpdatingList = YES;
//    [self updateMovieRank];
    [self insertNewObject:[[alertView textFieldAtIndex:0] text]];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UNX_RankedTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankedCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self updateMovieRanksFromPath:indexPath toPath:nil];
    }
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Movie" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rank" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSLog(@"didChangeSection");
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            break;
        default:
            NSLog(@"WARNING: didChangeSection had no effect");
#pragma TODO: NOT THIS!
            abort();
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(UNX_RankedTableCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            NSLog(@"WARNING: didChangeObject() had no effect!");
#pragma TODO: NOT THIS!
            abort();
            break;
    }
    [self.managedObjectContext save:nil];
}

- (void)updateMovieRanksFromPath:(NSIndexPath *)oldPath toPath:(NSIndexPath *)newPath
{
    // Need an array to play with
    NSMutableArray *movieArray = [self.fetchedResultsController.fetchedObjects mutableCopy];
    
    UNX_Movie *movieToUpdate = [movieArray objectAtIndex:oldPath.row];
    [movieArray removeObject:movieToUpdate];
    
    if (newPath) {
        [movieArray insertObject:movieToUpdate atIndex:newPath.row];
        UNX_RankedTableCell *cellToUpdate = (UNX_RankedTableCell *)[self.tableView cellForRowAtIndexPath:newPath];
        [self configureCell:cellToUpdate atIndexPath:newPath];
    } else {
        // No newPath: delete movie from MoM, update the table
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:oldPath]];
    }
    
    // iterate over all the managedobjects and assign their new ranks
    int i = 1; // 1 indexed because my favorite movie is #1!
    for (NSManagedObject *managedMovie in movieArray) {
        [managedMovie setValue:@(i++) forKey:@"rank"];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UNX_RankedTableCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UNX_Movie *movie = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.titleLabel.text = [movie valueForKey:@"title"];
//    cell.rankLabel.text = [[movie valueForKey:@"rank"] stringValue];
    cell.movie = movie;
}

- (void)updateMovie:(UNX_Movie *)movie atIndexPath:(NSIndexPath *)indexPath {
    UNX_Movie *oldMovie = [self.fetchedResultsController objectAtIndexPath:indexPath];
    oldMovie.rank = movie.rank;
    oldMovie.title = movie.title;
}

#pragma mark - Table View Editing

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self updateMovieRanksFromPath:fromIndexPath toPath:toIndexPath];
}

@end
