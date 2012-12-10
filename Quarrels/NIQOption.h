//
//  PRMOption.h
//  Quarrels
//
//  Created by Sean Pilkenton on 11/30/12.
//
//

#import <Foundation/Foundation.h>

@interface NIQOption : NSObject

+ (NIQOption *)optionWithFlag:(NSString *)f
                        alias:(NSString *)a
                     required:(BOOL)r
                       preset:(NSString *)p
                  explanation:(NSString *)e
                      boolean:(BOOL)b;

- (id)initWithFlag:(NSString *)f
             alias:(NSString *)a
          required:(BOOL)r
            preset:(NSString *)p
       explanation:(NSString *)e
           boolean:(BOOL)b;

- (NSString *)description;

@property (nonatomic, copy) NSString *flag;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, assign) BOOL required;
@property (nonatomic, copy) NSString *preset;
@property (nonatomic, copy) NSString *explanation;
@property (nonatomic, assign) BOOL boolean;
@property (nonatomic, copy) NSString *value;

@end
