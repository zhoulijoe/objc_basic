#import <Kiwi/Kiwi.h>

SPEC_BEGIN(Concurrency)

describe(@"Concurrency test", ^{
    context(@"operation queue", ^{
        it(@"schedule a task", ^{
            __block int count = 0;

            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                count++;
            }];
            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
            [mainQueue addOperation:operation];

            [[expectFutureValue(theValue(count)) shouldEventually] equal:theValue(1)];
        });
    });

    context(@"dispatch queue", ^{
        it(@"dispatch a task", ^{
            __block int count = 0;

            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_sync(queue, ^{
                count++;
            });

            [[expectFutureValue(theValue(count)) shouldEventually] equal:theValue(1)];
        });
    });
});

SPEC_END
