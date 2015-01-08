//
//  CRBaseModel.h
//  iOS-mvvm
//
//  Created by andrea gonteri on 08/01/15.
//  Copyright (c) 2015 CODR. All rights reserved.
//

#import <Mantle/Mantle.h>

/** 
 `CRBaseModel` has a default implementation for JSONKeyPathByPropertyKey that returns an empty dictionary
 so that by default all models will attempt to serialize JSON keys to the same property names.
 */
@interface CRBaseModel : MTLModel <MTLJSONSerializing>//MTLManagedObjectSerializing

/**
 NSUInteger The model ID property
 */
@property (nonatomic, assign) NSUInteger objectID;


/**
 Override of dictionaryValue, it fixes the Mantle deserialization issues (NSDate transformation, inner Objects transformation)
 */
//- (NSDictionary *)toDictionaryValue;

+ (NSArray*)propertyKeysToExcludeInDictionaryValue;

@end

//@interface NSValueTransformer (IwooApi)
//
//+ (instancetype)dateJSONTransformer;
//
//@end
