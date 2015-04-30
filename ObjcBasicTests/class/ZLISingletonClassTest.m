#import <Kiwi/Kiwi.h>

/**
 * Thread safe design for singleton class
 */
@interface ZLISingletonClass : NSObject

+ (instancetype)sharedInstance;

@end

@implementation ZLISingletonClass

+ (instancetype)sharedInstance {
    static ZLISingletonClass *sharedZLISingletonClass = nil;
    static dispatch_once_t onceToken;

    // Use GCD to guarantee initialization only happens once among multiple threads
    dispatch_once(&onceToken, ^{
        sharedZLISingletonClass = [self new];
    });

    return sharedZLISingletonClass;
}

@end

SPEC_BEGIN(singletonClass)

describe(@"Singleton class", ^{
    it(@"should share the same instance", ^{
        ZLISingletonClass *instance1 = [ZLISingletonClass sharedInstance];
        ZLISingletonClass *instance2 = [ZLISingletonClass sharedInstance];

        [[instance1 should] equal:instance2];
    });
});

SPEC_END
