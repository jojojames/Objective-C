//
//  ViewController.h
//  testProject2
//
//  Created by James Nguyen on 2/26/13.
//  Copyright (c) 2013 James Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGSQLConnection.h"
#import "PGSQLConnectionInfo.h"

@interface ViewController : UIViewController {
    PGSQLConnection *pgConn;
}


@end
