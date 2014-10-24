//
//  WampManager.m
//  QuizApp
//
//  Created by Rikkeisoft258 on 9/15/14.
//  Copyright (c) 2014 Rikkeisoft Co., Ltd. All rights reserved.
//


#import "WampManager.h"
#import "WampDefine.h"
#import "WampDefine.h"
#import "ProjectMacros.h"
#define BASE_URL          @"http://54.92.68.180"
#define KURLSocketServer @"ws://54.92.68.180:9090/"
#define kSocketRealm @"quiz-pix"
#define kSUCESS_CODE @"0"
#define DELAY 15.0f

typedef NS_ENUM(NSUInteger, ConnectionType) {
    CONNECTION
};

@interface WampManager()<MDWampClientDelegate>
{
    ConnectionType connectType;
}

@property (nonatomic, copy) CompletionHandler completeBlock;
@property (nonatomic,strong) MDWamp *wamp;
@end

@implementation WampManager

+ (WampManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    static WampManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
         
    }
    return self;
}

- (BOOL)isConnected {
    return _wamp.isConnected;
}

- (void)connect:(CompletionHandler)completeHandler {
    MDWampTransportWebSocket *transport = [[MDWampTransportWebSocket alloc] initWithServer:[NSURL URLWithString:KURLSocketServer] protocolVersions:@[kMDWampProtocolWamp2json]];
    _wamp = [[MDWamp alloc] initWithTransport:transport realm:kSocketRealm delegate:self];
    NSAssert(_wamp, @"Wamp client is not initalization");
    connectType = CONNECTION;
    self.completeBlock = completeHandler;
    [_wamp connect];
}

- (void)dissconnect:(CompletionHandler)completeBlock
{
    self.completeBlock = completeBlock;
    if (_wamp.isConnected)
        [_wamp disconnect];
    //NSAssert(_wamp, @"Wamp client is not initalization");
}

#pragma mark -
#pragma mark MDWampClientDelegate

- (void) mdwamp:(MDWamp*)wamp sessionEstablished:(NSDictionary*)info {
    NSLog(@"%@",wamp.sessionId);
    _completeBlock(true,info);
//    NSString *subscribeString = [NSString stringWithFormat:@"api:%@.notification",wamp.sessionId];
//    [_wamp subscribe:subscribeString onEvent:^(MDWampEvent *payload) {
//        NSLog(@"abc");
//    } result:^(NSError *error) {
//        [_wamp call:@"api:me" args:nil kwArgs:nil complete:^(MDWampResult *result, NSError *error) {
//            if (error== nil) {
//                // do something with result object
//            } else {
//                // handle the error
//            }
//        }];
//    }];
    
//    NSLog(@"serverd details: %@", info);
//    self.serverDetails.text = [NSString stringWithFormat:@"\n"\
//                               @"authid:\t %@\n"\
//                               @"authmethod:\t %@\n"\
//                               @"authrole:\t %@\n"\
//                               @"roles:\t %@\n", info[@"authid"], info[@"authmethod"], info[@"authrole"], [[info[@"roles"] allKeys] componentsJoinedByString:@", "]];
}

- (void) mdwamp:(MDWamp *)wamp closedSession:(NSInteger)code reason:(NSString*)reason details:(NSDictionary *)details {
    if (code != 0) {
        _completeBlock(false,reason);
        return;
    }
    _completeBlock(true,details);

//    [self.connectIcon setHighlighted:NO];
//    self.connected = NO;
//    self.serverDetails.text = reason;
//    [self.connectButton setTitle:@"CONNECT" forState:UIControlStateNormal];
}

- (void)checkConnectSocket:(CompletionHandler)completeBlock
{
    [self connect:^(BOOL success, id result) {
        if (!success) {
//            [self checkConnectSocket:completeBlock];
            return;
        }
        completeBlock(true,result);
    }];
}


- (void)dealloc
{
    _completeBlock = nil;
}

#pragma mark -
#pragma mark - Chat socket



- (void)subscribeChatWithUserId:(int)userId andDelegate:(id<WampDelegate>)delegate andCompleteBlock:(CompletionHandler)completeBlock
{
    if (!_wamp.isConnected) {
        [self checkConnectSocket:^(BOOL success, id result) {
            if (success) [self subscribeChatWithUserId:userId andDelegate:delegate andCompleteBlock:completeBlock];
        }];
        return;
    }
    
    NSString *subscribeString = [NSString stringWithFormat:WAMP_SUBSCRIBE_CHAT_MESSAGE,userId];
    [_wamp subscribe:ADD_PREFIX(subscribeString) onEvent:^(MDWampEvent *payload) {
        NSDictionary *data = payload.arguments[0];
        if ([CONVERT_TO_STRING([data objectForKey:@"code"]) isEqualToString:kSUCESS_CODE]) {
            [delegate didReceiverMessage:true andResult:[data objectForKey:@"data"]];
        }
        else
        {
            [delegate didReceiverMessage:false andResult:data];
        }

    } result:^(NSError *error) {

        if (error) {
            completeBlock(false,error.localizedDescription);
        }
        else
        {
            completeBlock(true,nil);
        }
    }];
}

- (void)unSubscribeChatWithUserId:(int)userId andCompleteBlock:(CompletionHandler)completeBlock
{
    if (!_wamp.isConnected) {
        [self checkConnectSocket:^(BOOL success, id result) {
            if (success) [self unSubscribeChatWithUserId:userId andCompleteBlock:completeBlock];
        }];
        return;
    }
    
    NSString *subscribeString = [NSString stringWithFormat:WAMP_SUBSCRIBE_CHAT_MESSAGE,userId];
    [_wamp unsubscribe:ADD_PREFIX(subscribeString) result:^(NSError *error)
    {
        if (error) {
            completeBlock(false,error.localizedDescription);
        }
        else
        {
            completeBlock(true,nil);
        }
    }];

}


@end
