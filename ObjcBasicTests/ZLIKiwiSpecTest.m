#import <Kiwi/Kiwi.h>

SPEC_BEGIN(KiwiSpecTest)

describe(@"Math", ^{
    beforeAll(^{
        NSLog(@"Before all tests");
    });

    beforeEach(^{
        NSLog(@"Before each test");
    });

    afterEach(^{
        NSLog(@"After each test");
    });

    afterAll(^{
        NSLog(@"After all tests");
    });

    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        [[theValue(a + b) should] equal:theValue(42)];
    });
});

SPEC_END
