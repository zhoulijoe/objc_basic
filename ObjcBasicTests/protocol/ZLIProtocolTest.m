#import <Kiwi/Kiwi.h>

// Protocol is defined in .h file
@protocol ZLIProtocolTestProtocol

+ (NSString *)requiredClassMethod;

- (NSString *)requiredMethod;

// Optinal methods don't have to be implemented by class conforming to protocol
@optional

- (NSString *)optionalMethod;

@end

// Protocol conformation is declared as part of interface definition
@interface ZLIProtocolTestClass : NSObject <ZLIProtocolTestProtocol>

@end

@implementation ZLIProtocolTestClass

+ (NSString *)requiredClassMethod {
    return @"requiredClassMethod";
}

- (NSString *)requiredMethod {
    return @"requiredMethod";
}

@end

SPEC_BEGIN(ZLIProtocolTest)

describe(@"protocol", ^{
    context(@"defines methods that a class conforms to it needs to implement", ^{
        it(@"method defined is required by default", ^{
            id<ZLIProtocolTestProtocol> protocolClass = [ZLIProtocolTestClass new];
            NSString *result = [protocolClass requiredMethod];

            [[result should] equal:@"requiredMethod"];
        });

        it(@"class method can also be declared in protocol", ^{
            NSString *result = [ZLIProtocolTestClass requiredClassMethod];

            [[result should] equal:@"requiredClassMethod"];
        });
    });
});

SPEC_END
