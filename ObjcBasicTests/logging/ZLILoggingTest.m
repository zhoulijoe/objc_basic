#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLILoggingTest)

describe(@"logging", ^{
    context(@"to console using NSLog", ^{
        it(@"log with format string", ^{
            NSLog(@"hello %@", @"world");

            [[theValue(YES) should] beYes];
        });
    });
});

SPEC_END
