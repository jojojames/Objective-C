//
//  Calculations.h
//  Calculator
//
//  Created by James Nguyen on 1/15/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject

+ (double)add:(double)A _and:(double)B;

+ (double)subtract:(double)A _and:(double)B;

+ (double)multiply:(double)A _and:(double)B;

+ (double)divide:(double)A _and:(double)B;

+ (double)raise:(double)A _power:(double)B;

+ (double)pi:(double)x;

+ (double)sin_:(double)x;

+ (double)cos_:(double)x;

+ (double)sqrt_:(double)x;

@end
