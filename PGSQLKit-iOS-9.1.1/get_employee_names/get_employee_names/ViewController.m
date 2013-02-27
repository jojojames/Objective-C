//
//  ViewController.m
//  get_employee_names
//
//  Created by James Nguyen on 2/26/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "PGSQLConnection.h"
#import "PGSQLConnectionInfo.h"

@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIButton *connect;
@property (retain, nonatomic) IBOutlet UITextField *output;

@end

@implementation ViewController

@synthesize output;

- (void)setConnect:(UIButton *)connect {
    _connect = connect;
}


- (IBAction)onConnect:(id)sender {
 	PGSQLConnection *pgConn = [[[[PGSQLConnection alloc] init] autorelease] retain];
    
    [pgConn setUserName:@"postgres"];
    [pgConn setServer:@"192.168.1.26"];
    [pgConn setPort:@"5432"];
    [pgConn setDatabaseName:@"RGN30"];
    [pgConn setPassword:@""];
    if (![pgConn connect]) {
         NSLog(@"fail");
         return;
    }
    //logView.text = @"Connected";
    PGSQLConnectionInfo *ci = [[PGSQLConnectionInfo alloc] initWithConnection:pgConn];
    //logView.text = [NSString stringWithFormat:@"%@\n Hello from %@",
     //               logView.text,
      //              [ci versionString]];
    [ci release];
    [pgConn close];
    [pgConn release];
}

@end
