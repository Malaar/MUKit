//
//  MUGateway.m
//  ROM
//
//  Created by Yuriy Bosov on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MUGateway.h"

//==============================================================================
//==============================================================================
//==============================================================================

#pragma mark -
#pragma mark class MUMessageRequest
#pragma mark -
@implementation MUMessageRequest

//==============================================================================
@synthesize ID, responderCode, textMessage, dataDictionary, boArray;

//==============================================================================
- (id)init
{
    self = [super init];
    if(self)
    {
        dataDictionary = [NSMutableDictionary new];
        boArray = [NSMutableArray new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [textMessage release];
    [dataDictionary release];
    [boArray release];
    
    [super dealloc];
}

@end

//==============================================================================
//==============================================================================
//==============================================================================

#pragma mark -
#pragma mark class MUGateway
#pragma mark -
@implementation MUGateway

#pragma mark - init/dealloc
//==============================================================================
- (id) init
{
    self = [super init];
    if (self) 
    {
        requestSenders = [[NSMutableDictionary alloc] init];
        canceledRequests = [NSMutableSet new];
    }
    return self;
}

//==============================================================================
- (void) dealloc
{
    [requestSenders release];
    [canceledRequests release];
    
    [super dealloc];
}

#pragma mark - request
//==============================================================================
- (BOOL) tryToBeginRequestWithSender:(id<MUHTTPRequestProcessorProtocol>)sender forKey:(NSString*)aKey
{
    NSAssert(aKey, @"aKey is nil !!!");
    BOOL resalt = NO;
    if ([requestSenders objectForKey:aKey] == nil) 
    {
        [requestSenders setObject:sender forKey:aKey];
        resalt = YES;
    }
    else
    {
//        NSString *assertMessage = [NSString stringWithFormat:@"request with key \"%@\" already exists", key];
//        NSAssert(nil, assertMessage);
//        NSAssert(nil, [NSString stringWithFormat:@"request with key \"%@\" already exists", key]);
    }
    return resalt;
}

//==============================================================================
- (void) endRequestWithKey:(NSString*)aKey
{
    NSAssert(aKey, @"aKey is nil !!!");
    [requestSenders removeObjectForKey:aKey]; 
}

//==============================================================================
- (void) cancelRequestWithKey:(NSString*)aKey
{
    NSAssert(aKey, @"aKey is nil !!!");
    if([requestSenders objectForKey:aKey])
    {
        [self endRequestWithKey:aKey];
        [canceledRequests addObject:aKey];
    }
}

//==============================================================================
- (BOOL) checkIsRequestCanceled:(NSString*) aKey
{
    NSAssert(aKey, @"aKey is nil !!!");

    BOOL result = NO;
    if([canceledRequests containsObject:aKey])
    {
        result = YES;
        [canceledRequests removeObject:aKey];
    }
    
    return result;
}

//==============================================================================
- (MUMessageRequest*) messageFromRequest:(ASIHTTPRequest*)aRequest
{
    MUMessageRequest* message = [[[MUMessageRequest alloc] init] autorelease];
    message.responderCode = aRequest.responseStatusCode;
    
    return message;
}

//==============================================================================
//==============================================================================
//==============================================================================
@end
