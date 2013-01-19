//
//  CalculatorViewController.m
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userPressedDecimalKey;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userPressedDecimalKey;
@synthesize brain = _brain;

// Getter for brain
- (CalculatorBrain *)brain {
    if(!_brain)
        _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

// 0,1,2,...,7,8,9
- (IBAction)digitPressed:(UIButton *)sender {
    if([sender.currentTitle isEqualToString:@"."] && self.userPressedDecimalKey == YES)
        return;
    else if([sender.currentTitle isEqualToString:@"."])
        self.userPressedDecimalKey = YES;
    
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

// *,/,+,-
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber)
       [self enterPressed];
    // If pressing Pi, add the previous operand to the stack.
    if([sender.currentTitle isEqualToString:@"Pi"])
        [self.brain pushOperand:[self.display.text doubleValue]];
    double result = [self.brain performOperation:sender.currentTitle];
    
    NSString * resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

// Enter Key
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedDecimalKey = NO;
}


- (IBAction)clearAll:(UIButton *)sender {
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userPressedDecimalKey = NO;
    self.display.text = @"0";
    [self.brain removeAll];
}



@end

















