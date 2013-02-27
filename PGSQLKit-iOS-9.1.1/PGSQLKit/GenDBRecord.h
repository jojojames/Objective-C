
//
//  GenDBRecord.h
//
//  Created by Andy Satori on 12/26/10.
//  Copyright 2006-2011 Druware Software Designs. All rights reserved.
//

/* License *********************************************************************
 
 Copyright (c) 2006-2011, Druware Software Designs 
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

/*!
    @header		GenDBRecord
    @abstract   A generic database record protocol in the GenDB API.
    @discussion 
*/

#import <Foundation/Foundation.h>
#import "GenDBField.h"

/*!
    @protocol
    @abstract   Generic Record Definitions to the GenDB Protocol
    @discussion Provide a common implementation of a Record in a result set.  
				Each record in a result set represents a single row.  For the
				most part this implementation is used as a thin veneer and the
				bulk of the work and usability is also exposed by the recordset.
*/
@protocol GenDBRecord

/*!
    @function
    @abstract   return a field in the record by its ordinal into the record
    @discussion While faster than using the name, this implementation is less 
	            flexible as the SQL used to generate the lists is altered, and 
				it is frequently skipped in favor of the ByName() counterpart.
    @param      fieldIndex as the ordinal of the field to return.
    @result     a Field object that conforms to the GenDBField protocol 
				corresponding to the field in the record.
*/
-(id <GenDBField>)fieldByIndex:(long)fieldIndex;
/*!
    @function
    @abstract   return a field in the record by its column name in the record
    @discussion While slower than using the name, this implementation is more 
	            flexible as the SQL used to generate the lists is altered.
    @param      name as the string name of the field to return.
    @result     a Field object that conforms to the GenDBField protocol 
				corresponding to the field in the record.
*/
-(id <GenDBField>)fieldByName:(NSString *)name;

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
