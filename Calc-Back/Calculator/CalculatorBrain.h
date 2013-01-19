//
//  CalculatorBrain.h
//  Calculator
//
//  Created by James Nguyen on 1/14/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)popOperand;
- (double)peekOperand;
- (double)performOperation:(NSString *)operation;
- (void)removeAll;

@end
