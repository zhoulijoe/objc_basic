// #import preprocessor directive ensures specified file is only included once during compilation
#import <Kiwi/Kiwi.h>

// Interface usually goes in .h file
@interface ZLIClassTestBasic : NSObject

/*
 * A public property, an instance variable with a '_' prefix as the name will be synthesized by compiler by default.
 * The default attributes are: strong, atomic, readwrite.
 */
@property NSString *strProperty;

// Readonly property
@property (readonly) NSString *readonlyStr;

// Change default getter name
@property (getter=isBooleanProperty) BOOL booleanProperty;

// Multple attributes are separated by comma
@property (strong, nonatomic, readonly) NSString *multiAttrProperty;

// Property with custom getter and setter, needs to be nonatomic, needs to explicitly synthesize instance variable in this case
@property (nonatomic) NSString *customAccessorProperty;

// Readonly property without instance variable
@property (readonly) NSString *noIvarProperty;

// Property with initial value
@property NSString *propertyWithInitialValue;

// Lazily initialized property
@property (nonatomic) NSString *lazyProperty;

// Property that keeps a copy of the object instead pointing to same reference, object class must conform to NSCopying protocol
@property (copy) NSMutableArray *propertyCopy;

// Counters for test purpose
@property NSUInteger getterCalled;
@property NSUInteger setterCalled;

/**
 * Method available on the class
 *
 * @param paramOne First parameter
 * @param paramTwo Second parameter
 *
 * @return Combined string value
 */
+ (NSString *)classMethodwithParamOne:(NSString *)paramOne paramTwo:(NSString *)paramTwo;

/**
 * Method available on an instance of the class which has no return value
 */
- (void)instanceMethod;

/**
 * An instance method that returns a string
 *
 * @return String value
 */
- (NSString *)instanceMethodReturnsStr;

/**
 * An instance method that returns a number
 *
 * @return Numeric value
 */
- (NSInteger)instanceMethodReturnsNum;

/**
 * An instance method that returns a boolean
 *
 * @return Boolean value
 */
- (BOOL)instanceMethodReturnsBool;

@end

// Implementation and class extension usually goes in .m file

// Syntax for class extension that can be used to add private properties
@interface ZLIClassTestBasic ()

// Dispatch queue for thread safe lazy-loading getter
@property dispatch_queue_t syncQueue;

@end

@implementation ZLIClassTestBasic

- (instancetype)init {
    // Use 'super' to invoke method from superclass
    self = [super init];

    if (self) {
        // Use instance variable in initializer
        _syncQueue = dispatch_queue_create("ZLIClassTestBasicSyncQueue", 0);
        _propertyWithInitialValue = @"hello";
    }

    return self;
}

/**
 * When setting property with copy attribute in initializer, make sure to make a copy of the original object when
 * setting the property.
 *
 * @param propertyCopy Initial value for copy property
 *
 * @return New instance of the class
 */
- (instancetype)initWithPropertyCopy:(NSMutableArray *)anArray {
    self = [super init];

    if (self) {
        _propertyCopy = [anArray copy];
    }

    return self;
}

+ (NSString *)classMethodwithParamOne:(NSString *)paramOne paramTwo:(NSString *)paramTwo {
    return [NSString stringWithFormat:@"%@ %@", paramOne, paramTwo];
}

- (void)instanceMethod {
    // self pointer is a way to refer to “the object that’s received this message.”
    self.strProperty = @"hello world";
}

- (NSString *)instanceMethodReturnsStr {
    return @"hello";
}

- (NSInteger)instanceMethodReturnsNum {
    return 1;
}

- (BOOL)instanceMethodReturnsBool {
    return YES;
}

/**
 * Private method is only defined in implementation file
 */
- (void)privateMethod {
    self.strProperty = @"private hello";
}

/*
 * Compiler only synthesize instance variable when as least one accessor is being synthesized, you'll need to
 * specifically request an instance variable to be synthesized if getter(for readonly) or getter + setter have been
 * overriden.
 */
@synthesize customAccessorProperty = _customAccessorProperty;

/**
 * Custom getter for customAccessorProperty
 *
 * @return current value of property
 */
- (NSString *)customAccessorProperty {
    self.getterCalled ++;

    return _customAccessorProperty;
}

/**
 * Custom setter for customAccessorProperty
 *
 * @param customAccessorProperty New value to set the property to
 */
- (void)setCustomAccessorProperty:(NSString *)customAccessorProperty {
    self.setterCalled ++;

    _customAccessorProperty = customAccessorProperty;
}

/**
 * Overridding getter for readonly property prevents instance variable from being created
 *
 * @return Property value
 */
- (NSString *)noIvarProperty {
    return @"hello";
}

/**
 * Thread safe getter for lazy-loading property
 *
 * @return Property value
 */
- (NSString *)lazyProperty {
    dispatch_sync(self.syncQueue, ^{
        if (!_lazyProperty) {
            _lazyProperty = @"hello";
        }
    });

    return _lazyProperty;
}

@end

SPEC_BEGIN(ZLIClassTest)

describe(@"class", ^{
    it(@"name should start with at least 3-letter prefix, both interface and implementation are required for a class\
       definition, and interface must inherit from NSObject", ^{
        ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

        [[classTestBasic should] beNonNil];
    });

    context(@"initializer", ^{
        it(@"for copy property needs to set copy property to a copy of the passed in param", ^{
            NSMutableArray *anArray = [NSMutableArray arrayWithObjects:@1, nil];
            ZLIClassTestBasic *classTestBasic = [[ZLIClassTestBasic alloc] initWithPropertyCopy:anArray];

            [[theValue(anArray == classTestBasic.propertyCopy) should] beNo];
            [[classTestBasic.propertyCopy should] equal:anArray];
        });
    });

    context(@"property", ^{
        it(@"is readable and writable by default", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.strProperty should] beNil];

            classTestBasic.strProperty = @"hello";

            [[classTestBasic.strProperty should] equal:@"hello"];
        });

        it(@"can be readonly", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.readonlyStr should] beNil];

            // Trying to assign value to readonly property would result in compile error
            // classTestBasic.readonlyStr = @"hello";
        });

        it(@"can have custom getter name", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            classTestBasic.booleanProperty = YES;

            [[theValue(classTestBasic.isBooleanProperty) should] beYes];
        });

        it(@"getter and setter for @property are synthesized automatically by compiler", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];
            [classTestBasic setStrProperty:@"hello"];

            [[[classTestBasic strProperty] should] equal:@"hello"];
        });

        it(@"dot notation is shorthand for calling getter and setter", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];
            classTestBasic.customAccessorProperty = @"hello";
            NSString *propertyValue = classTestBasic.customAccessorProperty;

            [[theValue(classTestBasic.setterCalled) should] equal:theValue(1)];
            [[theValue(classTestBasic.getterCalled) should] equal:theValue(1)];
            [[propertyValue should] equal:@"hello"];
        });

        it(@"can exist without backing instance variable", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.noIvarProperty should] equal:@"hello"];
        });

        it(@"can be initialized at creation time", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.propertyWithInitialValue should] equal:@"hello"];
        });

        it(@"can be lazily initialized when it's first used", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];

            [[classTestBasic.lazyProperty should] equal:@"hello"];
        });

        it(@"can keep a copy of object instead of pointing to same instance", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];
            NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@1, @2, @3]];
            classTestBasic.propertyCopy = array1;

            [[theValue(array1 == classTestBasic.propertyCopy) should] beNo];
            [[array1 should] equal:classTestBasic.propertyCopy];

            [array1 addObject:@4];

            [[array1 shouldNot] equal:classTestBasic.propertyCopy];
        });
    });

    context(@"method", ^{
        it(@"instance method has access to instance property", ^{
            ZLIClassTestBasic *classTestBasic = [ZLIClassTestBasic new];
            [classTestBasic instanceMethod];

            [[classTestBasic.strProperty should] equal:@"hello world"];
        });

        it(@"class method can be called without creating an instance", ^{
            [[[ZLIClassTestBasic classMethodwithParamOne:@"hello" paramTwo:@"world"] should] equal:@"hello world"];
        });
    });

    context(@"method invoked on nil in accetptable and has", ^{
        it(@"nil return value for object return type", ^{
            ZLIClassTestBasic *classTestBasic = nil;

            [[[classTestBasic instanceMethodReturnsStr] should] beNil];
        });

        it(@"has 0 return value for numeric type", ^{
            ZLIClassTestBasic *classTestBasic = nil;

            [[theValue([classTestBasic instanceMethodReturnsNum]) should] equal:theValue(0)];
        });

        it(@"has NO return value for boolean type", ^{
            ZLIClassTestBasic *classTestBasic = nil;

            [[theValue([classTestBasic instanceMethodReturnsBool]) should] beNo];
        });
    });
});

SPEC_END
