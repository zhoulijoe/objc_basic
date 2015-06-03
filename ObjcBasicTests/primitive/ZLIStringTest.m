#import <Kiwi/Kiwi.h>

@interface ZLIFormatStringTest : NSObject
@end

@implementation ZLIFormatStringTest

- (NSString *)description {
    return @"default description";
}

- (NSString *)descriptionWithLocale:(id)locale {
    if (locale == nil) {
        return [self description];
    } else if ([locale isEqual:[NSLocale currentLocale]]) {
        return @"current locale";
    } else {
        return @"not current locale";
    }
}

@end

SPEC_BEGIN(ZLIStringTest)

describe(@"string", ^{
    context(@"character", ^{
        it(@"creation", ^{
            char charVar = 'a';

            [[theValue(charVar) should] equal:theValue('a')];
        });
    });

    context(@"C string is character array", ^{
        it(@"creation", ^{
            char strVar[] = "hello";

            [[theValue(strlen(strVar)) should] equal:theValue(5)];
        });
    });

    context(@"Objective-C string object", ^{
        it(@"basic creation", ^{
            NSString *str = @"hello";

            [[str should] equal:@"hello"];
        });

        it(@"creation based on C string", ^{
            NSString *str = [NSString stringWithCString:"hello" encoding:NSUTF8StringEncoding];

            [[str should] equal:@"hello"];
        });

        it(@"creation based on format string", ^{
            NSString *str = [NSString stringWithFormat:@"hello %d %@", 1, @"people"];

            [[str should] equal:@"hello 1 people"];
        });

        it(@"%@ in format string is substituted with result of calling descriptionWithLocale: with nil if it exists, \
           or description method of the object", ^{
            ZLIFormatStringTest *formatStringTest = [ZLIFormatStringTest new];
            NSString *str = [NSString stringWithFormat:@"%@", formatStringTest];

            [[str should] equal:@"default description"];
        });

        it(@"creation of mutable string that could be modified", ^{
            NSMutableString *mutableStr = [NSMutableString stringWithString:@"hello"];
            [mutableStr appendString:@" world"];

            [[mutableStr should] equal:@"hello world"];
        });

        it(@"unicode based character length", ^{
            NSString *str = @"你好";
            [[theValue([str length]) should] equal:theValue(2)];
        });

        it(@"scan string using NSScanner", ^{
            NSString *str = @"4 by 5";
            NSScanner *scanner = [NSScanner scannerWithString:str];
            int row = 0;
            int col = 0;
            [scanner scanInt:&row];
            [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
            [scanner scanInt:&col];
            [[theValue(row) should] equal:theValue(4)];
            [[theValue(col) should] equal:theValue(5)];
        });

        it(@"parse int using regex", ^{
            NSString *str = @"4 by 5";
            int rowcol[2];
            int *intPtr = rowcol;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:0 error:nil];

            for(NSTextCheckingResult *match in [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])]) {
                *intPtr = [[str substringWithRange:[match range]] intValue];
                intPtr++;
            }
            [[theValue(rowcol[0]) should] equal:theValue(4)];
            [[theValue(rowcol[1]) should] equal:theValue(5)];
        });
    });
});

SPEC_END
