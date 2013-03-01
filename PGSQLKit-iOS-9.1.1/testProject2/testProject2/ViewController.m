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
@property (retain, nonatomic) IBOutlet UILabel *outputLabel;

@end

@implementation ViewController
@synthesize connect;
@synthesize outputLabel;


- (IBAction)onConnect:(id)sender {
	NSLog(@"On Connect");
    
    pgConn = [[[[PGSQLConnection alloc] init] autorelease] retain];
    
    /* Manually connect */
    [pgConn setUserName:@"james"];
    [pgConn setServer:@"localhost"];
    [pgConn setPort:@"5432"];
    [pgConn setDatabaseName:@"IOS"];
    [pgConn setPassword:@""];
	
	if (![pgConn connect]) {
		NSLog(@"fail");
		return;
	}
	
    self.outputLabel.text = @"Connected";
	
	PGSQLConnectionInfo *ci = [[PGSQLConnectionInfo alloc] initWithConnection:pgConn];
    
	//versionInfo.text = [ci versionString];
	
	//connectedTo.text = [NSString stringWithFormat:@"%@@%@", [pgConn databaseName], [pgConn server]];
    [ci release];
	//[pgConn close];
	//[pgConn release];
	return;
}

- (IBAction)selectPressed:(id)sender {
    
    //self.outputLabel.text = [pgConn sqlLog];
    
    /* Different SQL commands. */
    NSString *usrnameFromEmployee = @"select username from tbl_employee where fname = 'ISA'"; // outputs 'ISA'
    NSString *selectAllfromEmployee = @"select * from tbl_employee";
    NSString *usrnamePassword = @"select username, password from tbl_employee";
    
    NSMutableString * command = [[NSMutableString alloc] initWithString:usrnamePassword];
    PGSQLRecordset *rs = [pgConn open:command];
    NSLog(@" ROWS : %d", [rs rowCount]); // # of rows
    
    //NSString * testString =[[rs fieldByIndex:0] asString];
    
    //NSString * testString = [[rs fieldByName:@"password"] asString];
    
    
    NSArray *colu = [rs columns];
    [colu count];
    NSLog(@" COLUMNS :  %d", [colu count]);
    
    NSString * testString = [[rs fieldByName:@"password"] asString];
    NSLog(testString);
    [rs moveNext];
    
    testString = [[rs fieldByName:@"password"] asString];
    NSLog(testString);
    
    
    //NSLog(testString);
    
    //
    //NSMutableString *cmd = [[NSMutableString alloc] init];
	//[cmd appendString:@"select current_database() as db, current_user as user, version() as version, current_schema() as schema"];
	//PGSQLRecordset *rs = [pgConnection open:cmd];`
    
    
}

@end
