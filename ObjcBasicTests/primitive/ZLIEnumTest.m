#import <Kiwi/Kiwi.h>

// Starts from 0
typedef NS_ENUM(NSInteger, ZLIDefaultEnum) {
    ZLIDefaultEnum1,
    ZLIDefaultEnum2
};

typedef NS_ENUM(NSInteger, ZLICustomEnum) {
    ZLICustomEnum1 = 10,
    ZLICustomEnum2 = 20
};

SPEC_BEGIN(ZLIEnumTest)

describe(@"enum", ^{
    it(@"default numbering", ^{
        ZLIDefaultEnum defaultEnum = ZLIDefaultEnum1;
        [[theValue(defaultEnum) should] equal:theValue(0)];
    });

    it(@"custom numbering", ^{
        ZLICustomEnum customEnum = ZLICustomEnum1;
        [[theValue(customEnum) should] equal:theValue(10)];
    });
});

SPEC_END
