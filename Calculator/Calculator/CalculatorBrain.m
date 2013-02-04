//
//  CalculatorBrain.m
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "CalculatorBrain.h"
#import "Calculations.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack; // makes the instance variables for the pointer, never allocates anything

// Getter for programStack
- (NSMutableArray *)programStack {
    if(_programStack == nil)
        _programStack = [[NSMutableArray alloc] init]; // Lazy instantiation
    return _programStack;
}

// Setter for programStack 
- (void)setOperandStack:(NSMutableArray *)programStack {
    _programStack = programStack;
}

// Adds a number into the stack for evaluation later.
- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject != nil) {
        [self.programStack removeLastObject];
    }
    return [operandObject doubleValue];
}

// Take a look at the top of the stack but don't remove it.
- (double)peekOperand {
    NSNumber *operandObject = [self.programStack lastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}
    
// read only property, so only a getter
- (id)program {
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program {
    return @"Implement this in assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    // if not nill, remove the object
    if(topOfStack) [stack removeLastObject];
    
    
    if([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [Calculations add:[self popOperandOffStack:stack] _and:[self popOperandOffStack:stack]];
        } else if ([@"*" isEqualToString:operation]) {
            result = [Calculations multiply:[self popOperandOffStack:stack] _and:[self popOperandOffStack:stack]];
        } else if ([operation isEqualToString:@"/"]) {
            result = [Calculations divide:[self popOperandOffStack:stack] _and:[self popOperandOffStack:stack]];
        } else if ([operation isEqualToString:@"-"]) {
            result = [Calculations subtract:[self popOperandOffStack:stack] _and:[self popOperandOffStack:stack]];
        } else if ([operation isEqualToString:@"Pi"]) {
            // First push 3.14 into the stack then return it.
            [stack addObject:[NSNumber numberWithDouble:3.14]];
            result = [Calculations pi:3.14];
        } else if ([operation isEqualToString:@"Sin"]) {
            result = [Calculations sin_:[self popOperandOffStack:stack]];
        } else if ([operation isEqualToString:@"Cos"]) {
            result = [Calculations cos_:[self popOperandOffStack:stack]];
        } else if ([operation isEqualToString:@"Sqrt"]) {
            result = [Calculations sqrt_:[self popOperandOffStack:stack]];
        }
    }
    
    return result;
    
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]) {
        // passing an (id) into NSMutableArray
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

- (void)removeAll {
    while(self.programStack.count) {
        [self.programStack removeLastObject];
    }
}

- (BOOL)isEmpty {
    NSNumber *operandObject = [self.programStack lastObject];
    if(operandObject == nil) {
        return TRUE;
    } else {
        return FALSE;
    }
}

@end














