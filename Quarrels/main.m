//
//  main.m
//  Quarrels
//
//  Created by Sean Pilkenton on 12/1/12.
//  Copyright (c) 2012 Near Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIQuarrels.h"
#import "NIOption.h"

int main(int argc, const char * argv[])
{
  
  @autoreleasepool {
    
    NIQuarrels *quarrels = [NIQuarrels argsWithArgc:argc
                                                 argv:argv];
    
    [quarrels addOptionWithFlag:@"a"
                          alias:@"add"
                       required:YES
                        preset:nil
                    explanation:@"for adding"
                        boolean:NO];
    
    [quarrels addOptionWithFlag:@"b"
                          alias:@"bad"
                       required:NO
                        preset:nil
                    explanation:@"for badding"
                        boolean:NO];

    NSString *value = quarrels[@"add"];
    
    NSLog(@"value %@", value);
    
    value = quarrels[@"bad"];
    if (value) {
      NSLog(@"value %@", value);
    }
   
    [quarrels provideHelp];
  }
  return 0;
}




