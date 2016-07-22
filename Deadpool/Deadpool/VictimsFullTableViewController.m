//
//  VictimsFullTableViewController.m
//  Deadpool
//
//  Created by Sarah LAFORETS on 13/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimsFullTableViewController.h"
#import "VictimsManager.h"

@interface VictimsFullTableViewController () <VictimTableViewCellDelegate>

@end

@implementation VictimsFullTableViewController

#pragma mark - Actions

- (IBAction)addNewVictim:(id)sender {
    [[VictimsManager sharedInstance] addNewVictim];
    [self loadVictims];
    [self.tableView reloadData];
}

@end
