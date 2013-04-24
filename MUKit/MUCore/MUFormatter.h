//
//  MUFormatter.h
//  MUKitTest
//
//  Created by Malaar on 22.04.13.
//
//

#import <Foundation/Foundation.h>

@class MUFormatter;

@protocol MUFormatterProtocol <NSObject>

- (void)setFormatter:(MUFormatter*)aFormatter;
- (MUFormatter*)formatter;

@end


@interface MUFormatter : NSObject

@property (nonatomic, assign) id<MUFormatterProtocol> formattableObject;

- (BOOL)formatWithNewCharactersInRange:(NSRange)aRange replacementString:(NSString*)aString;

- (NSString*)rawText;

@end
