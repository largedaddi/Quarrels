//
//  NIQQuarrelsD.m
//  Quarrels
//
//  Created by Sean Pilkenton on 12/3/12.
//  Copyright (c) 2012 Near Infinity. All rights reserved.
//

#import "NIQQuarrels.h"
#import "NIQOption.h"

@interface NIQQuarrels ()
- (id)initWithArgc:(int)argc
              argv:(const char **)argv;
- (void)parse;
- (void)setObject:(id)object
        forOption:(NIQOption *)option;
@end

NSMutableArray *argvToNSMutableArray (int argc, const char * argv[]);

@implementation NIQQuarrels {
  NSMutableDictionary *_backingDictionary;
  NSMutableDictionary *_options;
  NSMutableArray *_orphans;
  BOOL _parsed;
}

#pragma mark - NSDictionary

- (NSUInteger)count
{
  return [_backingDictionary count];
}

- (id)objectForKey:(id)aKey
{
  if (!_parsed && ![_backingDictionary objectForKey:aKey]) {
    _parsed = YES;
    [self parse];
  }
  return [_backingDictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
  return [_backingDictionary keyEnumerator];
}

#pragma mark - NSMutableDictionary

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
  [_backingDictionary setObject:anObject
                         forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
  [_backingDictionary removeObjectForKey:aKey];
}

#pragma mark - Quarrels

+ (NIQQuarrels *)argsWithArgc:(int)argc
                         argv:(const char **)argv
{
  return [[NIQQuarrels alloc] initWithArgc:argc
                                      argv:argv];
}

- (id)initWithArgc:(int)argc argv:(const char **)argv
{
  self = [super init];
  if (self) {
    _orphans = argvToNSMutableArray(argc, argv);
    _backingDictionary = [[NSMutableDictionary alloc] init];
    _options = [[NSMutableDictionary alloc] init];
    _parsed = NO;
    
    self.argc = argc;
    self.argv = [NSArray arrayWithArray:_orphans];
  }
  return self;
}

- (void)addOptionWithFlag:(NSString *)flag
                    alias:(NSString *)alias
                 required:(BOOL)required
                  default:(NSString *)def
              description:(NSString *)description
                  boolean:(BOOL)boolean
{
  NIQOption *option = [NIQOption optionWithFlag:flag
                                          alias:alias
                                       required:required
                                        preset:def
                                    description:description
                                        boolean:boolean];
  [_options setObject:option
                   forKey:flag];
  
  if (alias) {
    [_options setObject:option
                     forKey:alias];
  }
  
  NSLog(@"add option: %@", _options);
  
}

- (NSString *)help
{
 return @"help";
}

- (void)provideHelp
{
  NSLog(@"%@", [self help]);
}

#pragma mark - Private

- (void)parse
{
  NSLog(@"parse!");
  NSMutableArray *argsToBeRemoved = [[NSMutableArray alloc] init];
  for (int i = 0; i < _orphans.count; i++) {
    NSString *arg = _orphans[i];
    if ([arg hasPrefix:@"-"]) {
      [argsToBeRemoved addObject:[NSNumber numberWithInt:i]];
      
      int offset = ([arg hasPrefix:@"--"]) ? 2 : 1;
      NSString *optionName = [arg substringFromIndex:offset];
      NIQOption *option = _options[optionName];
      
      if (!option) {
        NSLog(@"No option with the name: %@ found.", optionName);
        exit(0);
        return;
      }
      
      if (option.boolean) {
        [self setObject:@YES forOption:option];
      } else {
        NSString *value = _orphans[i + 1];
        if ([value hasPrefix:@"-"]) {
          NSLog(@"No value supplied for %@", optionName);
          return;
        }
        [self setObject:value forOption:option];
        [argsToBeRemoved addObject:[NSNumber numberWithInt:(i + 1)]];
      }
      
    }
    
  }
  
  
  
  [_orphans removeObjectsInArray:argsToBeRemoved];
}

- (NSString *)valueKeyForOption:(NIQOption *)o
{
  NSString *key = (o.alias) ? o.alias : o.flag;
  return key;
}

- (void)setObject:(id)object
        forOption:(NIQOption *)option
{
  option.value = object;
  
  [self setObject:object
           forKey:option.flag];
  
  if (option.alias) {
    [self setObject:object
             forKey:option.alias];
  }
}

@end

NSMutableArray *argvToNSMutableArray (int argc, const char * argv[]) {
  NSMutableArray *ma = [[NSMutableArray alloc] init];
  NSString *arg = nil;
  for (int i = 1; i < argc; i++) {
    arg = [NSString stringWithUTF8String:argv[i]];
    [ma addObject:arg];
  }
  return ma;
}

