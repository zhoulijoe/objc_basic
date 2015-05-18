#import <Kiwi/Kiwi.h>

// Interface is in .h file
@interface NSString (ZLIAddon)

// Class method
+ (BOOL)isEmpty:(NSString *)str;

// Instance method
- (NSString *)firstChar;

@end

// Implementation is in .m file
@implementation NSString (ZLIAddon)

+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return YES;
    }

    NSString *trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedStr isEqualToString:@""]) {
        return YES;
    }

    return NO;
}

- (NSString *)firstChar {
    return [self substringToIndex:1];
}

@end

SPEC_BEGIN(ZLICategoryTest)

describe(@"category", ^{
    context(@"is used to add custom behavior to existing class", ^{
        it(@"add class method", ^{
            BOOL isEmpty = [NSString isEmpty:@""];

            [[theValue(isEmpty) should] beYes];

            isEmpty = [NSString isEmpty:@"a"];

            [[theValue(isEmpty) should] beNo];
        });

        it(@"add instance method", ^{
            NSString *str = @"abc";
            NSString *firstChar = [str firstChar];

            [[firstChar should] equal:@"a"];
        });
    });
});

SPEC_END
