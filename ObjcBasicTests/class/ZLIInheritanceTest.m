#import <Kiwi/Kiwi.h>

@interface ZLIInheritanceSuperClass : NSObject

- (NSString *)overrideMethod;

@end

@implementation ZLIInheritanceSuperClass

- (NSString *)overrideMethod {
    return @"super class";
}

@end

@interface ZLIInheritanceSuperClass (ZLICategoryTest)

- (NSString *)superCategoryMethod;

@end

@implementation ZLIInheritanceSuperClass (ZLICategoryTest)

- (NSString *)superCategoryMethod {
    return @"superCategoryMethod";
}

@end

@interface ZLIInheritanceSubClass : ZLIInheritanceSuperClass

@end

@implementation ZLIInheritanceSubClass

- (NSString *)overrideMethod {
    return @"sub class";
}

@end

SPEC_BEGIN(ZLIInheritanceTest)

describe(@"class inheritance", ^{
    context(@"method in super class", ^{
        it(@"can be overriden", ^{
            ZLIInheritanceSubClass *subClass = [ZLIInheritanceSubClass new];
            NSString *result = [subClass overrideMethod];

            [[result should] equal:@"sub class"];
        });
    });

    context(@"category", ^{
        it(@"calling category method for grandparent", ^{
            ZLIInheritanceSubClass *subClass = [ZLIInheritanceSubClass new];
            NSString *result = [subClass superCategoryMethod];
            [[result should] equal:@"superCategoryMethod"];
        });
    });
});

SPEC_END
