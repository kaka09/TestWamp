//
//  WampManager.h
//  QuizApp
//
//  Created by Rikkeisoft258 on 9/15/14.
//  Copyright (c) 2014 Rikkeisoft Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MDWamp/MDWamp.h>
#import "WampDelegate.h"

#define BASE_URL          @"http://54.92.68.180"
#define KURLSocketServer @"ws://54.92.68.180:9090/"


#define kSocketRealm @"quiz-pix"
#define OS_TYPE           1

typedef void (^CompletionHandler)(BOOL success, id result);


typedef void (^CompletionHandler)(BOOL success, id result);

@interface WampManager : NSObject

+ (WampManager *)sharedInstance;

- (BOOL)isConnected;
- (void)connect:(CompletionHandler)completeBlock;
- (void)dissconnect:(CompletionHandler)completeBlock;

#pragma mark -
#pragma mark - Play Game socket


- (void)subscribeChatWithUserId:(int)userId andDelegate:(id<WampDelegate>)delegate andCompleteBlock:(CompletionHandler)completeBlock;

- (void)unSubscribeChatWithUserId:(int)userId andCompleteBlock:(CompletionHandler)completeBlock;


@end
