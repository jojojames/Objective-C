//
//  PGSQLLogin.m
//  PGSQLKit
//
//  Created by Andy Satori on 5/8/07.
//  Copyright 2007 Druware Software Designs. All rights reserved.
//

#import "PGSQLLogin.h"
#import <Security/Security.h>
#import <CoreFoundation/CoreFoundation.h>
#import <stdlib.h>

@implementation PGSQLLogin

#pragma mark Keychain Helper Functions

- (NSString *)connectionNameForKeychainItem:(SecKeychainItemRef)item
{
	OSStatus status;
	SecKeychainAttribute attributes[2];
	SecKeychainAttributeList list;
	NSString *result = nil;
	
	attributes[0].tag = kSecLabelItemAttr;
	
	list.count = 1;
	list.attr = attributes;
	
	status = SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL);
	
	if (status == noErr)
	{
		char buffer[1024];
		SecKeychainAttribute attr;
		int i;
		
		for (i = 0; i < list.count; i++)
		{
			attr = list.attr[i];
			if (attr.length < 1024)
			{
				strncpy(buffer, attr.data, attr.length);
				buffer[attr.length] = '\0';
				result = [[[NSString alloc] initWithFormat:@"%s", buffer] autorelease];
			}
		}
	}
	
	SecKeychainItemFreeContent(&list, NULL);
	return result;
}

- (NSString *)setConnectionDetailsForKeychainItem:(SecKeychainItemRef)item
{
	OSStatus status;
	SecKeychainAttribute attributes[4];
	SecKeychainAttributeList list;
	NSString *where = nil;
	char *password;
	UInt32 passwordLen;
	passwordLen = 1024;
	password = malloc(passwordLen);
	
	attributes[0].tag = kSecServiceItemAttr;
	attributes[1].tag = kSecAccountItemAttr;
	
	list.count = 2;
	list.attr = attributes;
	
	
	// alter this to read the password (last two nulls)
	status = SecKeychainItemCopyContent(item, NULL, &list, &passwordLen,
										(void *)&password);
	
	if (status == noErr)
	{
		char buffer[1024];
		SecKeychainAttribute attr;
		int i;
		
		for (i = 0; i < list.count; i++)
		{
			attr = list.attr[i];
			switch (attr.tag)
			{
				case kSecServiceItemAttr:
					if (attr.length < 1024)
					{
						strncpy(buffer, attr.data, attr.length);
						buffer[attr.length] = '\0';
						where = [[[NSString alloc] initWithFormat:@"%s", buffer] autorelease];
						
						// split the where into the location elements
						[serverName setStringValue:where];
						
						NSRange range1 = [where rangeOfString:@"@"];
						NSRange range2 = [where rangeOfString:@":"];
						NSRange range3 = NSMakeRange(
													 (range1.location + range1.length),
													 (range2.location - (range1.location + range1.length)));
						
						[serverName setStringValue:
							[where substringWithRange:range3]];
						[serverPort setStringValue:
							[where substringFromIndex:range2.location + range2.length]]; 
						[serverDatabase setStringValue:
							[where substringToIndex:range1.location]];
					}
					break;
				case kSecAccountItemAttr:
					if (attr.length < 1024)
					{
						strncpy(buffer, attr.data, attr.length);
						buffer[attr.length] = '\0';
						NSString *who = [[[NSString alloc] initWithFormat:@"%s", buffer] autorelease];
						[loginUserName setStringValue:who];
					}
					break;
				default:
					break;
			}
		}
		
		strncpy(buffer, password, passwordLen);
		buffer[passwordLen] = '\0';
		// set the password
		[loginPassword setStringValue:[NSString stringWithFormat:@"%s", buffer]];
	}
	
	free(password);
	
	
	return where;
}

- (BOOL)editExistingKeychainItem
{
	OSStatus status;
	SecKeychainSearchRef search;
	SecKeychainAttribute searchAttributes[2];
	SecKeychainAttributeList searchList;
	SecKeychainItemRef item;
	
	NSString *selectedValue = [savedConnections stringValue];

	searchAttributes[0].tag = kSecCreatorItemAttr;
	searchAttributes[0].data = "pgds";
	searchAttributes[0].length = 4;
	
	searchAttributes[1].tag = kSecLabelItemAttr;
	searchAttributes[1].data = (char *)[selectedValue cStringUsingEncoding:NSMacOSRomanStringEncoding];
	searchAttributes[1].length = [selectedValue length];

	searchList.count = 2;
	searchList.attr = searchAttributes;

	status = SecKeychainSearchCreateFromAttributes(NULL, 
										kSecGenericPasswordItemClass,
										&searchList, &search);
	if (status != noErr)
	{
		NSLog(@"Error reading the keychain: %d", status); 
	}


	int i = 0;
	while (SecKeychainSearchCopyNext(search, &item) == noErr)
	{
		SecKeychainAttribute attributes[12];
		SecKeychainAttributeList list;
		char *password;
		UInt32 passwordLen;
		passwordLen = 1024;
		password = malloc(passwordLen);
		
		attributes[0].tag = kSecServiceItemAttr;
		attributes[1].tag = kSecAccountItemAttr;
		attributes[2].tag = kSecDescriptionItemAttr;
		attributes[3].tag = kSecLabelItemAttr;		
		attributes[4].tag = kSecCommentItemAttr;
		attributes[5].tag = kSecCreatorItemAttr;
		
		list.count = 6;
		list.attr = attributes;
		
		// alter this to read the password (last two nulls)
		status = SecKeychainItemCopyContent(item, NULL, &list, NULL, NULL);
		
		if (status == noErr)
		{
			SecKeychainAttribute attr;
			int i;
			
			NSString *where = [NSString stringWithFormat:@"%@@%@:%@",
				[resultConnection databaseName], [resultConnection server],
				[resultConnection port]];
			NSString *description = [NSString stringWithFormat:@"%@@%@:%@",
				[resultConnection databaseName], [resultConnection server],
				[resultConnection port]];
			
			for (i = 0; i < list.count; i++)
			{
				attr = list.attr[i];
				switch (attr.tag)
				{
					case kSecServiceItemAttr:
						attr.data = (char *)[where cStringUsingEncoding:NSMacOSRomanStringEncoding];
						attr.length = [where length];
						break;
					case kSecAccountItemAttr:
						attr.data = (char *)[[loginUserName stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding];
						attr.length = [[loginUserName stringValue] length];
						break;
					case kSecDescriptionItemAttr:
						attr.data = "PostgreSQL Login";
						attr.length = 16;
						break;
					case kSecLabelItemAttr:
						attr.data = (char *)[[savedConnections stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding];
						attr.length = [[savedConnections stringValue] length];
						break;
					case kSecCommentItemAttr:
						attr.data = (char*)[description cStringUsingEncoding:NSMacOSRomanStringEncoding];
						attr.length = [description length];
						break;
					case kSecCreatorItemAttr:
						attr.data = "pgds";
						attr.length = 4;
						break;
					default:
						break;
				}
			}
			// do the save of the edited item
			SecKeychainItemModifyContent(item, &list, 
												  [[loginPassword stringValue] length], 
												  [[loginPassword stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding]);	
			
		}
		
		free(password);
		CFRelease(item);
		i++;
	}
	CFRelease(search);
	
	return (i > 0);
}

- (BOOL)createKeychainItem
{
	SecKeychainAttribute attributes[6];
	SecKeychainAttributeList list;
	SecKeychainItemRef item;
	OSStatus status;
	
	NSString *where = [NSString stringWithFormat:@"%@@%@:%@",
		[resultConnection databaseName], [resultConnection server],
		[resultConnection port]];
	NSString *description = [NSString stringWithFormat:@"%@@%@:%@",
		[resultConnection databaseName], [resultConnection server],
		[resultConnection port]];	
	
	attributes[0].tag = kSecAccountItemAttr;
	attributes[0].data = (char *)[[loginUserName stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding];
	attributes[0].length = [[loginUserName stringValue] length];
	
	attributes[1].tag = kSecDescriptionItemAttr;
	attributes[1].data = "PostgreSQL Login";
	attributes[1].length = 16;
	
	attributes[2].tag = kSecLabelItemAttr;
	attributes[2].data = (char *)[[savedConnections stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding];
	attributes[2].length = [[savedConnections stringValue] length];
	
	attributes[3].tag = kSecServiceItemAttr;
	attributes[3].data = (char *)[where cStringUsingEncoding:NSMacOSRomanStringEncoding];
	attributes[3].length = [where length];
	
	attributes[4].tag = kSecCommentItemAttr;
	attributes[4].data = (char*)[description cStringUsingEncoding:NSMacOSRomanStringEncoding];
	attributes[4].length = [description length];
	
	attributes[5].tag = kSecCreatorItemAttr;
	attributes[5].data = "pgds";
	attributes[5].length = 4;
	
	list.count = 6;
	list.attr = attributes;
	
	status = SecKeychainItemCreateFromContent(kSecGenericPasswordItemClass, 
											  &list, 
											  [[loginPassword stringValue] length], 
											  [[loginPassword stringValue] cStringUsingEncoding:NSMacOSRomanStringEncoding], 
											  NULL, NULL, &item);	
	CFRelease(item);
	return (status == noErr);
	
}


#pragma mark -
#pragma mark Class implementation

-(id)init
{
    self = [super init];
	
	resultConnection = [[[[PGSQLConnection alloc] init] retain] autorelease];
	defaultDSN = nil;
	defaultUser = nil;
	defaultPassword = nil;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConnectionCompleted:) name:PGSQLConnectionDidCompleteNotification object:nil];
	
	return self;
} 

-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	if (resultConnection != nil) {
		[resultConnection release];	
		resultConnection = nil;
	}
	
	if (loginPanel != nil) {
		[loginPanel release];	
		loginPanel = nil;
	}
	
	[super dealloc];
}


- (void)beginModalLoginForWindow:(NSWindow *)parent
{
	parentWindow = parent;
		
	// load the nib 
	
	if (![NSBundle loadNibNamed:@"PGSQL Login" owner:self]) 
	{
		NSLog(@"Error loading nib for login");
		return;
	}
	
	[rememberConnection setState:NSOnState];
	
	[savedConnections removeAllItems];
	
	// populate the list from the keychain
	OSStatus status;
	SecKeychainSearchRef search;
	SecKeychainAttribute attributes[1];
	SecKeychainAttributeList list;
	SecKeychainItemRef item;
	
	attributes[0].tag = kSecCreatorItemAttr;
	attributes[0].data = "pgds";
	attributes[0].length = 4;
	
	list.count = 1;
	list.attr = attributes;
	
	status = SecKeychainSearchCreateFromAttributes(NULL, 
												   kSecGenericPasswordItemClass,
												   &list, &search);
	if (status != noErr)
	{
		NSLog(@"Error reading the keychain: %d", status); 
	}
				
	while (SecKeychainSearchCopyNext(search, &item) == noErr)
	{
		[savedConnections addItemWithObjectValue:[self connectionNameForKeychainItem:item]];
		CFRelease(item);
	}
	CFRelease(search);
		
	// default the host fields
	isShowingDetails = YES;
	[serverName setStringValue:@"localhost"];
	[serverPort setStringValue:@"5432"];
	[serverDatabase setStringValue:@"template1"];
	
	if (defaultDSN != nil)
	{
		isShowingDetails = YES;

	//	[savedConnections selectItemWithTitle:defaultDSN];		
	}
	
	[loginUserName setStringValue:@"postgres"];
	if (defaultUser != nil)
	{
		[loginUserName setStringValue:defaultUser];
	}
	
	[loginPassword setStringValue:@""];
	if (defaultPassword != nil)
	{
		[loginPassword setStringValue:defaultPassword];
	}
	
	// make sure the UI delegates are in place
	[savedConnections setDelegate:self];
	
	[NSApp beginSheet:loginPanel  
	   modalForWindow:parentWindow 
		modalDelegate:nil
	   didEndSelector:nil
		  contextInfo:nil];
	
    [NSApp runModalForWindow:loginPanel];
	
	return;
}

- (void)onConnectionCompleted:(NSNotification *)aNotification
{
	NSDictionary *info = [aNotification userInfo];
	
	 if (nil == [info valueForKey:@"Error"]) {
		NSLog(@"Connected to PostgreSQL Database");
	} else {
		// show an alert 
		NSLog(@"Unable to connect to PostgreSQL Database");
	}
	
	NSObject* windowDelegate = [parentWindow delegate];
	if ([windowDelegate respondsToSelector:@selector(loginCompleted:)] == YES)
	{
		[windowDelegate loginCompleted:resultConnection];
	}
	
}

- (IBAction)onLogin:(id)sender
{
	[NSApp stopModal];
	
	[resultConnection setUserName:[loginUserName stringValue]];
	[resultConnection setPassword:[loginPassword stringValue]];
	[resultConnection setServer:[serverName stringValue]];
	[resultConnection setPort:[serverPort stringValue]];
	[resultConnection setDatabaseName:[serverDatabase stringValue]];
	
	// if 'remember connection' is enabled, add/update the connection in the 
	// keychain using the keychain api.
	if ([rememberConnection state] == NSOnState)
	{
		if ([[savedConnections stringValue] length] > 0)
		{
			if ([self editExistingKeychainItem] == NO)
			{
				if ([self createKeychainItem] == NO)
				{
					NSLog(@"Failed to set keychain item");
				}
			}
		}
	}
	

	// attempt the connection.
	[resultConnection connectAsync];
	
	[NSApp endSheet:loginPanel];
    [loginPanel orderOut:self];	
}

- (void)resizeWindowToSize:(NSSize)newSize
{
    NSRect aFrame;
    
    float newHeight = newSize.height;
    float newWidth = newSize.width;
	
    aFrame = [NSWindow contentRectForFrameRect:[loginPanel frame] 
									 styleMask:[loginPanel styleMask]];
    
    aFrame.origin.y += aFrame.size.height;
    aFrame.origin.y -= newHeight;
    aFrame.size.height = newHeight;
    aFrame.size.width = newWidth;
    
    aFrame = [NSWindow frameRectForContentRect:aFrame 
									 styleMask:[loginPanel styleMask]];
    
    [loginPanel setFrame:aFrame display:YES animate:YES];
}



- (IBAction)onConnectionDetails:(id)sender
{
	NSSize newSize;  // box is 144
	NSRect currentSize;
	
	NSView *contentView = [loginPanel contentView];
	
	currentSize = [contentView frame];
	// show/hide the details section of the dialog
	if ([displayConnectionDetails state] == NSOnState)
	{
		// flip the flag
		newSize.width = currentSize.size.width;
		newSize.height = currentSize.size.height + 144;
		[detailsView setHidden:NO];
		[self resizeWindowToSize:newSize];
	} else {
		// 
		newSize.width = currentSize.size.width;
		newSize.height = currentSize.size.height - 144;
		[self resizeWindowToSize:newSize];
		[detailsView setHidden:YES];
		
	}
	isShowingDetails = !(isShowingDetails);
}

- (IBAction)onHelp:(id)sender
{
	// display the login dialog help window

}

- (IBAction)onCancel:(id)sender
{
	[NSApp stopModal];
	
	// exit the application
	NSObject* windowDelegate = [parentWindow delegate];
	if ([windowDelegate respondsToSelector:@selector(loginCompleted:)] == YES)
	{
		[windowDelegate loginCompleted:nil];
	}
	
	[NSApp endSheet:loginPanel];
    [loginPanel orderOut:self];	
}

- (BOOL)isConnected
{
	if (resultConnection != nil)
	{
		return [resultConnection isConnected];
	}
	
	return NO;
}

- (PGSQLConnection *)connection
{
	if (resultConnection != nil)
	{
		return [resultConnection retain];
	}
	return nil;
}

- (NSString *)defaultConnectionString
{
    return defaultDSN;
}

- (void)setDefaultConnectionString:(NSString *)value
{    
	//[resultConnection setConnectionString:value];
	if (defaultDSN != value) {
        [defaultDSN release];
        defaultDSN = [value copy];
    }
}

- (NSString *)defaultDSN
{
    return [[defaultDSN retain] autorelease];
}

- (NSString *)defaultUser
{
    return [[defaultUser retain] autorelease];
}

- (void)setDefaultUser:(NSString *)value
{    
	if (defaultUser != value) {
        [defaultUser release];
        defaultUser = [value copy];
    }
}

- (void)setDefaultPassword:(NSString *)value
{    
	if (defaultPassword != value) {
        [defaultPassword release];
        defaultPassword = [value copy];
    }
}

#pragma mark -
#pragma mark ComboBox Delegates for Selection

- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
	// check the selected item and load the details from the keychain if possible
	
	if ([savedConnections indexOfSelectedItem] >= 0)
	{
		NSLog(@"Selection Changed");
		
		NSString *selectedValue = [savedConnections objectValueOfSelectedItem];
		
		OSStatus status;
		SecKeychainSearchRef search;
		SecKeychainAttribute attributes[2];
		SecKeychainAttributeList list;
		SecKeychainItemRef item;
		
		attributes[0].tag = kSecCreatorItemAttr;
		attributes[0].data = "pgds";
		attributes[0].length = 4;
		
		attributes[1].tag = kSecLabelItemAttr;
		attributes[1].data = (char *)[selectedValue cStringUsingEncoding:NSMacOSRomanStringEncoding];
		attributes[1].length = [selectedValue length];
		
		list.count = 2;
		list.attr = attributes;
		
		status = SecKeychainSearchCreateFromAttributes(NULL, 
													   kSecGenericPasswordItemClass,
													   &list, &search);
		if (status != noErr)
		{
			NSLog(@"Error reading the keychain: %d", status); 
		}
		
		[rememberConnection setState:NSOffState];
		
		while (SecKeychainSearchCopyNext(search, &item) == noErr)
		{
			[self setConnectionDetailsForKeychainItem:item];
			CFRelease(item);
		}
		
		CFRelease(search);
	}
}



@end
