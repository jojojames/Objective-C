//
//  SetCardDeck.m
//  Matchismo
//
//  Created by James Nguyen on 2/4/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    if(self) {
        for (NSUInteger symbol = 1; symbol <= [SetCard maxRank]; symbol++) {
            for (NSUInteger shading = 1; shading <= [SetCard maxRank]; shading++) {
                for (NSUInteger color = 1; color <= [SetCard maxRank]; color++) {
                    for (NSUInteger rank = 1; rank <= [SetCard maxRank]; rank++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        card.rank = rank;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
