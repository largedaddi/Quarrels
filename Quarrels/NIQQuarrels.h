//
//  NIQQuarrelsD.h
//  Quarrels
//
//  Created by Sean Pilkenton on 12/3/12.
//  Copyright (c) 2012 Near Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIQQuarrels : NSMutableDictionary

//
// NSDictionary
//

- (NSUInteger)count;

- (id)objectForKey:(id)aKey;

- (NSEnumerator *)keyEnumerator;

//
// NSMutableDictionary
//

- (void)setObject:(id)anObject
           forKey:(id<NSCopying>)aKey;

- (void)removeObjectForKey:(id)aKey;

//
// Quarrels
//

+ (NIQQuarrels *)argsWithArgc:(int)argc
                         argv:(const char **)argv;

- (void)addOptionWithFlag:(NSString *)flag
                    alias:(NSString *)alias
                 required:(BOOL)required
                  preset:(NSString *)def
              explanation:(NSString *)explanation
                  boolean:(BOOL)boolean;

- (void)provideHelp;

@property (nonatomic, assign) int argc;
@property (nonatomic, strong) NSArray *argv;

// Assigned after parse
@property (nonatomic, copy) NSString *help;

@end
