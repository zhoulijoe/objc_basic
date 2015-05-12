#import <Kiwi/Kiwi.h>


SPEC_BEGIN(ZLIObjectTest)

describe(@"object", ^{
    context(@"initialization", ^{
        it(@"alloc and init", ^{
            NSObject *object = [[NSObject alloc] init];

            [[object should] beNonNil];
        });

        it(@"new method is the same as calling alloc and init", ^{
            NSObject *object = [NSObject new];

            [[object should] beNonNil];
        });
    });

    context(@"comparison", ^{
        it(@"for the exact same object", ^{
            NSNumber *num1 = @(1.1);
            NSNumber *num2 = num1;
            NSNumber *num3 = @(1.1);

            [[theValue(num1 == num2) should] beYes];
            [[theValue(num1 == num3) should] beNo];
        });

        it(@"for the same content", ^{
            NSNumber *num1 = @(1.1);
            NSNumber *num2 = @(1.1);

            [[theValue([num1 isEqual:num2]) should] beYes];
        });

        it(@"for ordering", ^{
            NSNumber *num1 = @(1);
            NSNumber *num2 = @(2);

            [[theValue([num1 compare:num2] == NSOrderedAscending) should] beYes];
        });
    });
});

SPEC_END
