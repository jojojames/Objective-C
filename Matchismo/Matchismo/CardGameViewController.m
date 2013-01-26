//
//  CardGameViewController.m
//  Matchismo
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCarddeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel; // label of the flipCount
@property (nonatomic) int flipCount; // holds the count everytime a card is selected
@property (nonatomic) Deck *deck; // holds the 52 cards
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end
@implementation CardGameViewController

@synthesize deck = _deck;
@synthesize display = _display;

// Getter with lazy instantiation
- (Deck *)deck {
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    for (UIButton *cardButton in cardButtons) {
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
    }
}

// Setter
- (void)setdeck:(Deck *)deck {
    deck = _deck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
    // Set the display's title when the state is selected
    
    
    //Card *card = [self.deck drawRandomCard];
    //[sender setTitle:card.contents forState:UIControlStateSelected];
}


@end
