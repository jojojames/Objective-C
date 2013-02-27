//
//  ipsqlViewController.m
//  ipsql
//
//  Created by Andrew Satori on 7/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ipsqlViewController.h"
#import "PGSQLConnectionInfo.h"

@implementation ipsqlViewController


@synthesize userName;
@synthesize password;
@synthesize hostName;
@synthesize port;
@synthesize databaseName;

@synthesize thisView;

@synthesize status;
@synthesize versionInfo;
@synthesize connectedTo;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	pgConn = nil;
    [password setSecureTextEntry:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)onConnect:(id)sender
{
	NSLog(@"On Connect");
    
    [self resignFirstResponderForSubviewsOfView:self.view];
	
	pgConn = [[[[PGSQLConnection alloc] init] autorelease] retain];
	
	[pgConn setUserName:userName.text];
	[pgConn setServer:hostName.text];
	[pgConn setPort:port.text];
	[pgConn setDatabaseName:databaseName.text];
	[pgConn setPassword:password.text];
	
	if (![pgConn connect])
	{
		NSLog(@"fail");
		return;
	}
	
	status.text = @"Connected";
	
	PGSQLConnectionInfo *ci = [[PGSQLConnectionInfo alloc] initWithConnection:pgConn];
	versionInfo.text = [ci versionString];
	
	connectedTo.text = [NSString stringWithFormat:@"%@@%@", [pgConn databaseName], [pgConn server]];
	
    [ci release];
	[pgConn close];
	[pgConn release];
    
    
	
	return;
}

- (IBAction)textFieldReturn:(id)sender
{
    [self resignFirstResponderForSubviewsOfView:self.view];
}

- (void)resignFirstResponderForSubviewsOfView:(UIView *)aView 
{
    for (UIView *subview in [aView subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]])
            [(id)subview resignFirstResponder];
        
        [self resignFirstResponderForSubviewsOfView:subview];
    }
}

- (IBAction)backgroundTouched:(id)sender
{
     [self resignFirstResponderForSubviewsOfView:self.view];
}


@end
