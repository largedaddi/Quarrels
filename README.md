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

## Flags & Alias

Values will be retrievable with both the flag and the alias.

````objective-c
[quarrels addOptionWithFlag:@"g"
                      alias:@"greeting"
                   required:YES
                     preset:nil
                explanation:nil
                    boolean:NO];

NSLog(@"g: %@", quarrels[@"g"]);
NSLog(@"greeting: %@", quarrels[@"greeting"]);
````

````
$ ./example -g huzzah
g: huzzah
greeting: huzzah


$ ./example --greeting huzzah
g: huzzah
greeting: huzzah
````

## Required

Forces the existence of the specified option.

````objective-c
[quarrels addOptionWithFlag:@"a"
                      alias:nil
                   required:YES
                     preset:nil
                explanation:nil
                    boolean:NO];
````

````
$ ./example -s sanguine
Failed: -m is required.
````

## Preset

If the option is given no value, it will default to the value of `preset`.

````objective-c
[quarrels addOptionWithFlag:@"p"
                      alias:nil
                   required:NO
                     preset:@""
                explanation:@"9001"
                    boolean:NO];

NSLog(@"-p: %@");
````

````
$ ./example
-p: 9001
````

## Explanation

Describes the option's purpose. Used in help message.

````objective-c
[quarrels addOptionWithFlag:@"c"
                      alias:@"cookies"
                   required:YES
                     preset:nil
                explanation:@"type of cookies to be used"
                    boolean:NO];

[quarrels provideHelp];
````

````
./example
Usage: ./example -c monster

Options:

  -c, cookies type of cookies to be used [required]
````

## Boolean

`BOOL` literals are used for the option's corresponding value.  If an associated value exists `@YES` is returned.  If it doesn't exist, `@NO` is returned.

````objective-c
[quarrels addOptionWithFlag:@"s"
                      alias:@"switch"
                   required:NO
                     preset:nil
                explanation:nil
                    boolean:YES];

if (quarrels[@"switch"]) {
  NSLog(@"you've been switched.");
}
````

````
$ ./example -s
you've been switched
````

## License

MIT

Copyright (c) 2012 Near Infinity

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

***

Inspired by [optimist](https://github.com/substack/node-optimist)