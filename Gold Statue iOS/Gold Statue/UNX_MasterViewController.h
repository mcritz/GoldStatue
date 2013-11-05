//
//  UNX_MasterViewController.h
//  Gold Statue
//
//  Created by Michael Critz on 11/3/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNX_Movie.h"

@class UNX_DetailViewController;

#import <CoreData/CoreData.h>

@interface UNX_MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UNX_DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
