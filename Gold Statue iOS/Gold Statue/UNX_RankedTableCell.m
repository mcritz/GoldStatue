//
//  UNX_RankedTableCell.m
//  Gold Statue
//
//  Created by Michael Critz on 12/29/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import "UNX_RankedTableCell.h"

@interface UNX_RankedTableCell()

@property BOOL userIsEditing;

@end

@implementation UNX_RankedTableCell
@synthesize userIsEditing, rankLabel, titleLabel, titleInput;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleInput.delegate = self;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
    if (selected) {
        self.titleInput.text = self.titleLabel.text;
        [self.titleInput setHidden:NO];
        [self.titleInput setSelected:YES];
        [self.rankLabel setAlpha:0.5];
        [self.titleLabel setHidden:YES];
        self.userIsEditing = YES;
    } else {
        [self.titleInput setHidden:YES];
        [self.titleInput setSelected:NO];
        [self.rankLabel setAlpha:1.0];
        [self.titleLabel setHidden:NO];
        if (self.userIsEditing) {
//            [self titleEntered:self.titleInput];
            self.userIsEditing = NO;
        }
    }
}

- (IBAction)titleEntered:(id)sender {
    NSString *titleLabelText = self.titleLabel.text;
    if (self.titleInput.text.length > 0) {
        titleLabelText = self.titleInput.text;
    }
    self.titleLabel.text = titleLabelText;
    NSLog(@"Title: %@", titleLabelText);
}

#pragma mark - TextView protocol

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self setSelected:NO animated:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void)textWillChange:(id<UITextInput>)textInput {
    return;
}

- (void)textDidChange:(id<UITextInput>)textInput {
    return;
}

- (void)selectionWillChange:(id<UITextInput>)textInput {
    return;
}

- (void)selectionDidChange:(id<UITextInput>)textInput {
    return;
}

@end
