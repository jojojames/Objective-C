//
//  CalculatorBrain.m
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack; // makes the instance variables for the pointer, never allocates anything

// Getter for operandStack
- (NSMutableArray *)operandStack {
    if(_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init]; // Lazy instantiation
    return _operandStack;
}

// Setter for operandStack 
- (void)setOperandStack:(NSMutableArray *)operandStack {
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject != nil) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (double)peekOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    // calculate result
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]) {
        result = [self popOperand] / [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        result = [self popOperand] - [self popOperand];
    }
    
    [self pushOperand:result];
    return result;
}

@end
