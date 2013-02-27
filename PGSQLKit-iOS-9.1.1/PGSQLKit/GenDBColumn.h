//
//  GenDBColumn.h
//  ODBCKit
//
//  Created by Andy Satori on 12/26/10.
//  Copyright 2010 Satori & Associates, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GenDBColumn

-(NSString *)name;
-(int)index;
-(int)type;
-(int)size;
-(int)offset;

@end
