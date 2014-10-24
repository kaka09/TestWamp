/**
 * @brief ProjectMacros.h
 * @author Hoàng Cừ
 * @date 7/10/14
 * @copyright (c) 2014 Rikkeisoft Co., Ltd. All rights reserved
 */

#pragma mark -

#pragma mark - Macro SET - GET USER DEFAULT

#define SET_OBJECT(key,value) \
[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:value]\
forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];

#define GET_OBJECT(key)\
![[NSUserDefaults standardUserDefaults] objectForKey:key] ? nil :[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]]

#pragma mark Define Debug Log
/**
 * @brief Debug log macros
 */
#ifdef CM_DEBUG

#define CM_LOG(...) NSLog(__VA_ARGS__)
#define CM_LOG_DETAIL(fmt, ...) NSLog((@"%s [Line %d] " fmt), \
__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#define CM_LOG(...)
#define CM_LOG_DETAIL(...)

#endif

//return string
#define FileLog(format, ...) \
[NSString stringWithFormat:@"\n %s [Line %d] \n %@", \
__PRETTY_FUNCTION__, \
__LINE__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]]

#pragma mark -
#pragma mark Define Delegate
/**
 * @brief Get appdelegate macros
 */
#define CM_APP_DELEGATE [[UIApplication sharedApplication] delegate]

#pragma mark -
#pragma mark Define Check system version
/**
 * @brief Check iOS version equal v
 * @param v iOS version
 * @return YES true NO false
 */
#define CM_SYSTEM_VERSION_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

/**
 * @brief Check iOS version greater than v
 * @param v Version
 * @param YES true NO false
 */
#define CM_SYSTEM_VERSION_GREATER_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
== NSOrderedDescending)
/**
 * @brief Check iOS version greater than or equal v
 * @param v iOS version
 * @return YES if true NO if false
 */
#define CM_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
!= NSOrderedAscending)

/**
 * @brief Check iOS version less than v
 * @param v iOS version
 * @return YES if true NO if false
 */
#define CM_SYSTEM_VERSION_LESS_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
== NSOrderedAscending)

/**
 * @brief Check iOS version less than or equal v
 * @param v iOS version
 * @return YES if true NO if false
 */
#define CM_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
!= NSOrderedDescending)

#pragma mark -
#pragma mark Define Call Delegate functions

/**
 * @brief Call delegate function with argument
 * @param delegate delegate
 * @param selector delegate function
 * @parm argument selector's argument
 */
#define RK_CALL_DELEGATE_FUNCTION_WITH_ARG(delegate, selector, argument) \
do { \
if(delegate != nil && [delegate respondsToSelector:selector]) { \
[delegate performSelector:selector withObject:argument]; \
} \
} while(0);

/**
 * @brief Call delegate function with arguments
 * @param delegate delegate
 * @param selector delegate function
 * @param arg1 argument 1
 * @param arg2 argument 2
 */
#define RK_CALL_DELEGATE_FUNCTION_WITH_ARGS(delegate, selector, arg1, arg2) \
do { \
if(delegate != nil && [delegate respondsToSelector:selector]) { \
[delegate performSelector:selector withObject:arg1 withObject:arg2]; \
} \
} while(0);

/*-------------------- DESIGN BY HUYHL --------------------*/

/**
 * @brief concat 2 string each other
 * @param twice string
 * @return string
 */
#define CONCAT_URL(...)                     [NSString stringWithFormat:@"%@%@",__VA_ARGS__]

/**
 *  @brief convert object to string
 *  @param twice id
 *  @return string
 */
#define CONVERT_TO_STRING(...)                              [NSString stringWithFormat:@"%@",__VA_ARGS__]

#ifndef MU_DEVICE_IS_IPHONE_3_5_INCH
#   define MU_DEVICE_IS_IPHONE_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480.0)
#endif


/**
 *  @brief switch case for NSString
 *
 *  @param str switch NSString
 */
#define STRING_CASE(str)                       if ([__s__ isEqualToString:(str)])
#define STRING_SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define STRING_DEFAULT
/*--------------------        END       --------------------*/
