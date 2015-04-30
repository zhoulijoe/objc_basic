#import <Kiwi/Kiwi.h>

SPEC_BEGIN(Operator)

describe(@"Basic operator syntax", ^{
    context(@"math operator", ^{
        it(@"addition/subtraction", ^{
            [[theValue(1 + 1) should] equal:theValue(2)];
        });
    });
});

SPEC_END
