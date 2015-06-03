#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIDictionaryTest)

describe(@"dictionary", ^{
    context(@"immutable", ^{
        it(@"creation from objects", ^{
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"key1", @"value1",
                                  @"key2", @"value2",
                                  nil];

            [[theValue([dict count]) should] equal:theValue(2)];
        });

        it(@"creation from compact literal syntax", ^{
            NSDictionary *dict = @{
                @"key1": @"value1",
                @"key2": @"value2"
            };

            [[theValue([dict count]) should] equal:theValue(2)];
        });
    });

    context(@"basic operation", ^{
        it(@"get object for key", ^{
            NSDictionary *dict = @{
                @"key1": @"value1",
                @"key2": @"value2"
            };
            NSString *value = dict[@"key1"];

            [[value should] equal:@"value1"];
        });

        it(@"null object in dictionary", ^{
            NSDictionary *dict = @{
                @"key1": [NSNull null]
            };

            [[theValue(dict[@"key1"] == [NSNull null]) should] beYes];
        });

        it(@"loop through", ^{
            NSDictionary *map = @{
                                  @"first" : @"firstValue",
                                  @"second" : @"secondValue"
                                  };

            for (NSString *eachKey in map) {
                [[map[eachKey] should] equal:[map valueForKey:eachKey]];
            }
        });

        it(@"block iterator", ^{
            NSDictionary *dict = @{@"first" : @"firstValue",
                                   @"second" : @"secondValue"};
            [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                [[key should] equal:@"first"];
                [[obj should] equal:@"firstValue"];
                
                *stop=YES;
            }];
        });
    });

    context(@"mutable", ^{
        it(@"add/update key-value pair", ^{
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{
                @"key1": @"value1"
            }];
            [dict setValue:@"value2" forKey:@"key2"];

            [[dict[@"key2"] should] equal:@"value2"];
        });

        it(@"remove key", ^{
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{
                @"key1": @"value1",
                @"key2": @"value2"
            }];
            [dict removeObjectForKey:@"key1"];

            [[theValue([dict count]) should] equal:theValue(1)];
        });
    });
});

SPEC_END
