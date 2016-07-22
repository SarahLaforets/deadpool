//
//  VictimTableBase.m
//  Deadpool
//
//  Created by Sarah Laforets on 21/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VictimTableBase.h"
#import "VictimsFullTableViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VictimsManager.h"
#import "VictimTableViewCell.h"

@interface MockVictimsManagerTestVictimBase : VictimsManager
@property (strong, nonatomic) NSMutableArray<Victim *> *victims;
@end

@implementation MockVictimsManagerTestVictimBase

@end

@interface VictimTableBaseTests : XCTestCase
@property (nonatomic, strong) VictimTableBase *mockTVC;
@end


@implementation VictimTableBaseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mockTVC = (VictimTableBase *)[sb instantiateViewControllerWithIdentifier:@"allVictims"];
    [self.mockTVC viewDidLoad];
    [self.mockTVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

#pragma mark - helper methods

- (MockVictimsManagerTestVictimBase *)createUniqueInstance {
    return [[MockVictimsManagerTestVictimBase alloc] init];
}

- (VictimsManager *)getSharedInstance {
    return [VictimsManager sharedInstance];
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource {
    XCTAssertTrue([self.mockTVC conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource {
    XCTAssertNotNil(self.mockTVC.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate {
    XCTAssertTrue([self.mockTVC conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate {
    XCTAssertNotNil(self.mockTVC.tableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection {
    MockVictimsManagerTestVictimBase *manager = [self createUniqueInstance];
    for (int i = 0; i<5; i++) {
        [manager addNewVictim];
    }
    self.mockTVC.victimsManager = manager;
    [self.mockTVC loadVictims];
    NSInteger expectedRows = 5;
    XCTAssertTrue([self.mockTVC tableView:self.mockTVC.tableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.mockTVC tableView:self.mockTVC.tableView numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewHeightForRowAtIndexPath {
    CGFloat expectedHeight = 64.0;
    CGFloat actualHeight = self.mockTVC.tableView.rowHeight;
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

//- (void)testTableViewCellCreateCellsWithReuseIdentifier {
//    MockVictimsManagerTestVictimBase *manager = [self createUniqueInstance];
//    for (int i = 0; i<5; i++) {
//        [manager addNewVictim];
//    }
//    self.mockTVC.victimsManager = manager;
//    [self.mockTVC loadVictims];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    VictimTableViewCell *cell = [self.mockTVC tableView:self.mockTVC.tableView cellForRowAtIndexPath:indexPath];
//    NSString *expectedReuseIdentifier = [NSString stringWithFormat:@"victimCell"];
//    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
//}

@end
