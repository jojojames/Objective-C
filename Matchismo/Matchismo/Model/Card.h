//
//  Card.h
//  Matchismo
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString * contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;

@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int) match:(NSArray *)otherCards;

@end
