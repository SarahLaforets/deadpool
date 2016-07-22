//
//  DeadpoolTests.m
//  DeadpoolTests
//
//  Created by Sarah Laforets on 19/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Victim.h"

@interface DeadpoolTests : XCTestCase
@property (nonatomic, strong) Victim *victim;
@end

@implementation DeadpoolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.victim = [[Victim alloc] init:@"Bidule" lastname:@"Truc" price:50394 whyDescription:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo." image:@"image.pmg" deceased:YES killNext:NO kill:YES];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVictimFirstname {
    XCTAssertEqual(self.victim.firstName, @"Bidule");
}

- (void)testVictimLastname {
    XCTAssertEqual(self.victim.lastname, @"Truc");
}

- (void)testVictimprice {
    XCTAssertEqual(self.victim.price, 50394);
}

- (void)testVictimWhyDescription {
    XCTAssertEqual(self.victim.whyDescription, @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.");
}

- (void)testVictimImageName {
    XCTAssertEqual(self.victim.imageName, @"image.pmg");
}

- (void)testVictimDeceased {
    XCTAssertTrue(self.victim.deceased);
}

- (void)testVictimKilled {
    XCTAssertTrue(self.victim.kill);
}

- (void)testVictimKillNext {
    XCTAssertFalse(self.victim.killNext);
}

@end
