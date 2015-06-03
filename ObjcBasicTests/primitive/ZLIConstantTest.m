#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIConstantTest)

describe(@"constant", ^{
    it(@"NSNotFound", ^{
        NSString *str = @"hello world";
        NSRange range = [str rangeOfString:@"not found"];
        [[theValue(range.location) should] equal:theValue(NSNotFound)];

        NSArray *array = @[@1, @2];
        NSUInteger idx = [array indexOfObject:@3];
        [[theValue(idx) should] equal:theValue(NSNotFound)];
    });

    it(@"kNilOptions is the constant for no option", ^{
        [[theValue(kNilOptions) should] equal:theValue(0)];
    });
});

SPEC_END
