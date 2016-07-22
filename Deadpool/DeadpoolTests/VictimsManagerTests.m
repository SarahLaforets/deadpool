//
//  VictimsManagerTests.m
//  Deadpool
//
//  Created by Sarah Laforets on 19/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VictimsManager.h"

@interface MockVictimsManager : VictimsManager
@property (strong, nonatomic) NSMutableArray<Victim *> *victims;
@end

@implementation MockVictimsManager

@end

@interface VictimsManagerTests : XCTestCase

@end

@implementation VictimsManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

#pragma mark - helper methods

- (MockVictimsManager *)createUniqueInstance {
    return [[MockVictimsManager alloc] init];
}

- (VictimsManager *)getSharedInstance {
    return [VictimsManager sharedInstance];
}

#pragma mark - tests
- (void)testSingletonSharedInstanceCreated {
    
    XCTAssertNotNil([self getSharedInstance]);
    
}

- (void)testSingletonUniqueInstanceCreated {
    
    XCTAssertNotNil([self createUniqueInstance]);
    
}

- (void)testSingletonReturnsSameSharedInstanceTwice {
    
    VictimsManager *s1 = [self getSharedInstance];
    XCTAssertEqual(s1, [self getSharedInstance]);
    
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance {
    
    VictimsManager *s1 = [self getSharedInstance];
    XCTAssertNotEqual(s1, [self createUniqueInstance]);
}

- (void)testSingletonReturnsSeparateUniqueInstances {
    
    VictimsManager *s1 = [self createUniqueInstance];
    XCTAssertNotEqual(s1, [self createUniqueInstance]);
}

#pragma mark - Methodes 

#pragma mark - Add Victim

- (void)testAddVictimReturnNonNullArray {
    VictimsManager *s1 = [self createUniqueInstance];
    NSArray *array = [s1 addNewVictim];
    XCTAssertNotNil(array);
}

- (void)testAddVictimReturnNonEmptyArray {
    VictimsManager *s1 = [self createUniqueInstance];
    NSArray *array = [s1 addNewVictim];
    XCTAssertEqual(array.count, 1);
}

- (void)testAddVictimShouldBeAVictimsArray {
    VictimsManager *s1 = [self createUniqueInstance];
    NSArray *array = [s1 addNewVictim];
    for (NSObject *aVictimObject in array) {
        XCTAssertEqualObjects(aVictimObject.class, [Victim class]);
    }
}

#pragma mark - Victim With Predicate

- (void)testVictimWithPredicateWithNullPredicateShouldReturnNonNullArray {
    VictimsManager *s1 = [self createUniqueInstance];
    //[s1 addNewVictim];
    NSArray *array = [s1 victimsWithPredicate:nil sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO]];
    XCTAssertNotNil(array);
}

- (void)testVictimWithPredicateWithNullPredicateShouldReturnArrayWithVictim {
    VictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    NSArray *array = [s1 victimsWithPredicate:nil sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO]];
    for (NSObject *aVictimObject in array) {
        XCTAssertEqualObjects(aVictimObject.class, [Victim class]);
    }
}

- (void)testVictimWithPredicateShouldReturnDeceasedVictim {
    
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    Victim *tom = [[Victim alloc] init];
    tom.deceased = YES;
    
    Victim *jack = [[Victim alloc] init];
    jack.deceased = NO;
    
    Victim *emily = [[Victim alloc] init];
    emily.deceased = YES;
    
    [s1.victims addObjectsFromArray:@[tom, jack, emily]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deceased == YES"];
    
    NSArray *array = [s1 victimsWithPredicate:predicate sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO]];
    
    for (Victim *aVictim in array) {
        XCTAssertTrue(aVictim.deceased);
    }
    XCTAssertEqual(array.count, 2);
}

- (void)testVictimWithPredicateArraySortedByFirstName {
    
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    Victim *tom = [[Victim alloc] init];
    tom.firstName = @"Tom";
    
    Victim *jack = [[Victim alloc] init];
    jack.firstName = @"Jack";
    
    Victim *emily = [[Victim alloc] init];
    emily.firstName = @"Emily";
    
    [s1.victims addObjectsFromArray:@[tom, jack, emily]];
    
    NSArray *expectedVictimsFirstname = @[ @"Emily", @"Jack", @"Tom"];
    
    //test
    NSArray *array = [s1 victimsWithPredicate:nil sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];
    
    //check
    for (NSInteger i = 0; i < array.count; i++) {
        Victim *victim = array[i];
        XCTAssertEqualObjects(victim.firstName, expectedVictimsFirstname[i]);
    }
}

- (void)testVictimWithPredicateArrayReturnEmptyNonNullArray {
    
    //Setup
    VictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deceased == YES"];
    
    //test
    NSArray *array = [s1 victimsWithPredicate:predicate sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]];
    
    //check
    XCTAssertNotNil(array);
    XCTAssertEqual(array.count, 0);
}

#pragma mark - Read image

- (void)testReadImageReturnNonNullUIImage {
    NSString * imageName = @"hi_hello.png";
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    Victim *tom = [[Victim alloc] init];
    tom.imageName = imageName;
    
    [s1.victims addObjectsFromArray:@[tom]];
    
    UIImage *image = [s1 readImage:tom.imageName];
    
    XCTAssertNotNil(image);
}

#pragma mark - Set Deceased Victim

- (void) testSetDeceasedVictimShouldChangeState {
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    Victim *oldVictim = [[s1 victims][0] copy];
    [s1 setDeceasedVictims:[s1 victims][0]];
    
    XCTAssertEqual(!oldVictim.deceased, [s1 victims][0].deceased);
}

- (void) testSetDeceasedVictimDeceasedShouldBeTrueWithKillNextFalse {
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    [s1 setDeceasedVictims:[s1 victims][0]];
    
    XCTAssertTrue([s1 victims][0].deceased);
    XCTAssertFalse([s1 victims][0].killNext);
}

- (void) testSetDeceasedVictimAliveAndKillShouldBeFalse {
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    [s1 victims][0].deceased = TRUE;
    [s1 setDeceasedVictims:[s1 victims][0]];
    
    XCTAssertFalse([s1 victims][0].kill);
}

#pragma mark - Set Kill Victims

- (void) testsetKillVictimsShouldChangeStateDeceasedShouldBeTrueAndKillNextShouldBeFalse {
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    Victim *oldVictim = [[s1 victims][0] copy];
    [s1 setKillVictims:[s1 victims][0]];
    
    XCTAssertEqual(!oldVictim.kill, [s1 victims][0].kill);
    XCTAssertTrue([s1 victims][0].deceased);
    XCTAssertFalse([s1 victims][0].killNext);
}

- (void) testsetKillVictimsShouldChangeStateDeceasedAndKillNextShouldBeFalse {
    //Setup
    MockVictimsManager *s1 = [self createUniqueInstance];
    [s1 addNewVictim];
    Victim *oldVictim = [[s1 victims][0] copy];
    [s1 setKillVictims:[s1 victims][0]];
    
    XCTAssertEqual(!oldVictim.kill, [s1 victims][0].kill);
    XCTAssertTrue([s1 victims][0].deceased);
    XCTAssertFalse([s1 victims][0].killNext);
}

@end
