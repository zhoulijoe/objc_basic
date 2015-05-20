#import <Kiwi/Kiwi.h>

@interface ZLIDelegateClass : NSObject

@property NSString *strProperty;

- (void)updateStr:(NSString *)str;

@end

@implementation ZLIDelegateClass

- (void)updateStr:(NSString *)str {
    self.strProperty = str;
}

@end

@interface ZLIDelegatingClass : NSObject

// The delegating object maintains a weak reference to its delegate, because it's not the owner of the delegate and
// should not keep it alive.
@property (weak) ZLIDelegateClass *delegate;

- (void)callDelegate;

@end

@implementation ZLIDelegatingClass

- (void)callDelegate {
    [self.delegate updateStr:@"hello"];
}

@end

SPEC_BEGIN(ZLIDelegateTest)

describe(@"delegate pattern", ^{
    it(@"The delegating object keeps a reference to the other object—the delegate—and at the appropriate time sends a \
       message to it. The message informs the delegate of an event that the delegating object is about to handle or has\
       just handled. The delegate may respond to the message by updating the appearance or state of itself or other\
       objects in the application, and in some cases it can return a value that affects how an impending event is\
       handled.", ^{
        ZLIDelegatingClass *delegatingClass = [ZLIDelegatingClass new];
        ZLIDelegateClass *delegateClass = [ZLIDelegateClass new];
        delegatingClass.delegate = delegateClass;

        [delegatingClass callDelegate];

        [[delegateClass.strProperty should] equal:@"hello"];
    });
});

SPEC_END
