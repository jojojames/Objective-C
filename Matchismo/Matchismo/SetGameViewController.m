//
//  SetGameViewController.m
//  Matchismo
//
//  Created by James Nguyen on 2/3/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int oldScore;
@property (strong, nonatomic) NSMutableAttributedString *cardProperties;
@property (strong, nonatomic) NSMutableArray *recentCardProperties;
@property (nonatomic) int flipCount;
@property (nonatomic) bool threeCardGameMode;
@end

@implementation SetGameViewController
@synthesize cardProperties;
@synthesize oldScore;
@synthesize threeCardGameMode;

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (NSMutableArray *)recentCardProperties {
    if(!_recentCardProperties) _recentCardProperties = [[NSMutableArray alloc] init];
    return _recentCardProperties;
}

/* Override the default implemenation to use Attributed Strings instead. */
- (void)setCardContents:(UIButton *)cardButton using:(SetCard *)card {
    NSAttributedString *defaultAttributedString;
    if (card.symbol == 1) {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"▲"];
        defaultAttributedString = [[NSAttributedString alloc] initWithString:@"▲"];
          //return @[@"▲",@"●",@"■"];
    } else if (card.symbol == 2) {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"●"];
        defaultAttributedString = [[NSAttributedString alloc] initWithString:@"●"];
    } else {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"■"];
        defaultAttributedString = [[NSAttributedString alloc] initWithString:@"■"];
    }
    [self setCardBasedOnRank:cardProperties on:card with:defaultAttributedString];
    UIColor *colorForStroke = [self setCardColors:card];
    [self setCardShading:colorForStroke on:card];
    
    [cardButton setAttributedTitle:cardProperties forState:UIControlStateNormal];
    [cardButton setAttributedTitle:cardProperties forState:UIControlStateSelected|UIControlStateDisabled];
    [cardButton setAttributedTitle:cardProperties forState:UIControlStateHighlighted];
    
}

- (NSMutableAttributedString *)getCardProperties:(SetCard *)card {
    //use the same function as setCardContents but return the attributedstring
    NSMutableAttributedString *defaultAttributedString;
    if (card.symbol == 1) {
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"▲"];
        //return @[@"▲",@"●",@"■"];
    } else if (card.symbol == 2) {
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"●"];
    } else {
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"■"];
    }
    
    [self settingAttributedStringRank:defaultAttributedString using:card];
    UIColor * colorForStroke = [self setCardColors:card];
    [self settingAttributedStringShading:defaultAttributedString using:card withColor:colorForStroke];
    return defaultAttributedString;
}

- (void)settingAttributedStringRank:(NSMutableAttributedString *)_attributedString using:(SetCard *)card {
    for(int i=1; i<card.rank; i++) [_attributedString appendAttributedString:_attributedString];
}

- (void)settingAttributedStringShading:(NSMutableAttributedString *)_attributedString using:(SetCard *)card withColor:(UIColor *)colorForStroke {
    // striped open solid
    if (card.shading == 1) {
        [_attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange((0), card.rank)];
    } else if (card.shading == 2) {
        [_attributedString addAttribute:NSStrokeColorAttributeName value:colorForStroke range:NSMakeRange((0), card.rank)];
        [_attributedString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, card.rank)];
    } else {
        // do nothing, it's solid
    }
}

- (void)setCardButtonBackground:(UIButton *)cardButton {
    // Don't set a background yet. Might have to set one when a card is selected.
}

- (void)setCardBasedOnRank:(NSMutableAttributedString *)cardProperties on:(SetCard *)card with:(NSAttributedString *) defaultAttributedString {
   for (int i=1; i<card.rank; i++) [self.cardProperties appendAttributedString:defaultAttributedString];
}

- (UIColor *)setCardColors:(SetCard *)card {
    // red green purple
    UIColor *colorForStroke;
    if (card.color == 1) {
        //[cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,card.rank)];
        [self.cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange((0), card.rank)];
        colorForStroke = [UIColor redColor];
    } else if (card.color == 2) {
        //[cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,card.rank)];
        [self.cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,card.rank)];
        colorForStroke = [UIColor greenColor];
    } else {
        //[cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,card.rank)];
        [self.cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,card.rank)];
        colorForStroke = [UIColor purpleColor];
    }
    return colorForStroke; // this color is used for later to determine other attributes
    
}

- (void)setCardShading:(UIColor *)colorForStroke on:(SetCard *)card {
    // striped open solid
    if (card.shading == 1) {
        [self.cardProperties addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange((0), card.rank)];
    } else if (card.shading == 2) {
        [self.cardProperties addAttribute:NSStrokeColorAttributeName value:colorForStroke range:NSMakeRange((0), card.rank)];
        [self.cardProperties addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, card.rank)];
    } else {
        // do nothing, it's solid
    }
}

- (Deck *)chooseDeck {
    return [[SetCardDeck alloc] init];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
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

/* Describes the state of the game if the game mode is for matching three cards.  LOOK AT THIS PART*/
- (void)describeGameState {
    if([self.game recentPickCount] == 1) {
        SetCard *card = (SetCard *)[self.game popRecentCard]; // casting to SetCard
        NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:@"You picked "];
        [tempString appendAttributedString:[self getCardProperties:card]];
        self.describeLabel.attributedText = tempString;

        
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

- (IBAction)dealPressed:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self chooseDeck]];
    
    self.flipCount = 0;
    self.describeLabel.text = [NSString stringWithFormat:@""];
    NSMutableAttributedString *emptyString = [[NSMutableAttributedString alloc] initWithString:@""];
    self.describeLabel.attributedText = emptyString;
    [[self recentCardProperties] removeAllObjects];
    threeCardGameMode = YES;
    
    [self updateUI];
}


@end