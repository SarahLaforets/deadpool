//
//  VictimTableBase.h
//  Deadpool
//
//  Created by Sarah Laforets on 21/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Victim.h"
#import "VictimTableViewCell.h"

@class VictimsManager;

@interface VictimTableBase : UITableViewController
@property (strong, nonatomic) NSArray<Victim *> *victims;
@property (strong, nonatomic) VictimsManager *victimsManager;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadVictims;
- (void)checkKillVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;
- (void)deceasedVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;
- (void)nextVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;

@end
