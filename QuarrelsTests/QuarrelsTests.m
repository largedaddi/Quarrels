//
//  QuarrelsTests.m
//  QuarrelsTests
//
//  Created by Sean Pilkenton on 12/2/12.
//  Copyright (c) 2012 Near Infinity. All rights reserved.
//

#import "QuarrelsTests.h"
#import "NIQQuarrels.h"

const char ** initArgv (int argc, NSArray *args);

@implementation QuarrelsTests {
  NIQQuarrels *qSmall;
  NIQQuarrels *qBig;
}

- (void)setUp
{
  [super setUp];
  NSArray *args = @[@"progname", @"-a", @"yeehaw!", @"-x"];
  int argc = (int)args.count;
  const char **argvSmall = initArgv(argc, args);
  qSmall = [NIQQuarrels argsWithArgc:argc
                                argv:argvSmall];
  free(argvSmall);
  
  args = @[@"progname", @"-a", @"yeehaw!", @"-b", @"brewbird!", @"oliver twist", @"wolverine", @"--strike", @"out", @"-m"];
  argc = (int)args.count;
  const char **argvLarge = initArgv(argc, args);
  qBig = [NIQQuarrels argsWithArgc:argc
                              argv:argvLarge];
  free(argvLarge);
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testFlag
{
  [qSmall addOptionWithFlag:@"a"
                      alias:nil
                   required:YES
                     preset:nil
                explanation:nil
                    boolean:NO];

  STAssertEqualObjects(@"yeehaw!", qSmall[@"a"], nil);
}

- (void)testAlias
{
  [qBig addOptionWithFlag:@"s"
                    alias:@"strike"
                 required:YES
                   preset:nil
              explanation:nil
                  boolean:NO];

  STAssertEqualObjects(@"out", qBig[@"strike"], nil);
  STAssertEqualObjects(@"out", qBig[@"s"], nil);
}

- (void)testRequired
{
  [qSmall addOptionWithFlag:@"f"
                      alias:@"faen"
                   required:YES
                     preset:nil
                explanation:nil
                    boolean:NO];
   
  NSString *f = nil;
  STAssertThrows(f = qSmall[@"f"], nil);
}

- (void)testPreset
{
  [qSmall addOptionWithFlag:@"m"
                      alias:@"meow"
                   required:YES
                     preset:@"lions breath"
                explanation:nil
                    boolean:NO];
  STAssertEqualObjects(@"lions breath", qSmall[@"m"], nil);
  STAssertEqualObjects(@"lions breath", qSmall[@"meow"], nil);
}

- (void)testBoolean
{
  [qSmall addOptionWithFlag:@"x"
                      alias:nil
                   required:YES
                     preset:nil
                explanation:nil
                    boolean:YES];
  
  STAssertEquals(@YES, qSmall[@"x"], nil);
}

- (void)testHelp
{
//  [qSmall addOptionWithFlag:@"a"
//                      alias:nil
//                   required:YES
//                     preset:nil
//                explanation:@"adds a yeehaw!"
//                    boolean:NO];
//  STAssertEqualObjects(@"adds a yeehaw!", qSmall[@"a"], nil);
}

@end

const char ** initArgv (int argc, NSArray *args) {
  const char **argv = malloc(sizeof(const char *) * argc);
  for (int i = 0; i < argc; i++) {
    argv[i] = [args[i] UTF8String];
  }
  return argv;
}
