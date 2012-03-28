//
//  AutoresizeButton.h
//  MUKit
//
//  Created by Yuriy Bosov on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//==============================================================================
//==============================================================================
//==============================================================================
typedef struct
{
    int topCapHeight;
    int leftCapHeight;
} ImageCapSize;

static inline ImageCapSize ImageCapSizeMake(int leftCapHeight, int topCapHeight)
{
    ImageCapSize imageCapSize;
    imageCapSize.leftCapHeight = leftCapHeight;
    imageCapSize.topCapHeight = topCapHeight;
    return imageCapSize;
}

static inline ImageCapSize ImageCapSizeNone()
{
    ImageCapSize imageCapSize;
    imageCapSize.leftCapHeight = -1;
    imageCapSize.topCapHeight = -1;
    return imageCapSize;
}

//==============================================================================
//==============================================================================
//==============================================================================
typedef struct  
{
    int leftOffset;
    int rightOffset;
} TitleOffset;

static inline TitleOffset TitleOffsetMake(int leftOffset, int rightOffset)
{
    TitleOffset titleOffset;
    titleOffset.leftOffset = leftOffset;
    titleOffset.rightOffset = rightOffset;
    return titleOffset;
}

static inline TitleOffset TitleOffsetZero()
{
    TitleOffset titleOffset;
    titleOffset.leftOffset = 0;
    titleOffset.rightOffset = 0;
    return titleOffset;
}

static inline TitleOffset TitleOffsetDefault()
{
    TitleOffset titleOffset;
    titleOffset.leftOffset = 9;
    titleOffset.rightOffset = 9;
    return titleOffset;
}

static inline TitleOffset TitleOffsetForNavBack()
{
    TitleOffset titleOffset;
    titleOffset.leftOffset = 15;
    titleOffset.rightOffset = 9;
    return titleOffset;
}

//==============================================================================
//==============================================================================
//==============================================================================
/// Autoresized button
@interface MUAutoresizeButton : UIButton 
{
    NSString *_title;
    NSString *_imageName;
    ImageCapSize _imageCapSize;
    TitleOffset _titleOffset;
    int _maxWidth;
    int _minWidth;
}

@property (nonatomic, assign) int maxWidth;
@property (nonatomic, assign) int minWidth;

+(id) buttonByImageName:(NSString*) imageName;

+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName;

+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
           imageCapSize:(ImageCapSize) imageCapSize;

+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
            titleOffset:(TitleOffset) titleOffset;

+(id) buttonByTitleName:(NSString*) titleName 
              imageName:(NSString*) imageName 
           imageCapSize:(ImageCapSize) imageCapSize
            titleOffset:(TitleOffset) titleOffset;

+(id) buttonForNavBackByTitleName:(NSString*) titleName 
                        imageName:(NSString*) imageName;

- (void) setupFont:(UIFont *)font;
- (void) setAutoresizeTitle:(NSString*)aTitle;

@end
