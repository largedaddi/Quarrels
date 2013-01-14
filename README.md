# Quarrels

Objective-C command line option parser.

````objective-c

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    NIQuarrels *quarrels = [NIQuarrels argsWithArgc:argc argv:argv];

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

    NSString *addString = quarrels[@"add"];

    NSString *badString = quarrels[@"bad"];
    if (badString) {  
      // Do bad things.
    }
  }
  return 0;
}

````

## Flags

## Alias

## Required

## Preset

## Boolean

## Help

## Examples

## License



***

Inspired by [optimist](https://github.com/substack/node-optimist)