#import <Kiwi/Kiwi.h>

SPEC_BEGIN(ZLIDateTest)

describe(@"date", ^{
    context(@"creation", ^{
        it(@"current time", ^{
            NSDate *currentTime = [NSDate new];

            [[currentTime should] beNonNil];
        });
    });

    it(@"specify a date", ^{
        // current time
        NSDate *now = [NSDate date];
        NSLog(@"Current time is:%@", [now descriptionWithLocale:[NSLocale currentLocale]]);

        // specific date
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [NSDateComponents new];
        comp.year = 2014;
        comp.month = 6;
        comp.day = 1;
        comp.hour = 19;
        NSDate *aDate = [cal dateFromComponents:comp];
        [[theValue([aDate timeIntervalSinceReferenceDate]) should] equal:theValue(423367200.0)];
    });

    it(@"adding time to a date", ^{
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

        NSDateComponents *comp = [NSDateComponents new];
        comp.year = 2014;
        comp.month = 6;
        comp.day = 1;
        NSDate *aDate = [cal dateFromComponents:comp];

        NSDateComponents *addComp = [NSDateComponents new];
        addComp.day = 1;

        NSDate *oneDayLater = [cal dateByAddingComponents:addComp toDate:aDate options:0];
        NSDateFormatter *df = [NSDateFormatter new];
        NSString* format =
        [NSDateFormatter dateFormatFromTemplate:@"d"
                                        options:0
                                         locale:[NSLocale currentLocale]];
        [df setDateFormat:format];
        NSString *day = [df stringFromDate:oneDayLater];
        [[day should] equal:@"2"];
    });
});

SPEC_END
