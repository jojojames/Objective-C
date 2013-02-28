//
//  SetCard.m
//  Matchismo
//
//  Created by James Nguyen on 2/4/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


- (int)match:(NSArray *)otherCards {
    // Only matches three cards so there's no need for a conditional.
    // 1. Same colors, same shading, same rank, same symbol
    // 2. Different colors, different shading, different rank, different symbol
    int score = 0;
    SetCard *firstOtherCard = [otherCards objectAtIndex:0];
    SetCard *secondOtherCard = [otherCards objectAtIndex:1];
    // If no matches, it'll return zero.
    score += [self checkColorsUsingCard:firstOtherCard and:secondOtherCard];
    score += [self checkShadingUsingCard:firstOtherCard and:secondOtherCard];
    score += [self checkRankUsingCard:firstOtherCard and:secondOtherCard];
    score += [self checkSymbolUsingCard:firstOtherCard and:secondOtherCard];
    if(score != 80) {
        return 0;
    } else {
        return score;
    }
}

- (int)checkColorsUsingCard:(SetCard *)firstOtherCard and:(SetCard *)secondOtherCard {
    int score = 0;
    if(firstOtherCard.color == secondOtherCard.color) {
        // similarity
        if(self.color == firstOtherCard.color) {
            score += 20;
        }
    }

    if(firstOtherCard.color != secondOtherCard.color) {
        if(self.color != firstOtherCard.color && self.color != secondOtherCard.color) {
            // differences
            score += 20;
        }
    }
    return score;
}

- (int)checkShadingUsingCard:(SetCard *)firstOtherCard and:(SetCard *)secondOtherCard {
    int score = 0;

    if(firstOtherCard.shading == secondOtherCard.shading) {
        // similarity
        if(self.shading == firstOtherCard.shading) {
            score += 20;
        }
    }

    if(firstOtherCard.shading != secondOtherCard.shading) {
        if(self.shading != firstOtherCard.shading && self.shading != secondOtherCard.shading) {
            // differences
            score += 20;
        }
    }

    return score;

}

- (int)checkRankUsingCard:(SetCard *)firstOtherCard and:(SetCard *)secondOtherCard {
    int score = 0;
    if(firstOtherCard.rank == secondOtherCard.rank) {
        // similarity
        if(self.rank == firstOtherCard.rank) {
            score += 20;
        }
    }

    if(firstOtherCard.rank != secondOtherCard.rank) {
        if(self.rank != firstOtherCard.rank && self.rank != secondOtherCard.rank) {
            // differences
            score += 20;
        }
    }
    return score;

}

- (int)checkSymbolUsingCard:(SetCard *)firstOtherCard and:(SetCard *)secondOtherCard {
    int score = 0;
    if(firstOtherCard.symbol == secondOtherCard.symbol) {
        // similarity
        if(self.symbol == firstOtherCard.symbol) {
            score += 20;
        }
    }

    if(firstOtherCard.symbol != secondOtherCard.symbol) {
        if(self.symbol != firstOtherCard.symbol && self.symbol != secondOtherCard.symbol) {
            // differences
            score += 20;
        }
    }
    return score;
}


- (NSString *)contents {
    // implement later || don't need to implement
    return @""; // delete this later
}

+ (NSArray *)validSymbols {
    //return @[@"▲",@"●",@"■"];
    return @[@1,@2,@3];
}

+ (NSArray *)validShading {
    //return @[@"Striped",@"Open",@"Solid"];
    return @[@1,@2,@3];
}

+ (NSArray *)validColors {
    //return @[@"Red",@"Green",@"Purple"];
    return @[@1,@2,@3];
}

+ (NSArray *)rankStrings {
    //return @[@"1",@"2",@"3"];
    return @[@1,@2,@3];
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count;
}

- (void)setSymbol:(NSUInteger)symbol {
    if(symbol <= [SetCard maxRank]) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSUInteger)shading {
    if(shading <= [SetCard maxRank]) {
        _shading = shading;
    }
}

- (void)setColor:(NSUInteger)color {
    if(color <= [SetCard maxRank]) {
        _color = color;
    }
}

- (void)setRank:(NSUInteger)rank {
    if(rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

@end
