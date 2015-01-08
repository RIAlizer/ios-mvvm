//
//  CRBaseModel.m
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import "CRBaseModel.h"
#import <objc/runtime.h>

@implementation CRBaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // properties defined in header < : > key in JSON Dictionary
    return @{@"objectID": @"id",
             };
}

+ (NSArray*)propertyKeysToExcludeInDictionaryValue
{
    return @[];
}

//- (NSDictionary *)toDictionaryValue
//{
//    NSMutableDictionary *JSONDictionary = [[super dictionaryValue] mutableCopy];
//    [JSONDictionary removeObjectsForKeys:self.class.propertyKeysToExcludeInDictionaryValue];
//
//    NSArray *listOfProperty = JSONDictionary.allKeys;
//    for (id property in listOfProperty)
//    {
//        id value = [self valueForKey:property];
//        if([value isKindOfClass:[NSDate class]])
//        {
//            NSString *stringDate = [[NSValueTransformer dateJSONTransformer] reverseTransformedValue:value];
//            [JSONDictionary setObject:stringDate forKey:property];
//        }
//        else if([value isKindOfClass:[CRBaseModel class]])
//        {
//            id inner = [self valueForKey:property];
//            CRBaseModel *innerModel = (CRBaseModel*)inner;
//            NSDictionary *innerObjectDictionary = innerModel.toDictionaryValue;
//            [JSONDictionary setObject:innerObjectDictionary forKey:property];
//        }
//        else if([property isEqualToString:@"objectID"])
//        {
//            [JSONDictionary addEntriesFromDictionary:@{@"id":value}];
//        }
//    }
//    return JSONDictionary;
//}

@end

