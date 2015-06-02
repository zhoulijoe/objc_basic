#import <XCTest/XCTest.h>

@interface ZLISampleXCTestClass : NSObject

- (NSString *)saySomething:(NSString *)something;

@end

@implementation ZLISampleXCTestClass

- (NSString *)saySomething:(NSString *)something {
    return something;
}

@end

@interface ZLISampleXCTest : XCTestCase

@property ZLISampleXCTestClass *testClass;

@end

@implementation ZLISampleXCTest

+ (void)setUp {
    NSLog(@"Test class setup: %@", NSStringFromSelector(_cmd));
}

+ (void)tearDown {
    NSLog(@"Test class tearDown: %@", NSStringFromSelector(_cmd));
}

- (void)setUp {
    NSLog(@"%@ per test setup", NSStringFromSelector(_cmd));
    [super setUp];

    self.testClass = [ZLISampleXCTestClass new];
}

- (void)tearDown {
    NSLog(@"%@ per test tearDown", NSStringFromSelector(_cmd));
    [super tearDown];
}

/**
 * Dummy test for method that returns a string
 */
- (void)testGreeting {
    NSString *input = @"hello";
    NSString *expectedOutput = @"hello";
    NSString *output = [self.testClass saySomething:input];
    XCTAssertEqualObjects(output, expectedOutput, @"ZLISuperClass saySomething with input %@ "
                          @"outputs %@ instead of %@", input, output, expectedOutput);
}

@end
