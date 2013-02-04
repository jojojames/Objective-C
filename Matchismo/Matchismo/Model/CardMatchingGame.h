//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by James Nguyen on 1/26/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (Card *)popRecentCard;

- (int)recentPickCount;

- (void)removeLastPick;

- (bool)changeGameMode;

@property (nonatomic, readonly) int score;
@end
