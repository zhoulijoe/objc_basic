#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLISetTest)

describe(@"set", ^{
    context(@"immutable", ^{
        it(@"creation from objects", ^{
            NSSet *set = [NSSet setWithObjects:@(1), @(2), @(3), nil];

            [[theValue([set count]) should] equal:theValue(3)];
        });
    });
});

SPEC_END
