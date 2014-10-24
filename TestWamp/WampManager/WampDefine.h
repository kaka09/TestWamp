

#ifndef QuizApp_WampDefine_h
#define QuizApp_WampDefine_h

#define ADD_PREFIX(api)                 [NSString stringWithFormat:@"com.quizpix.api.%@",api]



#define WAMP_SUBSCRIBE_CHAT_MESSAGE     @"%d.messages"

#define WAMP_CHAT_MESSAGE               @"message"

#endif
