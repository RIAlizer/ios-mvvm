//
//  LoggingAssertionHandler.m
//  Codr Ltd
//
//  Created by Andrea Gonteri Codr Ltd on 28/10/2014.
//
// more info http://nshipster.com/nsassertionhandler/

#import "LoggingAssertionHandler.h"

#define kForceExceptions kLoggingAssertionHandlerForceExceptions
#define kLoggingAssertionHandlerRowSeparator @"\n\n ############### LoggingAssertionHandler "

@implementation LoggingAssertionHandler

- (void)handleFailureInMethod:(SEL)selector
                       object:(id)object
                         file:(NSString *)fileName
                   lineNumber:(NSInteger)line
                  description:(NSString *)format, ...
{

    
    NSString *reason = [NSString stringWithFormat:@"NSAssert Failure: Method %@ for object %@ in %@#%li \n\n", NSStringFromSelector(selector), object, fileName, (long)line];
    
    DDLogError(@"ASSERTION FAILURE %@ %@", kLoggingAssertionHandlerRowSeparator, reason);

#if kForceExceptions
    @throw [NSException exceptionWithName:@"LoggingAssertionHandler" reason:reason userInfo:nil];
#endif
}

- (void)handleFailureInFunction:(NSString *)functionName
                           file:(NSString *)fileName
                     lineNumber:(NSInteger)line
                    description:(NSString *)format, ...
{
    NSString *reason = [NSString stringWithFormat:@"NSCAssert Failure: Function (%@) in %@#%li \n\n", functionName, fileName, line];
    DDLogError(@"ASSERTION FAILURE  %@ %@", kLoggingAssertionHandlerRowSeparator, reason);

#if kForceExceptions
    @throw [NSException exceptionWithName:@"LoggingAssertionHandler" reason:reason userInfo:nil];
#endif
}

@end
