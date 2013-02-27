//
//  PGSQLLogin.h
//  PGSQLKit
//
//  Created by Andy Satori on 5/8/07.
//  Copyright 2007 Druware Software Designs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PGSQLConnection.h" 

@interface PGSQLLogin : NSObject {
	IBOutlet NSWindow *loginPanel;
	IBOutlet NSComboBox *savedConnections;
	IBOutlet NSTextField *loginUserName;
	IBOutlet NSSecureTextField *loginPassword;
	IBOutlet NSTextField *serverName;
	IBOutlet NSTextField *serverPort;
	IBOutlet NSTextField *serverDatabase;
    IBOutlet NSButton *rememberConnection;
	IBOutlet NSButton *displayConnectionDetails;
	IBOutlet NSView *detailsView;
		
	NSWindow *parentWindow;
	
	PGSQLConnection *resultConnection;
	
	NSMutableArray *savedConnectionList;
	
	NSString *defaultDSN;	
	NSString *defaultUser;
	NSString *defaultPassword;
	
	BOOL	isShowingDetails;
}

- (void)beginModalLoginForWindow:(NSWindow *)parent;

- (IBAction)onCancel:(id)sender;
- (IBAction)onLogin:(id)sender;
- (IBAction)onHelp:(id)sender;
- (IBAction)onConnectionDetails:(id)sender;

- (BOOL)isConnected;

- (PGSQLConnection *)connection;

- (NSString *)defaultConnectionString;
- (void)setDefaultConnectionString:(NSString *)value;

- (void)setDefaultUser:(NSString *)value;
- (NSString *)defaultUser;

- (void)setDefaultPassword:(NSString *)value;

- (void)onConnectionCompleted:(NSNotification *)aNotification;

@end

@interface NSObject (PGSQLKitDelegateMethods)

- (id)loginCompleted:(PGSQLConnection *)connection;

@end
