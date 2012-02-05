//
//  MUSegmentedControl.h
//  MUKit
//
//  Created by Malaar on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MUSegmentedControl : UIControl
{
    UIImageView* bgImageView;               /// bg
    NSMutableArray* buttons;                       /// array of buttons
    UIButton* currentItem;
//	BOOL enabled;
}

@property (nonatomic, readonly) UIImageView* backgroundImageView;
//@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, readonly) NSUInteger currentIndex;

- (void) setBackgroundImage:(UIImage*)aBackgroundImage;
- (void) addButton:(UIButton*)aButton;
- (void) switchToItemWithIndex:(NSUInteger)aIndex;                              ///< programmaticaly switch to title by index

@end
