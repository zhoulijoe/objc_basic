#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIStringTest)

describe(@"string", ^{
    context(@"character", ^{
        it(@"creation", ^{
            char charVar = 'a';

            [[theValue(charVar) should] equal:theValue('a')];
        });
    });

    context(@"C string is character array", ^{
        it(@"creation", ^{
            char strVar[] = "hello";

            [[theValue(strlen(strVar)) should] equal:theValue(5)];
        });
    });

    context(@"Objective-C string object", ^{
        it(@"basic creation", ^{
            NSString *str = @"hello";

            [[str should] equal:@"hello"];
        });

        it(@"creation based on C string", ^{
            NSString *str = [NSString stringWithCString:"hello" encoding:NSUTF8StringEncoding];

            [[str should] equal:@"hello"];
        });

        it(@"creation based on format string", ^{
            NSString *str = [NSString stringWithFormat:@"hello %d %@", 1, @"people"];

            [[str should] equal:@"hello 1 people"];
        });

        it(@"creation of mutable string that could be modified", ^{
            NSMutableString *mutableStr = [NSMutableString stringWithString:@"hello"];
            [mutableStr appendString:@" world"];

            [[mutableStr should] equal:@"hello world"];
        });
    });
});

SPEC_END
