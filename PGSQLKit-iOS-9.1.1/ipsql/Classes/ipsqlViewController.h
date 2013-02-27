//
//  ipsqlViewController.h
//  ipsql
//
//  Created by Andrew Satori on 7/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGSQLConnection.h"

@interface ipsqlViewController : UIViewController {
    UITextField *userName;
    UITextField *password;
    UITextField *hostName;
    UITextField *port;
    UITextField *databaseName;
    
	UILabel *status;
	UILabel *versionInfo;
	UILabel *connectedTo;
	
    UIControl *thisView;
    
	PGSQLConnection *pgConn;
}

- (IBAction)onConnect:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;
- (void)resignFirstResponderForSubviewsOfView:(UIView *)aView ;

@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UITextField *hostName;
@property (nonatomic, retain) IBOutlet UITextField *port;
@property (nonatomic, retain) IBOutlet UITextField *databaseName;

@property (nonatomic, retain) IBOutlet UIControl *thisView;

@property (nonatomic, retain) IBOutlet UILabel *status;
@property (nonatomic, retain) IBOutlet UILabel *versionInfo;
@property (nonatomic, retain) IBOutlet UILabel *connectedTo;



@end

