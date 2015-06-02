#import <Kiwi/Kiwi.h>

// Forward class declaration for circular class dependency
@class ZLIVariableReferenceTestSecondClass;

@interface ZLIVariableReferenceTestClass : NSObject

// Strong property
@property NSString *strongProperty;

// Weak property, used when reference is not intended to keep the object alive
@property (weak) ZLIVariableReferenceTestSecondClass *weakReference;

@end

@implementation ZLIVariableReferenceTestClass

- (instancetype)init {
    self = [super init];

    if (self) {
        _strongProperty = @"hello";
    }

    return self;
}

@end

@interface ZLIVariableReferenceTestSecondClass : NSObject

@property ZLIVariableReferenceTestClass *strongReference;

@end

@implementation ZLIVariableReferenceTestSecondClass

- (instancetype)init {
    self = [super init];

    if (self) {
        _strongReference = [ZLIVariableReferenceTestClass new];
        _strongReference.weakReference = self;
    }

    return self;
}

@end

SPEC_BEGIN(ZLIVariableReferenceTest)

describe(@"memory management for variable", ^{
    context(@"strong reference; an object is kept alive as long as it has at least one strong reference to it from\
            another object", ^{
        it(@"class holds strong reference to its properties by default, which means properties will be kept alive as\
           long as the class instance is alive", ^{
            ZLIVariableReferenceTestClass *testClass = [ZLIVariableReferenceTestClass new];

            [[testClass.strongProperty should] beNonNil];
        });

        it(@"local variable holds strong reference to object", ^{
            NSString *str = @"hello";

            [[str should] beNonNil];
        });
    });

    context(@"weak reference; A weak reference does not imply ownership or responsibility between two objects,\
            and does not keep an object alive", ^{
        it(@"weak property doesn't keep the reference alive, it's usuallly to avoid strong reference cycle between\
           two objects, which results in memory leak", ^{
            ZLIVariableReferenceTestSecondClass *secondTestClass = [ZLIVariableReferenceTestSecondClass new];

            [[secondTestClass.strongReference should] beNonNil];
        });

        it(@"local variable can be declared to hold weak reference", ^{
            __weak NSString *weakStr = @"hello";

            if (weakStr) {
                // Check if weak pointer reference still exists
            }

            // weakStr could already be nil at this point since it doesn't maintain memory for object
            [[theValue(YES) should] beYes];
        });

        it(@"local variable can be used to maintain memory of weak property for the duration of a method", ^{
            ZLIVariableReferenceTestSecondClass *testClass = [ZLIVariableReferenceTestSecondClass new];

            // Object will be kept alive from this point
            ZLIVariableReferenceTestSecondClass *strongReference = testClass.strongReference.weakReference;

            if (strongReference) {
                [[strongReference should] beNonNil];
            }

            // Until here
            strongReference = nil;
            [[theValue(YES) should] beYes];
        });
    });
});

SPEC_END
