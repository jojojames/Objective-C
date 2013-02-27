//
//  ViewController.m
//  testProject2
//
//  Created by James Nguyen on 2/26/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "PGSQLConnection.h"
#import "PGSQLConnectionInfo.h"

@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIButton *connect;

@end

@implementation ViewController
@synthesize connect;


- (IBAction)onConnect:(id)sender {
	NSLog(@"On Connect");
    
    PGSQLConnection *pgConn = [[[[PGSQLConnection alloc] init] autorelease] retain];
	
	
	//[pgConn setUserName:@"postgres"];
	//[pgConn setServer:@"192.168.1.26"];
	//[pgConn setPort:@"5432"];
	//[pgConn setDatabaseName:@"RGN30"];
	//[pgConn setPassword:@""];
    
    
    [pgConn setUserName:@"james"];
    [pgConn setServer:@"localhost"];
    [pgConn setPort:@"5432"];
    [pgConn setDatabaseName:@"IOS"];
    [pgConn setPassword:@""];
	
	if (![pgConn connect]) {
		NSLog(@"fail");
		return;
	}
	
	//status.text = @"Connected";
	
	PGSQLConnectionInfo *ci = [[PGSQLConnectionInfo alloc] initWithConnection:pgConn];
	//versionInfo.text = [ci versionString];
	
	//connectedTo.text = [NSString stringWithFormat:@"%@@%@", [pgConn databaseName], [pgConn server]];
    
    //[pgConn execCommand:"select * from "]
	
    [ci release];
	[pgConn close];
	[pgConn release];
    
    
	
	return;
}
@end
