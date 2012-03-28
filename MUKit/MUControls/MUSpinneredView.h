//
//  MYSpinnered.h
//  MUKit
//
//  Created by yuriy on 29.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Spinnered oveley to indicate some process
@interface MUSpinneredView : UIView
{
	UIView* parentView;                                                         ///< parent view
	UIActivityIndicatorView* spinner;                                           ///< spinner
	BOOL isShow;
}

- (id) initWithParentView: (UIView*)aParentView color:(UIColor*)aColor;
- (void) show;                                                                  ///< show overlay and start spinner
- (void) hide;                                                                  ///< hide overlay and stop spinner

@end
