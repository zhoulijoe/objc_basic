#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIArrayTest)

describe(@"array", ^{
    context(@"immutable", ^{
        it(@"creation from an object", ^{
            NSNumber *num = @(1);
            NSArray *array = [NSArray arrayWithObject:num];

            [[theValue([array count]) should] equal:theValue(1)];
        });

        it(@"creation from objects", ^{
            NSArray *array = [NSArray arrayWithObjects:@(1), @(2), @(3), nil];

            [[theValue([array count]) should] equal:theValue(3)];
        });

        it(@"creation from compact literal syntax", ^{
            NSArray *array = @[@(1), @(2), @(3)];

            [[theValue([array count]) should] equal:theValue(3)];
        });
    });

    context(@"basic operation", ^{
        it(@"get length", ^{
            NSArray *array = @[@(1), @(2)];
            NSUInteger length = [array count];

            [[theValue(length) should] equal:theValue(2)];
        });

        it(@"get object based on index", ^{
            NSArray *array = @[@(1), @(2), @(3)];
            NSNumber *num = array[1];

            [[num should] equal:@(2)];
        });

        it(@"check for existence", ^{
            NSArray *array = @[@(1), @(2), @(3)];
            BOOL contains = [array containsObject:@(2)];
            BOOL notContain = [array containsObject:@(4)];

            [[theValue(contains) should] beYes];
            [[theValue(notContain) should] beNo];
        });
    });

    context(@"mutable array", ^{
        it(@"append an object to array", ^{
            NSMutableArray *array = [NSMutableArray arrayWithArray:@[@(1), @(2)]];
            [array addObject:@(3)];

            [[theValue([array count]) should] equal:theValue(3)];
        });

        it(@"replace an object in array", ^{
            NSMutableArray *array = [NSMutableArray arrayWithArray:@[@(1), @(2), @(3)]];
            [array replaceObjectAtIndex:0 withObject:@(4)];

            [[array[0] should] equal:@(4)];
        });

        it(@"sort a number array using comparison method", ^{
            NSMutableArray *numArray = [NSMutableArray arrayWithArray:@[@(2), @(1), @(3)]];
            NSArray *sortedArray = [numArray sortedArrayUsingSelector:@selector(compare:)];

            [[sortedArray[0] should] equal:@(1)];
        });

        it(@"case insensitive sort a string array", ^{
            NSMutableArray *strArray = [NSMutableArray arrayWithArray:@[@"b", @"A", @"c"]];
            NSArray *sortedArray = [strArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

            [[sortedArray[0] should] equal:@"A"];
        });
    });
});

SPEC_END
