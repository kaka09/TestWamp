//
//  MDWampSerializationMsgpack.m
//  MDWamp
//
//  Created by Niko Usai on 24/06/14.
//  Copyright (c) 2014 mogui.it. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "MDWampSerializationMsgpack.h"
#import "MessagePack.h"

@implementation MDWampSerializationMsgpack
- (id) pack:(NSArray*)arguments
{
    return [arguments messagePack];
}

- (NSArray*) unpack:(id)data
{
    NSData *d = data;
    if (![data isKindOfClass:[NSData class]]) {
        d = [(NSString*)data dataUsingEncoding:NSUTF8StringEncoding];
    }
    return [d messagePackParse];
}
@end
