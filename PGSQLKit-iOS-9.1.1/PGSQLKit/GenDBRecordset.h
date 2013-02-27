//
//  GenDBRecordset.h
//
//  Created by Andy Satori on 12/26/10.
//  Copyright 2010 Satori & Associates, Inc. All rights reserved.
//

/* License *********************************************************************
 
 Copyright (c) 2005-2011, Druware Software Designs 
 All rights reserved. 
 
 Redistribution and use in source or binary forms, with or without modification,
 are permitted provided that the following conditions are met: 
 
 1. Redistributions in source or binary form must reproduce the above copyright 
 notice, this list of conditions and the following disclaimer in the 
 documentation and/or other materials provided with the distribution. 
 2. Neither the name of the Druware Software Designs nor the names of its 
 contributors may be used to endorse or promote products derived from this 
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE 
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 
 *******************************************************************************/


#import <Foundation/Foundation.h>
#import "GenDBField.h"
#import "GenDBRecord.h"

/*!
    @protocol
    @abstract    Provides a common implmentation protocol for a recordset in the
				 the data.  This template encapsulates the columns and rows, as
				 well as providing utility methods to quickly access the data.
    @discussion  Provides a common implmentation protocol for a recordset in the
				 the data.  This template encapsulates the columns and rows, as
				 well as providing utility methods to quickly access the data.
				 In some implementations, this will be a thin veneer over the 
				 underlying result.  In others however, the ability to read the 
				 results out of order may cause the implementation to require an
				 internal cache mechanism for the results.  
*/
@protocol GenDBRecordset

-(id <GenDBField>)fieldByIndex:(long)fieldIndex;
-(id <GenDBField>)fieldByName:(NSString *)fieldName;
-(void)close;

-(NSArray *)columns;
-(NSUInteger) rowCount;

-(id <GenDBRecord>)moveFirst;
-(id <GenDBRecord>)movePrevious;
-(id <GenDBRecord>)moveNext;	
-(id <GenDBRecord>)moveLast;

-(BOOL)isEOF;

-(NSDictionary *)dictionaryFromRecord;

/*!
    @function
    @abstract   Access to the last error result from the user actions.
    @discussion Access to the last error result from the user actions.
    @param      none
    @result     NSString * as the string formatted results of the last action. 
	            a NIL result indicates no errors.
*/
-(NSString *)lastError;

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


@end
