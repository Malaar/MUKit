//
//  AutoresizeButton.m
//  Privatext
//
//  Created by Yuriy Bosov on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUAutoresizeButton.h"

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUAutoresizeButton (Private)

- (void) setTitleName:(NSString*) titleName 
            imageName:(NSString*) imageName 
         imageCapSize:(ImageCapSize) imageCapSize 
          titleOffset:(TitleOffset)titleOffset;
- (UIImage*)getAutoresizeImageByFont:(UIFont*)font;
- (void)addImage:(UIImage*)image;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@implementation MUAutoresizeButton

@synthesize maxWidth = _maxWidth;
@synthesize minWidth = _minWidth;

//==============================================================================
+(id) buttonByImageName:(NSString*) imageName
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:nil imageName:imageName imageCapSize:ImageCapSizeNone() titleOffset:TitleOffsetDefault()];
    return btn;
}

//==============================================================================
+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:titleName imageName:imageName imageCapSize:ImageCapSizeNone() titleOffset:TitleOffsetDefault()];
    return btn;
}

//==============================================================================
+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
           imageCapSize:(ImageCapSize) imageCapSize
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:titleName imageName:imageName imageCapSize:imageCapSize titleOffset:TitleOffsetDefault()];
    return btn;
}

//==============================================================================
+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
            titleOffset:(TitleOffset) titleOffset
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:titleName imageName:imageName imageCapSize:ImageCapSizeNone() titleOffset:titleOffset];
    return btn;
}

//==============================================================================
+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
           imageCapSize:(ImageCapSize) imageCapSize
            titleOffset:(TitleOffset) titleOffset
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:titleName imageName:imageName imageCapSize:imageCapSize titleOffset:titleOffset];
    return btn;
}

//==============================================================================
+(id) buttonForNavBackByTitleName:(NSString*) titleName 
                        imageName:(NSString*) imageName
{
    MUAutoresizeButton *btn = [MUAutoresizeButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleName:titleName imageName:imageName imageCapSize:ImageCapSizeNone() titleOffset:TitleOffsetForNavBack()];
    return btn;
}

//==============================================================================
- (void) setTitleName:(NSString *)titleName 
            imageName:(NSString *)imageName 
         imageCapSize:(ImageCapSize)imageCapSize 
          titleOffset:(TitleOffset)titleOffset
{
    _title = [titleName retain];
    _imageName = [imageName retain];
    _imageCapSize = imageCapSize;
    _titleOffset = titleOffset;
    _maxWidth = 0;
    
    [self setupFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
}

//==============================================================================
-(void)setupFont:(UIFont *)font
{
    UIImage *image = [self getAutoresizeImageByFont:font];
    
    if (image)
        [self setBackgroundImage:image forState:UIControlStateNormal];
    
    if (_title)
    {
        [self setTitle:_title forState:UIControlStateNormal];
        self.titleLabel.font = font;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.shadowOffset = CGSizeMake(0,-1);
        self.titleLabel.shadowColor = [UIColor darkGrayColor];
    }
}

//==============================================================================
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

//==============================================================================
- (UIImage*)getAutoresizeImageByFont:(UIFont*)font
{
    UIImage *image = [UIImage imageNamed:_imageName];
    if (!image)
        return nil;
    
    CGSize sizeButton = image.size;
    
    if (_title)
    {
        CGSize sizeImage = image.size;
        CGSize sizeTitle = [_title sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, sizeButton.height)];

        if (sizeTitle.width > sizeImage.width - _titleOffset.leftOffset - _titleOffset.rightOffset)
        {               
            self.titleEdgeInsets = UIEdgeInsetsMake(self.titleEdgeInsets.top, 
                                                    _titleOffset.leftOffset, 
                                                    self.titleEdgeInsets.bottom, 
                                                    _titleOffset.rightOffset);
        }
        
        if (_imageCapSize.leftCapHeight >= 0 && _imageCapSize.topCapHeight >= 0) 
            image = [image stretchableImageWithLeftCapWidth:_imageCapSize.leftCapHeight topCapHeight:_imageCapSize.topCapHeight];
        else
            image = [image stretchableImageWithLeftCapWidth:sizeImage.width/2 topCapHeight:sizeImage.height/2];
        
        float width = sizeImage.width > sizeTitle.width + _titleOffset.leftOffset + _titleOffset.rightOffset ? sizeImage.width : sizeTitle.width + _titleOffset.leftOffset + _titleOffset.rightOffset;        
        sizeButton = CGSizeMake(width, image.size.height);
    }
    
    if (_maxWidth > 0 && _maxWidth < sizeButton.width)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _maxWidth, sizeButton.height);
    else
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeButton.width, sizeButton.height);
    return image;
}

//==============================================================================
- (void)setMaxWidth:(int)maxWidth
{
    if (maxWidth < self.frame.size.width)
    {
        _maxWidth = maxWidth;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, _maxWidth, self.frame.size.height);
    }
}

//==============================================================================
- (void) setMinWidth:(int)minWidth
{
    if (minWidth > self.frame.size.width)
    {
        _minWidth = minWidth;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.x, _minWidth, self.frame.size.height);
    }
}

//==============================================================================
- (void) setAutoresizeTitle:(NSString*)aTitle
{
	[_title release];
	_title = [aTitle retain];

    [self setupFont:[UIFont boldSystemFontOfSize:14]];
}

//==============================================================================
- (void) dealloc
{
    [_title release];
    [_imageName release];
    
    [super dealloc];
}

//==============================================================================
//==============================================================================
//==============================================================================

@end
