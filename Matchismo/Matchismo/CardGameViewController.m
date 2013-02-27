//
//  CardGameViewController.m
//  Matchismo
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel; // label of the flipCount
@property (nonatomic) int flipCount; // holds the count everytime a card is selected
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (nonatomic) int oldScore;
@property (nonatomic) bool threeCardGameMode;
@end

@implementation CardGameViewController
@synthesize oldScore;
@synthesize threeCardGameMode;

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    //UIImage *cardBackImage = [UIImage imageNamed:@"jojoback.jpg"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [self setCardContents:cardButton using:card];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        // set the back of the card
        [self setCardButtonBackground:cardButton];
        
    }
    [self describeGameState];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setCardButtonBackground:(UIButton *)cardButton {
    UIImage *cardBackImage = [UIImage imageNamed:@"defaultbackimage.png"];
    if(cardButton.isSelected) {
        [cardButton setImage:nil forState:UIControlStateNormal];
    } else {
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
    }
}

- (void)setCardContents:(UIButton *)cardButton using:(Card *)card {
    [cardButton setTitle:card.contents forState:UIControlStateSelected];
    [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
}

- (void)describeGameState {
    if([self.game recentPickCount] == 1) {
        self.describeLabel.text = [NSString stringWithFormat:@"Flipped up %@", [self.game popRecentCard].contents];
        [self.game removeLastPick];
    } else if ([self.game recentPickCount] == 2) {
        int amountIncreased = self.game.score - oldScore;
        if(oldScore < self.game.score) {
            self.describeLabel.text = [NSString stringWithFormat:@"Matched %@", [self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:@" for "];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[NSString stringWithFormat:@"%i", amountIncreased]];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:@" points!"];
        } else if (oldScore > self.game.score) {
            self.describeLabel.text = [NSString stringWithFormat:@"Didn't Match %@", [self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
        }
    }
}

/* Describes the state of the game if the game mode is for matching three cards. , obsolete in this file*/
- (void)threeCardDescribeGameState {
    if([self.game recentPickCount] == 1) {
        self.describeLabel.text = [NSString stringWithFormat:@"Flipped up %@", [self.game popRecentCard].contents];
        [self.game removeLastPick];
    } else if ([self.game recentPickCount] == 2) {
        self.describeLabel.text = [NSString stringWithFormat:@"Flipped up %@ and ", [self.game popRecentCard].contents];
        [self.game removeLastPick];
        self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
        [self.game removeLastPick];
    } else if ([self.game recentPickCount] == 3) {
        if(oldScore < self.game.score) {
            int amountIncreased = self.game.score - oldScore;
            self.describeLabel.text = [NSString stringWithFormat:@"Matched %@", [self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:@" for "];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[NSString stringWithFormat:@"%i", amountIncreased]];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:@" points!"];
        } else {
            self.describeLabel.text = [NSString stringWithFormat:@"Didn't matched %@", [self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
            self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game popRecentCard].contents];
            [self.game removeLastPick];
        }
    }
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    oldScore = [self.game score];
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

/* Allocate a new deck and allocate a new CardMatchingGame, 
 cardButtons do not need to be reallocated because the number of cards are the same throughout. 
 The game always starts out as two card mode. */
- (IBAction)dealPressed:(UIButton *)sender {
    //self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self chooseDeck]];
    
    self.flipCount = 0;
    self.describeLabel.text = [NSString stringWithFormat:@""];
    threeCardGameMode = NO;
    [self updateUI];
}

- (Deck *)chooseDeck {
    return [[PlayingCardDeck alloc] init];
}


@end
