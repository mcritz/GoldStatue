//
//  UNX_RankedTableCell.h
//  Gold Statue
//
//  Created by Michael Critz on 12/29/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNX_RankedTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
- (IBAction)titleEntered:(id)sender;

@end
