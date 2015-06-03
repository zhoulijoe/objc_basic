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

        it(@"element referenced in an immutable could still be modified", ^{
            NSMutableString *mutableString = [NSMutableString stringWithString:@"Mutable string"];
            NSArray *immutableArray = @[mutableString];

            if ([immutableArray count] > 0) {
                id item = immutableArray[0];
                if ([item isKindOfClass:[NSMutableString class]]) {
                    [item appendString:@" more stuff"];
                }
            }
            [[immutableArray should] equal:@[@"Mutable string more stuff"]];
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

        it(@"can contain null, which is a shared singleton", ^{
            NSArray *arrayWithNull = @[@"firstItem", [NSNull null]];

            BOOL containsNull = NO;
            for (id item in arrayWithNull) {
                if (item == [NSNull null]) {
                    containsNull = YES;
                }
            }
            [[theValue(containsNull) should] beYes];
        });

        it(@"different ways to loop through", ^{
            NSArray *array = @[@"a", @"b", @"c"];

            for (int i = 0; i < [array count]; i++) {
                [[array[i] should] equal:array[i]];
            }

            NSUInteger i = 0;
            for (id item in array) {
                [[item should] equal:array[i]];
                i++;
            }

            i = [array count];
            for (id item in [array reverseObjectEnumerator]) {
                i--;
                [[item should] equal:array[i]];
            }

            id tmpItem;
            NSEnumerator *enumerator = [array objectEnumerator];
            while (tmpItem = [enumerator nextObject]) {
                [[tmpItem should] equal:array[i]];
                i++;
            }
        });

        it(@"block iterator", ^{
            NSMutableArray *intArray = [NSMutableArray array];
            for (int count = 0; count < 10; count++) {
                [intArray addObject:[NSNumber numberWithInt:count]];
            }
            [intArray enumerateObjectsWithOptions:kNilOptions usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                intArray[idx] = @([((NSNumber *)obj) intValue] + 1);
                if (idx == 5) {
                    *stop = YES;
                }
            }];
            [[expectFutureValue(intArray) shouldEventually] equal:@[@1, @2, @3, @4, @5, @6, @6, @7, @8, @9]];
        });

        it(@"writing and loading from file", ^{
            NSFileManager *fm = [NSFileManager new];
            NSURL *dir = [fm URLsForDirectory:NSCachesDirectory inDomains:NSLocalDomainMask][0];
            NSURL *fileURL = [dir URLByAppendingPathComponent:@"arrayfile"];
            NSLog(@"The fileURL is %@", fileURL);

            NSArray *arrayToWrite = @[@"a", @"b", @"c"];
            BOOL success = [arrayToWrite writeToURL:fileURL atomically:YES];
            [[theValue(success) should] beYes];

            NSArray *loadedArray = [NSArray arrayWithContentsOfURL:fileURL];
            [[loadedArray should] equal:arrayToWrite];

            [[[NSFileManager alloc] init] removeItemAtURL:fileURL error:nil];
        });

        it(@"comparison", ^{
            NSArray *array1 = @[@"a", @"b", @"c"];
            NSArray *array2 = @[@"a", @"b", @"c"];

            [[theValue([array1 isEqual:array2]) should] beYes];
            [[theValue([array1 isEqualToArray:array2]) should] beYes];
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
