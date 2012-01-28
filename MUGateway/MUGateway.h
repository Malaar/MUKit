//
//  MUGateway.h
//  ROM
//
//  Created by Yuriy Bosov on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

// test line

//==============================================================================
#define CHECK_IS_REQUEST_FAIL(request)                                                  \
if(request.responseStatusCode < 200 || request.responseStatusCode >=300)                \
{                                                                                       \
[self performSelector:request.didFailSelector withObject:request];                      \
return;                                                                                 \
}

//==============================================================================
#define INFORM_SENDER_SUCCESS(message, requestKey)                                     \
id<MUHTTPRequestProcessorProtocol>sender = [requestSenders objectForKey:requestKey];   \
[sender requestDidFinished:message];                                                   \
[self endRequestWithKey:requestKey];


//==============================================================================
#define INFORM_SENDER_FAIL(message, requestKey)                                        \
id<MUHTTPRequestProcessorProtocol>sender = [requestSenders objectForKey:requestKey];   \
[sender requestDidFailed:message];                                                     \
[self endRequestWithKey:requestKey];


//==============================================================================
//==============================================================================
//==============================================================================

@interface MUMessageRequest : NSObject 
{
    int ID;
    int responderCode;
    NSString* textMessage;
    NSMutableDictionary* dataDictionary;
    NSMutableArray* boArray;
}

@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int responderCode;
@property (nonatomic, retain) NSString* textMessage;
@property (nonatomic, readonly) NSMutableDictionary* dataDictionary;
@property (nonatomic, readonly) NSMutableArray* boArray;

- (id)init;

@end

//==============================================================================
//==============================================================================
//==============================================================================

@protocol MUHTTPRequestProcessorProtocol <NSObject>

- (void)requestDidFinished:(MUMessageRequest *)requestMessage;
- (void)requestDidFailed:(MUMessageRequest *)requestMessage;

@end

//==============================================================================
//==============================================================================
//==============================================================================
@interface MUGateway : NSObject 
{
    NSMutableDictionary *requestSenders;
    NSMutableSet* canceledRequests;
}

- (id) init;
- (BOOL) tryToBeginRequestWithSender:(id<MUHTTPRequestProcessorProtocol>)sender forKey:(NSString*)key;
- (void) endRequestWithKey:(NSString*) aKey;
- (void) cancelRequestWithKey:(NSString*) aKey;
- (BOOL) checkIsRequestCanceled:(NSString*) aKey;

- (MUMessageRequest*) messageFromRequest:(ASIHTTPRequest*)aRequest;

@end

//==============================================================================
//==============================================================================
//==============================================================================

