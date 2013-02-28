//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by James Nguyen on 1/26/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableArray *recentPicks;
@property (nonatomic) int score;
@property (nonatomic) bool threeCardGameMode;
@end

@implementation CardMatchingGame
@synthesize threeCardGameMode;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)recentPicks {
    if (!_recentPicks) _recentPicks = [[NSMutableArray alloc] init];
    return _recentPicks;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (Card *)popRecentCard {
    id lastCard = nil;
    if(self.recentPicks.count != 0) {
        lastCard = [self.recentPicks lastObject];
    }
    return lastCard;
}

- (int)recentPickCount {
    return [self.recentPicks count];
}

- (void)removeLastPick {
    if(self.recentPicks.count != 0) {
        [self.recentPicks removeLastObject];
    }
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    [self.recentPicks addObject:card];
    
    if (!card.isUnplayable) {
        if(!card.isFaceUp) {
            if(threeCardGameMode) {
                NSMutableArray *recentCardArray = [[NSMutableArray alloc] init];
                for(Card *otherCard in self.cards) {
                    if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [self.recentPicks addObject:otherCard];
                        [recentCardArray addObject:otherCard];
                    }
                }
                
                /* Wait until the third flip to flip cards back. */
                if(recentCardArray.count <= 1) {
                    card.faceUp = !card.isFaceUp;
                    return;
                }
                
                int matchScore = [card match:recentCardArray];
                
                /* If there's a score, set the cards to be unplayable. */
                if(matchScore) {
                    for(Card *pickedCards in recentCardArray) {
                        pickedCards.unplayable = YES;
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    /* Else, set the cards to be faced down. */
                } else {
                    for(Card *pickedCards in recentCardArray) {
                        pickedCards.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                }
                self.score -=FLIP_COST;
            } else {
                /* Two card game mode. */
                for (Card *otherCard in self.cards) {
                    if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                        [self.recentPicks addObject:otherCard];
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                        }
                        break;
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.isFaceUp;
        }
    }
}

- (void)gameMode:(BOOL)__gameMode {
    threeCardGameMode = __gameMode;
}

@end
