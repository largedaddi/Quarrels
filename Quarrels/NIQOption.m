//
//  PRMOption.m
//  Quarrels
//
//  Created by Sean Pilkenton on 11/30/12.
//
//

#import "NIQOption.h"

@interface NIQOption ()
@end

@implementation NIQOption

+ (NIQOption *)optionWithFlag:(NSString *)f
                        alias:(NSString *)a
                     required:(BOOL)r
                      preset:(NSString *)p
                  description:(NSString *)d
                      boolean:(BOOL)b
{
  return [[NIQOption alloc] initWithFlag:f
                                   alias:a
                                required:r
                                 preset:p
                             description:d
                                 boolean:b];
}

- (id)initWithFlag:(NSString *)f
             alias:(NSString *)a
          required:(BOOL)r
           preset:(NSString *)p
       description:(NSString *)d
           boolean:(BOOL)b
{
  self = [super init];
  if (self) {
    self.flag = f;
    self.alias = a;
    self.required = r;
    self.preset = p;
    self.description = d;
    self.boolean = b;
  }
  return self;
}

@end
