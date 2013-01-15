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
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
//
@property (nonatomic) PlayingCardDeck *Deck;
//
@end

@implementation CardGameViewController

@synthesize Deck = _Deck;

- (PlayingCardDeck *)Deck {
    if(!_Deck) {
        _Deck = [[PlayingCardDeck alloc] init];
    }
    return _Deck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flipCount++;
}


@end
