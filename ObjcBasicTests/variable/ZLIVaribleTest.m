#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIVariableTest)

describe(@"variable", ^{
    context(@"bascis", ^{
        it(@"creation", ^{
            int intVar = 1;

            [[theValue(intVar) should] equal:theValue(1)];
        });

        it(@"generic object variable can point to any object", ^{
            id genericVar = [NSObject new];

            [[genericVar should] beNonNil];

            genericVar = @"hello";

            [[genericVar should] beNonNil];
        });
    });

    context(@"pointer", ^{
        it(@"points to address of a variable", ^{
            int intVar1 = 1;
            int *intPtr1 = &intVar1;
            int intVar2 = *intPtr1;

            [[theValue(intVar2) should] equal:theValue(intVar1)];
        });
    });
});

SPEC_END
