//
//  UNX_DetailViewController.h
//  Gold Statue
//
//  Created by Michael Critz on 11/3/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNX_DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@end
