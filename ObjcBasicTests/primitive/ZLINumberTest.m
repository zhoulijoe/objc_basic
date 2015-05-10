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

describe(@"NSNumber object", ^{
    context(@"int wrapper", ^{
        it(@"signed int creation", ^{
            NSNumber *intVar = [NSNumber numberWithInt:1];

            [[intVar should] equal:@(1)];
        });

        it(@"unsigned int creation", ^{
            NSNumber *uint = [NSNumber numberWithUnsignedInt:1U];

            [[uint should] equal:@(1U)];
        });

        it(@"long creation", ^{
            NSNumber *longVar = [NSNumber numberWithLong:1L];

            [[longVar should] equal:@(1L)];
        });

        it(@"longlong creation", ^{
            NSNumber *longlongVar = [NSNumber numberWithLongLong:1LL];

            [[longlongVar should] equal:@(1LL)];
        });
    });

    context(@"float wrapper", ^{
        it(@"creation", ^{
            NSNumber *floatVar = [NSNumber numberWithFloat:1.1F];

            [[floatVar should] equal:@(1.1F)];
        });
    });

    context(@"boolean wrapper", ^{
        it(@"creation", ^{
            NSNumber *boolVar = [NSNumber numberWithBool:YES];

            [[boolVar should] equal:@(YES)];
        });
    });

    context(@"char wrapper", ^{
        it(@"creation", ^{
            NSNumber *charVar = [NSNumber numberWithChar:'a'];

            [[charVar should] equal:@('a')];
        });
    });
});

SPEC_END
