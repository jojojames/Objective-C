//
//  SetGameViewController.m
//  Matchismo
//
//  Created by James Nguyen on 2/3/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    
}


@end
