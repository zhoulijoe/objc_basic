// #import preprocessor directive ensures specified file is only included once during compilation
#import <Kiwi/Kiwi.h>

// Interface usually goes in .h file
@interface ZLIClassTestBasic : NSObject

// A public property
@property NSString *strProperty;

// Readonly property
@property (readonly) NSString *readonlyStr;

// Change default getter name
@property (getter=isBooleanProperty) BOOL booleanProperty;

// Multple attributes are separated by comma
@property (strong, nonatomic, readonly) NSString *multiAttrProperty;

@end

// Implementation usually goes in .m file
@implementation ZLIClassTestBasic

@end

SPEC_BEGIN(ZLIClassTest)

describe(@"class", ^{
    it(@"name should start with at least 3-letter prefix, both interface and implementation are required for a class\
       definition, and interface must inherit from NSObject", ^{
        ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

        [[classTestBasic should] beNonNil];
    });

    context(@"property", ^{
        it(@"is readable and writable by default", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.strProperty should] beNil];

            classTestBasic.strProperty = @"hello";

            [[classTestBasic.strProperty should] equal:@"hello"];
        });

        it(@"can be readonly", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.readonlyStr should] beNil];

            // Trying to assign value to readonly property would result in compile error
            // classTestBasic.readonlyStr = @"hello";
        });

        it(@"can have custom getter name", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            classTestBasic.booleanProperty = YES;

            [[theValue(classTestBasic.isBooleanProperty) should] beYes];
        });
    });
});

SPEC_END
