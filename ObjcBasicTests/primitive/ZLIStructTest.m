#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIStructTest)

describe(@"struct", ^{
    it(@"NSRange", ^{
        NSRange nsrange = NSMakeRange(0, 2);
        NSUInteger loc = nsrange.location;
        NSUInteger len = nsrange.length;
        [[theValue(loc) should] equal:theValue(0)];
        [[theValue(len) should] equal:theValue(2)];

        NSRange *rangePtr = &nsrange;
        (*rangePtr).location = 1;
        [[theValue(nsrange.location) should] equal:theValue(1)];
    });
});

SPEC_END
