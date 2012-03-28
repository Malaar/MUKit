//
//  MULogConsumerFile.h
//  MULogger
//
//  Created by Malaar on 04.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MULogConsumer.h"


//typedef enum MULogUpdateFilePolicy
//{
//    updateFilePolicyByDate,
//    updateFilePolicyBySize
//    
//} MULogUpdateFilePolicy;

@interface MULogConsumerFile : MULogConsumer
{
}

@property (nonatomic, retain) NSString* filePath;

@end
