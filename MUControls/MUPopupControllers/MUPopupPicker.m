//
//  MUPopupPicker.m
//  TimeLink
//
//  Created by Malaar on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUPopupPicker.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUPopupPicker (Private)

- (void) toolbarButtonPressed:(UIButton*)aSender;
- (void) toolbarItemPressed:(UIBarButtonItem*)aSender;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUPopupPicker

@synthesize toolbar;
@synthesize selectedItem;

//==============================================================================
- (void) dealloc
{
    [toolbar release];
    [selectedItem release];
    
    [super dealloc];
}

//==============================================================================
// Create, configure and return popupedView
- (void) setup
{
    [super setup];
    
    self.backgroundColor = [UIColor clearColor];
    picker = [self createPicker];
    [self addSubview:picker];
    
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

//==============================================================================
- (void) setToolbar:(MUToolbar *)aToolbar
{
    if(toolbar == aToolbar)
        return;
    
    if(aToolbar)
    {
        toolbar = [aToolbar retain];

        [self addSubview:toolbar];
        
        [toolbar sizeToFit];
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //
        self.autoresizingMask ^= !(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
        picker.autoresizingMask ^= !(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

        CGRect frame = picker.frame;
        frame.origin.y = toolbar.bounds.size.height;
        picker.frame = frame;
        
        frame.origin.y = 0;
        frame.size.height += toolbar.bounds.size.height;
        self.frame = frame;

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //
        int index = 0;
        for(UIBarButtonItem* bbi in toolbar.items)
        {
            if(bbi.customView && [bbi.customView isKindOfClass:[UIButton class]])
            {
                bbi.customView.tag = index;
                [((UIButton*)bbi.customView) addTarget:self action:@selector(toolbarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                bbi.tag = index;
                [bbi setTarget:self];
                [bbi setAction:@selector(toolbarItemPressed:)];
            }
            
            ++index;
        }
    }
    else
    {
        [toolbar removeFromSuperview];
        [toolbar release];
        toolbar = nil;
    }
}

//==============================================================================
- (UIView*) createPicker
{
    return nil;     // override it in subclasses
}

//==============================================================================
- (NSObject*) selectedItem
{
    return nil; // override it in subclasses
}

////==============================================================================
//- (void) setSelectedItem:(NSObject *)aSelectedItem
//{
//    // override it in subclasses
//}

#pragma mark - Toolbar
//==============================================================================
- (void) toolbarButtonPressed:(UIButton*)aSender
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:aSender.tag] forKey:POPUPVIEW_TOOLBAR_ITEM_PRESSED_INDEX];
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_TOOLBAR_ITEM_DID_PRESSED object:self userInfo:userInfo];
}

//==============================================================================
- (void) toolbarItemPressed:(UIBarButtonItem*)aSender
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:aSender.tag] forKey:POPUPVIEW_TOOLBAR_ITEM_PRESSED_INDEX];
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUPVIEW_TOOLBAR_ITEM_DID_PRESSED object:self userInfo:userInfo];
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
