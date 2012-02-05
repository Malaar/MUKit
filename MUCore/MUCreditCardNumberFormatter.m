//
//  MUCreditCardNumberFormatter.m
//  MUKit
//
//  Created by Yuriy Bosov on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCreditCardNumberFormatter.h"

@implementation MUCreditCardNumberFormatter

//==============================================================================
- (BOOL) cardFormatForTextField:(UITextField *)textField 
  shouldChangeCharactersInRange:(NSRange)range 
              replacementString:(NSString *)string 
                separatorString:(NSString *)separatorString
{
    NSAssert(separatorString, @"MUKit(MUCreditCardNumberFormatter): separatorString is not null!!!");
    
    BOOL result = YES;
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([string length] > 0)
    {
        result = NO;
        if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound)
        {
            text = [text stringByReplacingOccurrencesOfString:separatorString withString:@""];
            
            NSInteger length = [text length];
            BOOL part1Enabled = length > 0;
            BOOL part2Enabled = length > 4;
            BOOL part3Enabled = length > 8;
            BOOL part4Enabled = length > 12;
            
            NSString *part1 = nil;    
            NSString *part2 = nil;    
            NSString *part3 = nil;    
            NSString *part4 = nil;
            
            if (part1Enabled)
            {
                part1 = [text substringWithRange:NSMakeRange(0, MIN(length, 4))];
                if (part2Enabled) 
                {
                    part2 = [text substringWithRange:NSMakeRange(4, MIN(length - 4, 4))];
                    if (part3Enabled) 
                    {
                        part3 = [text substringWithRange:NSMakeRange(8, MIN(length - 8, 4))];
                        if (part4Enabled)
                        {
                            part4 = [text substringWithRange:NSMakeRange(12, MIN(length - 12, 4))];
                        }
                    }
                }
            }
            
            //0000-0000-0000-0000
            NSString *costText = [[NSArray arrayWithObjects:part1, part2, part3, part4, nil] componentsJoinedByString:separatorString];
            textField.text = costText;
        }
    }
    return result;
}

@end
