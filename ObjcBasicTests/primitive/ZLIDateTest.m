#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIDateTest)

describe(@"date", ^{
    context(@"creation", ^{
        it(@"current time", ^{
            NSDate *currentTime = [NSDate new];

            [[currentTime should] beNonNil];
        });
    });
});

SPEC_END
