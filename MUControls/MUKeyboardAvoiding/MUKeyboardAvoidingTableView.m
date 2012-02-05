//
//  MUKeyboardAvoidingTableView.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUKeyboardAvoidingTableView.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

//==============================================================================
@interface MUKeyboardAvoidingTableView (Init)

- (void)setup;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUKeyboardAvoidingTableView (Private)

- (UIView*)findFirstResponderBeneathView:(UIView*)view;
- (UIEdgeInsets)contentInsetForKeyboard;
- (CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space;
- (CGRect)keyboardRect;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUKeyboardAvoidingTableView

#pragma mark - Init/Dealloc
//==============================================================================
-(id)initWithFrame:(CGRect)frame  
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

//==============================================================================
-(id)initWithCoder:(NSCoder *)aDecoder 
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) 
    {
        [self setup];
    }
    return self;
}

//==============================================================================
- (void)setup 
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    _objectsInKeyboard = [NSMutableArray new];
}

//==============================================================================
-(void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_objectsInKeyboard release];
    [super dealloc];
}

#pragma mark - SetFrame/SetContentSize/TouchesEnded
//==============================================================================
-(void)setFrame:(CGRect)frame 
{
    [super setFrame:frame];
    if ( _keyboardVisible ) 
    {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

//==============================================================================
-(void)setContentSize:(CGSize)contentSize 
{
    [super setContentSize:contentSize];
    if ( _keyboardVisible ) 
    {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

//==============================================================================
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [[self findFirstResponderBeneathView:self] resignFirstResponder];
    [super touchesEnded:touches withEvent:event];
}

#pragma mark - NSNotification
//==============================================================================
- (void)keyboardWillShow:(NSNotification*)notification 
{
    _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardVisible = YES;
    
    UIView *firstResponder = [self findFirstResponderBeneathView:self];
    if ( !firstResponder ) 
    {
        return;
    }
    
    _priorInset = self.contentInset;
    
    self.contentInset = [self contentInsetForKeyboard];
        
    [self adjustOffset];
}

//==============================================================================
- (void)keyboardDidHide:(NSNotification*)notification 
{
    
}

//==============================================================================
- (void)keyboardWillHide:(NSNotification*)notification 
{
    _keyboardRect = CGRectZero;
    _keyboardVisible = NO;
    
    _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^
    {
        self.contentInset = _priorInset;
    }];
    
    [self adjustOffset];
}

#pragma mark - Private Methods
//==============================================================================
- (UIView*)findFirstResponderBeneathView:(UIView*)view 
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) 
    {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) 
            return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) 
            return result;
    }
    return nil;
}

//==============================================================================
- (UIEdgeInsets)contentInsetForKeyboard 
{
    UIEdgeInsets newInset = self.contentInset;
    CGRect keyboardRect = [self keyboardRect];
    newInset.bottom = keyboardRect.size.height - ((keyboardRect.origin.y+keyboardRect.size.height) - (self.bounds.origin.y+self.bounds.size.height)) + 44;
    return newInset;
}

//==============================================================================
-(CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space 
{    
    // Convert the rect to get the view's distance from the top of the scrollView.
    CGRect rect = [view convertRect:view.bounds toView:self];
    
    // Set starting offset to that point
    CGFloat offset = rect.origin.y;

    if ( self.contentSize.height - offset < space ) {
        // Scroll to the bottom
        offset = self.contentSize.height - space;
    } 
    else 
    {
        if ( view.bounds.size.height < space ) 
        {
            // Center vertically if there's room
            offset -= floor((space-view.bounds.size.height)/2.0);
        }
        if ( offset + space > self.contentSize.height ) 
        {
            // Clamp to content size
            offset = self.contentSize.height - space;
        }
    }
    
    if (offset < 0) offset = 0;
    
    return offset;
}

//==============================================================================
- (CGRect)keyboardRect 
{
    CGRect keyboardRect = [self convertRect:_keyboardRect fromView:nil];
    if ( keyboardRect.origin.y == 0 ) 
    {
        CGRect screenBounds = [self convertRect:[UIScreen mainScreen].bounds fromView:nil];
        keyboardRect.origin = CGPointMake(0, screenBounds.size.height - keyboardRect.size.height);
    }
    return keyboardRect;
}

#pragma mark - Public Methods
//==============================================================================
-(void)adjustOffset 
{    
    // Only do this if the keyboard is already visible
    if ( !_keyboardVisible ) 
        return;
    
    CGFloat visibleSpace = self.bounds.size.height - self.contentInset.top - self.contentInset.bottom;
    
    CGPoint idealOffset = CGPointMake(0, [self idealOffsetForView:[self findFirstResponderBeneathView:self] withSpace:visibleSpace]); 
    
    [self setContentOffset:idealOffset animated:YES];                
}

//==============================================================================
- (void)hideKeyBoard
{
    [[self findFirstResponderBeneathView:self] resignFirstResponder];
}

//==============================================================================
- (void)addObjectForKeyboard:(id<UITextInputTraits>)objectForKeyboard
{
    if ([_objectsInKeyboard count] > 0) 
    {
        [[_objectsInKeyboard lastObject] setReturnKeyType:UIReturnKeyNext];
    }
    
    [objectForKeyboard setReturnKeyType:UIReturnKeyDone];
    [_objectsInKeyboard addObject:objectForKeyboard];
}

//==============================================================================
- (void)addObjectsForKeyboard:(NSArray *)objectsForKeyboard
{
    for (id obj in objectsForKeyboard)
    {
        if ([obj conformsToProtocol:@protocol(UITextInputTraits)]) 
        {
            [self addObjectForKeyboard:obj];
        }
        else
        {
            NSAssert(nil, @"MUKit(MUKeyboardAvoidingScrollView): object does not implement the protocol 'UITextInputTraits'");
        }
    }
}

//==============================================================================
- (void)responderShouldReturn:(UIResponder*)aResponder
{    
    NSInteger index = [_objectsInKeyboard indexOfObject:aResponder];
    if (index >= 0 && index < [_objectsInKeyboard count] - 1) 
    {
        [[_objectsInKeyboard objectAtIndex:index + 1] becomeFirstResponder];
    } 
    else
    {
        [aResponder resignFirstResponder];
    }
}

@end
