//
//  GenDBConnection.h
//
//  Created by Andy Satori on 12/16/10.
//  Copyright 2010-2011 Druware Software Designs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GenDBConnection

/* Connection Property Implementations */
#pragma mark -
#pragma mark Connection Property Implementations

- (BOOL)isConnected;

- (NSString *)connectionString;
- (void)setConnectionString:(NSString *)value;

- (NSString *)userName;
- (void)setUserName:(NSString *)value;

- (NSString *)password;
- (void)setPassword:(NSString *)value;

- (NSString *)datasourceFilter;
- (void)setDatasourceFilter:(NSString *)value;

- (BOOL)enableCursors;
- (void)setEnableCursors:(BOOL)value;

/*!
	@function
	@abstract   Get the connection's defaultEncoding for all string operations 
				returning.
	@discussion The default setting is NSUTF8StringEncoding.  
	@result     returns the defaultEncoding as an NSSTringEncoding ( 
				http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/doc/c_ref/NSStringEncoding )
 */
-(NSStringEncoding)defaultEncoding;

/*!
	@function
	@abstract   Set the defaultEncoding for all string operations on the current
				connection
	@discussion The default setting is NSUTF8StringEncoding.
	@param      value the defaultEncoding as an NSSTringEncoding ( 
				http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/doc/c_ref/NSStringEncoding )

	@result     void
 */
-(void)setDefaultEncoding:(NSStringEncoding)value;

/* Connection Management Functions ********************************************/
#pragma mark -
#pragma mark Connection Management Functions

- (BOOL)close;
- (BOOL)connect;
- (void)connectAsync;
- (long)execCommand:(NSString *)sql;
- (void)execCommandAsync:(NSString *)sql;
- (id <GenDBRecordset>)open:(NSString *)sql;
- (void)openAsync:(NSString *)sql;

- (NSString *)lastError;

- (id <GenDBConnection>)clone;

FOUNDATION_EXPORT NSString * const GenDBConnectionDidCompleteNotification;
FOUNDATION_EXPORT NSString * const GenDBCommandDidCompleteNotification;

@end
