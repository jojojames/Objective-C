//
//  CardGameViewController.h
//  Matchismo
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"

@interface CardGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *display;
- (void)updateUI;


@end
