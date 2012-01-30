//
//  MUKeyboardAvoidingScrollView.m
//  MUKit
//
//  Created by Yuriy Bosov on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUKeyboardAvoidingScrollView.h"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

//==============================================================================
@interface MUKeyboardAvoidingScrollView (Init)

- (void)setup;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUKeyboardAvoidingScrollView (Private)

- (UIView*)findFirstResponderBeneathView:(UIView*)view;
- (UIEdgeInsets)contentInsetForKeyboard;
- (CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space;
- (CGRect)keyboardRect;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUKeyboardAvoidingScrollView

#pragma mark - Init/Dealloc
//==============================================================================
-(id)initWithFrame:(CGRect)frame 
{
    if ( !(self = [super initWithFrame:frame]) ) 
    {
        [self setup];
    }
    return self;
}

//==============================================================================
-(void)awakeFromNib 
{
    [super awakeFromNib];
    [self setup];
}

//==============================================================================
- (void)setup 
{
    if ( CGSizeEqualToSize(self.contentSize, CGSizeZero) )
        self.contentSize = self.bounds.size;
    
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
    
    CGSize contentSize = _originalContentSize;
    contentSize.width = MAX(contentSize.width, self.frame.size.width);
    contentSize.height = MAX(contentSize.height, self.frame.size.height);
    [super setContentSize:contentSize];
    
    if ( _keyboardVisible ) 
    {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

//==============================================================================
-(void)setContentSize:(CGSize)contentSize 
{
    _originalContentSize = contentSize;
    
    contentSize.width = MAX(contentSize.width, self.frame.size.width);
    contentSize.height = MAX(contentSize.height, self.frame.size.height);
    [super setContentSize:contentSize];
    
    if ( _keyboardVisible ) 
    {
        self.contentInset = [self contentInsetForKeyboard];
    }
}

//==============================================================================
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [self hideKeyBoard];
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
        // No child view is the first responder - nothing to do here
        return;
    }
    
    _priorInset = self.contentInset;
    
    // Shrink view's inset by the keyboard's height, and scroll to show the text field/view being edited
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    self.contentInset = [self contentInsetForKeyboard];
    [self setContentOffset:CGPointMake(self.contentOffset.x, 
                                       [self idealOffsetForView:firstResponder withSpace:[self keyboardRect].origin.y - self.bounds.origin.y]) 
                  animated:YES];
    
    [UIView commitAnimations];
}

//==============================================================================
- (void)keyboardWillHide:(NSNotification*)notification 
{
    _keyboardRect = CGRectZero;
    _keyboardVisible = NO;
    
    // Restore dimensions to prior size
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    self.contentInset = _priorInset;
    [UIView commitAnimations];
}

//==============================================================================
- (void)keyboardDidHide:(NSNotification*)notification 
{    
    if (self.contentOffset.y > 0 && self.frame.size.height > self.contentSize.height - 20)
        self.contentOffset = CGPointZero;
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
- (UIEdgeInsets)contentInsetForKeyboard {
    UIEdgeInsets newInset = self.contentInset;
    CGRect keyboardRect = [self keyboardRect];
    newInset.bottom = keyboardRect.size.height - ((keyboardRect.origin.y+keyboardRect.size.height) - (self.bounds.origin.y+self.bounds.size.height));
    return newInset;
}

//==============================================================================
-(CGFloat)idealOffsetForView:(UIView *)view withSpace:(CGFloat)space 
{    
    // Convert the rect to get the view's distance from the top of the scrollView.
    CGRect rect = [view convertRect:view.bounds toView:self];
    
    // Set starting offset to that point
    CGFloat offset = rect.origin.y;
    
    if ( self.contentSize.height - offset < space ) 
    {
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
    if ( !_keyboardVisible ) return;
    
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
    BOOL findResponder = [_objectsInKeyboard containsObject:aResponder];
    NSInteger index = [_objectsInKeyboard indexOfObject:aResponder];
    if (findResponder && index >= 0 && index < [_objectsInKeyboard count] - 1) {
        [[_objectsInKeyboard objectAtIndex:index + 1] becomeFirstResponder];
    } else{
        [aResponder resignFirstResponder];
    }
}

@end