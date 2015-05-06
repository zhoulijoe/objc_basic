#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIVariableTest)

describe(@"variable", ^{
    context(@"bascis", ^{
        it(@"creation", ^{
            int var1 = 1;

            [[theValue(var1) should] equal:theValue(1)];
        });
    });

    context(@"pointer", ^{
        it(@"points to address of a variable", ^{
            int var1 = 1;
            int *ptr1 = &var1;
            int var2 = *ptr1;

            [[theValue(var2) should] equal:theValue(var1)];
        });
    });
});

SPEC_END
