#import <Kiwi/Kiwi.h>

@interface ZLIInheritanceSuperClass : NSObject

- (NSString *)overrideMethod;

@end

@implementation ZLIInheritanceSuperClass

- (NSString *)overrideMethod {
    return @"super class";
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
});

SPEC_END
