//
//  CardGameViewController.m
//  Matchismo
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel; // label of the flipCount
@property (nonatomic) int flipCount; // holds the count everytime a card is selected
@property (nonatomic) PlayingCardDeck *Deck; // holds the 52 cards
@end

@implementation CardGameViewController

@synthesize Deck = _Deck;
@synthesize display = _display;

// Getter with lazy instantiation
- (PlayingCardDeck *)Deck {
    if(!_Deck) {
        _Deck = [[PlayingCardDeck alloc] init];
    }
    return _Deck;
}

// Setter
- (void)setDeck:(PlayingCardDeck *)Deck {
    Deck = _Deck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
    // Set the display's title when the state is selected
    [self.display setTitle:[self.Deck drawRandomCard].contents forState:UIControlStateSelected];
}


@end
