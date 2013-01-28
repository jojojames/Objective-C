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
@property (strong, nonatomic) Deck *deck; // holds the 52 cards
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@end

@implementation CardGameViewController

- (Deck *)deck {
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        //self.describeLabel.text = [NSString stringWithFormat:@"Matched %@", [self.game recentCard].contents];
        //self.describeLabel.text = [self.describeLabel.text stringByAppendingString:[self.game recentCard].contents];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    
    //self.describeLabel.text = [NSString stringWithFormat:@"Matched: %d", card.contents];
    
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    //sender.selected = !sender.isSelected;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


@end
