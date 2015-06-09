#import <Kiwi/Kiwi.h>

SPEC_BEGIN(Operator)

describe(@"Basic operator syntax", ^{
    context(@"assignment", ^{
        it(@"single increment assignment using ++", ^{
            NSInteger count = 0;
            count++;
            ++count;

            [[theValue(count) should] equal:theValue(2)];
        });

        it(@"prefix using ++ increment then evaluate variable", ^{
            NSInteger count = 0;
            NSInteger value = ++count;

            [[theValue(value) should] equal:theValue(1)];
        });

        it(@"suffix using ++ evaluate then increment variable", ^{
            NSInteger count = 0;
            NSInteger value = count++;

            [[theValue(value) should] equal:theValue(0)];
        });
    });

    context(@"math operator", ^{
        it(@"addition/subtraction", ^{
            [[theValue(1 + 1) should] equal:theValue(2)];
        });
    });
});

SPEC_END
