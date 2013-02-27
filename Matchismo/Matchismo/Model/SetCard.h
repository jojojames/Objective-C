//
//  SetCard.h
//  Matchismo
//
//  Created by James Nguyen on 2/4/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSymbols;
+ (NSArray *)validShading;
+ (NSArray *)validColors;
+ (NSUInteger)maxRank;

@end
