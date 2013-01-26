//
//  Calculations.m
//  Calculator
//
//  Created by James Nguyen on 1/15/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "Calculations.h"

@implementation Calculations

+ (double)add:(double)A _and:(double)B {
    return A + B;
}

+ (double)subtract:(double)A _and:(double)B {
    return A - B;
}

+ (double)multiply:(double)A _and:(double)B {
    return A * B;
}

+ (double)divide:(double)A _and:(double)B {
    return A / B;
}

+ (double)raise:(double)A _power:(double)B {
    if(B == 0) {
        return 1;
    } else {
        return (A * [self raise:A _power:B-1]);
    }
}

+ (double) pi:(double)X {
    return X;
}

// Convert degree to radian first because the sin function uses radians to measure.
+ (double)sin_:(double)X {
    double radian_number = X * (3.14/180);
    return sin(radian_number);
}

// Convert degree to radian first because the cos function uses radians to measure.
+ (double)cos_:(double)X {
    double radian_number = X * (3.14/180);
    return cos(radian_number);
}

+ (double)sqrt_:(double)X {
    if(X <= 1) {
        return 1;
    }
    
    double lo = 1.0;
    double hi = X;
    
    while (hi - lo > 0.00001) {
        double mid = lo + (hi - lo) / 2;
        
        if(mid * mid - X > 0.00001) {
            hi = mid;
        } else {
            lo = mid;
        }
    }
    return lo;
}

@end
