//
//  MUCellTextView.m
//  MUKitTest
//
//  Created by Malaar on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MUCellTextView.h"
#import "MUCellDataTextView.h"
#import <QuartzCore/QuartzCore.h>

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUCellTextView ()


@end


//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUCellTextView

@synthesize textView;

//==============================================================================
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [self.contentView addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        textView = [[[MUTextView alloc] initWithFrame:CGRectZero] autorelease];
        [self.contentView addSubview:textView];
        textView.backgroundColor = [UIColor clearColor];
        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [textView addObserver:self forKeyPath:@"observedText" options:NSKeyValueObservingOptionNew context:NULL];
        
        
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [textView removeObserver:self forKeyPath:@"observedText"];
    
    [super dealloc];
}

//==============================================================================
- (void) setupCellData:(MUCellData *)aCellData
{
    [super setupCellData:aCellData];
    
    MUCellDataTextView* cellDataTextView = (MUCellDataTextView*)aCellData;
    
    // text
    CGFloat cellHeight = [cellDataTextView cellHeightForWidth:self.bounds.size.width];
    CGFloat titleHeight = (cellDataTextView.title) ? cellDataTextView.titleFont.lineHeight : 0;
    textView.frame = CGRectMake(0, titleHeight, self.bounds.size.width, cellHeight - titleHeight);

    textView.autocapitalizationType = cellDataTextView.autocapitalizationType;
    textView.autocorrectionType = cellDataTextView.autocorrectionType;
    textView.keyboardType = cellDataTextView.keyboardType;
    textView.keyboardAppearance = cellDataTextView.keyboardAppearance;
    textView.returnKeyType = cellDataTextView.returnKeyType;
    
    textView.text = cellDataTextView.text;
    textView.font = cellDataTextView.textFont;
    textView.textColor = cellDataTextView.textColor;
    textView.textAlignment = cellDataTextView.textAlignment;
    textView.editable = self.cellData.enableEdit;
    
    textView.validator = cellDataTextView.validator;
    textView.filter = cellDataTextView.filter;
    
    if (cellDataTextView.placeholder)
        textView.placeholder = cellDataTextView.placeholder;
    if (cellDataTextView.placeholderColor)
        textView.placeholderColor = cellDataTextView.placeholderColor;

    // title
    titleLabel.frame = CGRectMake(10, 0, self.bounds.size.width - 20, titleHeight);
    titleLabel.text = cellDataTextView.title;
    titleLabel.textColor = cellDataTextView.titleColor;
    titleLabel.font = cellDataTextView.titleFont;
    
}

//==============================================================================
- (NSArray *) inputTraits
{
    if (self.cellData.enableEdit)
        return [NSArray arrayWithObject:textView];
    
    return nil;
}

//==============================================================================
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"Observing: %@", [change objectForKey:NSKeyValueChangeNewKey]);
    ((MUCellDataTextView*)self.cellData).text = [change objectForKey:NSKeyValueChangeNewKey];
}

@end
