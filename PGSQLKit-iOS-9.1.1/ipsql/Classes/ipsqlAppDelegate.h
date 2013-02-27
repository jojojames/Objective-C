//
//  ipsqlAppDelegate.h
//  ipsql
//
//  Created by Andrew Satori on 7/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ipsqlViewController;

@interface ipsqlAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ipsqlViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ipsqlViewController *viewController;

@end

