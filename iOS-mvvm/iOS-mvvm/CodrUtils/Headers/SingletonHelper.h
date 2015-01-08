//
//  SingletonHelper.h
//
//  Created by andrea gonteri on 02/03/12.
//  Copyright (c) 2012 Rializer. All rights reserved.
//
//  Fixed singleton for testing http://twobitlabs.com/2013/01/objective-c-singleton-pattern-unit-testing/

#if __has_feature(objc_arc)

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname)\
\
static id _sharedInstance = nil;\
static dispatch_once_t once_token = 0;\
\
\
+ (instancetype)sharedInstance {\
    static classname *sharedInstance = nil;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        if (_sharedInstance == nil) {\
            sharedInstance = [[self alloc] init];\
        }\
    });\
    return sharedInstance;\
}\
\
+(void)setSharedInstance:(id)instance {\
    once_token = 0;\
    _sharedInstance = instance;\
}\

#else

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *sharedInstance = nil; \
 \
\
+ (classname *)sharedInstance \
{ \
    @synchronized(self) \
    { \
        if (sharedInstance == nil) \
        { \
            sharedInstance = [[self alloc] init]; \
        } \
    } \
\
    return sharedInstance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
    @synchronized(self) \
    { \
        if (sharedInstance == nil) \
        { \
            sharedInstance = [super allocWithZone:zone]; \
            return sharedInstance; \
        } \
    } \
\
    return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    return self; \
} \
\
- (id)retain \
{ \
    return self; \
} \
\
- (NSUInteger)retainCount \
{ \
    return NSUIntegerMax; \
} \
\
- (oneway void)release \
{ \
} \
\
- (id)autorelease \
{ \
    return self; \
}

#endif
