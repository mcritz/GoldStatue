//
//  UNX_RankedTableCell.m
//  Gold Statue
//
//  Created by Michael Critz on 12/29/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import "UNX_RankedTableCell.h"

@interface UNX_RankedTableCell()

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
- (IBAction)titleEntered:(id)sender;
@end

@implementation UNX_RankedTableCell
@synthesize movie = _movie;
@synthesize rankLabel, titleLabel, titleInput, rowIsEditing;

// Override Setter
- (void)setMovie:(UNX_Movie *)movie {
// TODO: This
//    if (!_movie) {
//        _movie = [[UNX_Movie alloc] init];
//        _movie.title = @"Movie Title";
//    }
    _movie = movie;
    self.titleInput.text = movie.title;
    self.titleLabel.text = movie.title;
    NSString *rankString = [[movie valueForKey:@"rank"] stringValue];
    self.rankLabel.text = rankString;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleInput.delegate = self;
        self.rowIsEditing = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (!self.rowIsEditing) {
        [super setSelected:selected animated:animated];
        [self.titleLabel setHighlightedTextColor:[UIColor whiteColor]];
        if (selected) {
            self.titleInput.text = self.titleLabel.text;
    //        [self.titleInput setHidden:NO];
            [self.titleInput setSelected:YES];
            [self.rankLabel setAlpha:0.5];
    //        [self.titleLabel setHidden:YES];
        } else {
    //        [self.titleInput setHidden:YES];
            [self.titleInput setSelected:NO];
            [self.rankLabel setAlpha:1.0];
    //        [self.titleLabel setHidden:NO];
        }
    }
}

- (IBAction)titleEntered:(id)sender {
    if (self.movie && self.titleInput.text.length > 0) {
        self.movie.title = self.titleInput.text;
        self.titleLabel.text = self.movie.title;
    } else {
        NSString *titleLabelText = self.titleLabel.text;
        if (self.titleInput.text.length > 0) {
            titleLabelText = self.titleInput.text;
        }
        self.titleLabel.text = titleLabelText;
        NSLog(@"Title: %@", titleLabelText);
    }
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
