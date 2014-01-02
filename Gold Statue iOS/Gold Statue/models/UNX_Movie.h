//
//  UNX_Movie.h
//  Gold Statue
//
//  Created by Michael Critz on 11/4/13.
//  Copyright (c) 2013 Map of the Unexplored. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol UNXMovieDelegate <NSObject>
//
//// @optional
//- (void)updateMovieWithRank:(int)rank andTitle:(NSString *)title;
//
//@end

@interface UNX_Movie : NSManagedObject {
//    id <UNXMovieDelegate> delegate;
}

@property (nonatomic) NSString *title;
@property int rank;

@end
