//
//  MULogFormatterPlainText.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MULogFormatter.h"


@interface MULogFormatterPlainText : NSObject <MULogFormatter>
{
    NSDateFormatter* logDateFormatter;
}

@end
