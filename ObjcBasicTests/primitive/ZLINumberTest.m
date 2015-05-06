#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLINumberTest)

describe(@"integer", ^{
    context(@"creation", ^{
        it(@"is simple", ^{
            int int1 = 1;

            [[theValue(int1) should] equal:theValue(1)];
        });
    });
});

SPEC_END
