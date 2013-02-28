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
@synthesize describeLabel;
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
    NSMutableAttributedString *defaultAttributedString;
    if (card.symbol == 1) {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"▲"];
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"▲"];
          //return @[@"▲",@"●",@"■"];
    } else if (card.symbol == 2) {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"●"];
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"●"];
    } else {
        cardProperties = [[NSMutableAttributedString alloc] initWithString:@"■"];
        defaultAttributedString = [[NSMutableAttributedString alloc] initWithString:@"■"];
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
    UIColor * colorForStroke = [self changeColorProperty:card using:defaultAttributedString];
    [self settingAttributedStringShading:defaultAttributedString using:card withColor:colorForStroke];
    return defaultAttributedString;
}

- (void)settingAttributedStringRank:(NSMutableAttributedString *)_attributedString using:(SetCard *)card {
    NSMutableAttributedString *duplicateString = [[NSMutableAttributedString alloc] initWithAttributedString:_attributedString];
    for(int i=1; i<card.rank; i++) [_attributedString appendAttributedString:duplicateString];
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

- (void)setCardBasedOnRank:(NSMutableAttributedString *)cardProperties on:(SetCard *)card with:(NSMutableAttributedString *) defaultAttributedString {
    NSMutableAttributedString * duplicateString = defaultAttributedString;
   for (int i=1; i<card.rank; i++) [self.cardProperties appendAttributedString:duplicateString];
}

/* Contributes to attributed string's color. */
- (UIColor *)changeColorProperty:(SetCard *)card using:(NSMutableAttributedString *)_attributedString {
    UIColor *colorForStroke;
    if(card.color == 1) {
        [_attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange((0), card.rank)];
        colorForStroke = [UIColor redColor];
    } else if (card.color == 2) {
        [_attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,card.rank)];
        colorForStroke = [UIColor greenColor];
    } else {
        [_attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,card.rank)];
        colorForStroke = [UIColor purpleColor];
    }
    return colorForStroke;
}

/* Set the color of the card's symbol. */
- (UIColor *)setCardColors:(SetCard *)card {
    // red green purple
    UIColor *colorForStroke;
    if (card.color == 1) {
        [self.cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange((0), card.rank)];
        colorForStroke = [UIColor redColor];
    } else if (card.color == 2) {
        [self.cardProperties addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,card.rank)];
        colorForStroke = [UIColor greenColor];
    } else {
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
    [super updateUI];
}

/* Describes the state of the game if the game mode is for matching three cards.  LOOK AT THIS PART*/
- (void)describeGameState {
    if([self.game recentPickCount] == 1) {
        SetCard *card = (SetCard *)[self.game popRecentCard]; // casting to SetCard
        NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:@"You picked "];
        [tempString appendAttributedString:[self getCardProperties:card]];
        self.describeLabel.attributedText = tempString;
        [self.game removeLastPick];
    } else if ([self.game recentPickCount] == 2) {
        SetCard *cardOne = (SetCard *) [self.game popRecentCard];
        [self.game removeLastPick];
        SetCard *cardTwo = (SetCard *) [self.game popRecentCard];
        [self.game removeLastPick];
        NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:@"You picked "];
        [tempString appendAttributedString:[self getCardProperties:cardOne]];
        NSMutableAttributedString *andString = [[NSMutableAttributedString alloc] initWithString:@" and "];
        [tempString appendAttributedString:andString];
        [tempString appendAttributedString:[self getCardProperties:cardTwo]];
        self.describeLabel.attributedText = tempString;
    } else if ([self.game recentPickCount] == 3) {
        SetCard * cardOne = (SetCard *) [self.game popRecentCard];
        [self.game removeLastPick];
        SetCard * cardTwo = (SetCard *) [self.game popRecentCard];
        [self.game removeLastPick];
        SetCard * cardThree = (SetCard *) [self.game popRecentCard];
        [self.game removeLastPick];
        if(oldScore < self.game.score) {
            // user got the match
            NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [tempString appendAttributedString:[self getCardProperties:cardOne]];
            NSMutableAttributedString *comma = [[NSMutableAttributedString alloc] initWithString:@", "];
            [tempString appendAttributedString:comma];
            [tempString appendAttributedString:[self getCardProperties:cardTwo]];
            NSMutableAttributedString *and = [[NSMutableAttributedString alloc] initWithString:@" and "];
            [tempString appendAttributedString:and];
            [tempString appendAttributedString:[self getCardProperties:cardThree]];
            self.describeLabel.attributedText = tempString;
            
        } else {
            NSMutableAttributedString *didntMatch = [[NSMutableAttributedString alloc] initWithString:@"No match!"];
            self.describeLabel.attributedText = didntMatch;
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

- (IBAction)dealPressed:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self chooseDeck]];
    
    self.flipCount = 0;
    self.describeLabel.text = [NSString stringWithFormat:@""];
    NSMutableAttributedString *emptyString = [[NSMutableAttributedString alloc] initWithString:@""];
    self.describeLabel.attributedText = emptyString;
    [[self recentCardProperties] removeAllObjects];
    [self.game gameMode:YES];
    NSMutableAttributedString *blankString = [[NSMutableAttributedString alloc] initWithString:@""];
    self.describeLabel.attributedText = blankString;
    [self updateUI];
}


@end
