//
//  UNX_AppDelegate.h
//  Gold Statue
//
//  Created by Michael Critz on 11/3/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNX_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
