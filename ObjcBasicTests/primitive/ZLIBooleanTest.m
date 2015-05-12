#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIBooleanTest)

describe(@"boolean", ^{
    context(@"objective-C boolean", ^{
        it(@"creation", ^{
            BOOL boolVar = @(YES);

            [[theValue(boolVar) should] beYes];
        });
    });
});

SPEC_END
