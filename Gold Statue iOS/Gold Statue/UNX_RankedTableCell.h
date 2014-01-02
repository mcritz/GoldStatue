//
//  UNX_RankedTableCell.h
//  Gold Statue
//
//  Created by Michael Critz on 12/29/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNX_Movie.h"

@interface UNX_RankedTableCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic)UNX_Movie *movie;

@end
