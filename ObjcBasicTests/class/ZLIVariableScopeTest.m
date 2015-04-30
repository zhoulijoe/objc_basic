#import <Kiwi/Kiwi.h>

@interface ZLIVariableScopeTestClass : NSObject

- (NSObject *)declareStaticLocalVariable;

@end

@implementation ZLIVariableScopeTestClass

- (NSObject *)declareStaticLocalVariable {
    static NSObject *staticLocal = nil;

    if (staticLocal == nil) {
        staticLocal = [NSObject new];
    }

    return staticLocal;
}

@end

SPEC_BEGIN(VariableScope)

describe(@"Syntax for controlling variable scope", ^{
    context(@"static local variable", ^{
        it(@"only gets initialized once, doesn't change the scope, \
             all class instance can access the same variable instance via the same method", ^{
            NSObject *obj1 = [[ZLIVariableScopeTestClass new] declareStaticLocalVariable];
            NSObject *obj2 = [[ZLIVariableScopeTestClass new] declareStaticLocalVariable];

            [[obj1 should] equal:obj2];
        });
    });
});

SPEC_END
