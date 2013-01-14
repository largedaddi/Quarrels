//
//  NIOption.m
//  Quarrels
//
//  Created by Sean Pilkenton on 11/30/12.
//
//

#import "NIOption.h"
#import <objc/runtime.h>

@interface NIOption ()
@end

@implementation NIOption

+ (NIOption *)optionWithFlag:(NSString *)f
                        alias:(NSString *)a
                     required:(BOOL)r
                       preset:(NSString *)p
                  explanation:(NSString *)e
                      boolean:(BOOL)b
{
  return [[NIOption alloc] initWithFlag:f
                                   alias:a
                                required:r
                                  preset:p
                             explanation:e
                                 boolean:b];
}

- (id)initWithFlag:(NSString *)f
             alias:(NSString *)a
          required:(BOOL)r
            preset:(NSString *)p
       explanation:(NSString *)e
           boolean:(BOOL)b
{
  self = [super init];
  if (self) {
    self.flag = f;
    self.alias = a;
    self.required = r;
    self.preset = p;
    self.explanation = e;
    self.boolean = b;
  }
  return self;
}

- (NSString *)description
{
  NSString *alias = self.alias ? [NSString stringWithFormat:@", %@", self.alias] : @"";
  NSString *required = self.required ? @"[required]" : @"";
  NSString *explanation = self.explanation ? self.explanation : @"";
  NSString *description = [NSString stringWithFormat:@"-%@%@ %@ %@", self.flag, alias, explanation, required];
  
  return description;
}

@end
