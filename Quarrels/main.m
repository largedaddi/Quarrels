//
//  main.m
//  Quarrels
//
//  Created by Sean Pilkenton on 12/1/12.
//  Copyright (c) 2012 Near Infinity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIQQuarrels.h"
#import "NIQOption.h"

int main(int argc, const char * argv[])
{
  
  @autoreleasepool {
    
    NIQQuarrels *quarrels = [NIQQuarrels argsWithArgc:argc
                                                 argv:argv];
    
    [quarrels addOptionWithFlag:@"a"
                          alias:@"add"
                       required:YES
                        preset:nil
                    description:@"for adding"
                        boolean:NO];
    
    [quarrels addOptionWithFlag:@"b"
                          alias:@"bad"
                       required:NO
                        preset:nil
                    description:@"for badding"
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




