//
//  UNX_RankedTableCell.m
//  Gold Statue
//
//  Created by Michael Critz on 12/29/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import "UNX_RankedTableCell.h"

@implementation UNX_RankedTableCell

@synthesize rankLabel, titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
