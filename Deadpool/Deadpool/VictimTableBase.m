//
//  VictimTableBase.m
//  Deadpool
//
//  Created by Sarah Laforets on 21/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimTableBase.h"
#import "Constants.h"
#import "VictimsManager.h"
#import "VictimTableViewCell.h"
#import "VictimViewController.h"

@interface VictimTableBase () <VictimTableViewCellDelegate>

@end

@implementation VictimTableBase

- (VictimsManager *)victimsManager {
    if(!_victimsManager) {
        _victimsManager = [VictimsManager sharedInstance];
    }
    return _victimsManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //implement the cell
    [self.tableView registerNib:[UINib nibWithNibName:@"VictimTableViewCell" bundle:nil] forCellReuseIdentifier:@"victimCell"];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
    
    //Delete empty cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //set backgroundcolor tableView
    self.tableView.backgroundColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.0];
    
    //Param nav bar
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.0]];
    
    //Init mutableArray
    self.victims = [[NSMutableArray alloc] init];
    
    [self loadVictims];

    //if no victim
    if (self.victims.count == 0) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Victim"
                                                                       message:@"You need to add new victim with the button \"+\" "
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        UIAlertAction* addVictim = [UIAlertAction actionWithTitle:@"Add Victim" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self.victimsManager addNewVictim];
                                                              
                                                              [self loadVictims];
                                                              [self.tableView reloadData];
                                                          }];
        
        [alert addAction:defaultAction];
        [alert addAction:addVictim];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [self loadVictims];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.victims.count == 0) {
        //Set text if no victim
        
        UILabel *noVictimLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
        noVictimLabel.text             = @"No victim";
        noVictimLabel.textColor        = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        noVictimLabel.textAlignment    = NSTextAlignmentCenter;
        self.tableView.backgroundView = noVictimLabel;
    } else {
        self.tableView.backgroundView = nil;
    }
    return self.victims.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VictimTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"victimCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Victim *theVictim = self.victims[indexPath.row];
    cell.labelNameVictim.text = [NSString stringWithFormat: @"%@ %@", theVictim.firstName, theVictim.lastname];
    cell.labelPriceVictim.text = [NSString stringWithFormat:@"£%tu", theVictim.price];
    cell.imageViewVictim.layer.cornerRadius = cell.imageViewVictim.frame.size.height /2;
    cell.imageViewVictim.layer.masksToBounds = YES;
    cell.imageViewVictim.layer.borderWidth = 0;
    if ([theVictim.imageName isEqualToString:@"picture-spyMaleFilled-white"]) {
        cell.imageViewVictim.image = [UIImage imageNamed:@"picture-spyMaleFilled-white.png"];
    } else {
        cell.imageViewVictim.image = [self.victimsManager readImage:theVictim.imageName];
    }
    
    
    if (!theVictim.kill) {
        [cell.buttonCheckKill setImage:[UIImage imageNamed:@"control-checkedCheckbox-grey.png"] forState:UIControlStateNormal];
    } else {
        [cell.buttonCheckKill setImage:[UIImage imageNamed:@"control-checkedCheckboxFilled-red.png"] forState:UIControlStateNormal];
    }
    
    if (!theVictim.deceased) {
        [cell.buttonDead setImage:[UIImage imageNamed:@"control-poison-grey.png"] forState:UIControlStateNormal];
    } else {
        [cell.buttonDead setImage:[UIImage imageNamed:@"control-poisonFilled-red.png"] forState:UIControlStateNormal];
    }
    
    if (!theVictim.killNext) {
        [cell.buttonKillNext setImage:[UIImage imageNamed:@"control-star-grey.png"] forState:UIControlStateNormal];
    } else {
        [cell.buttonKillNext setImage:[UIImage imageNamed:@"control-starFilled-red.png"] forState:UIControlStateNormal];
    }
    
    cell.victim = theVictim;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VictimViewController *victimViewController = (VictimViewController *)[sb instantiateViewControllerWithIdentifier:@"victimDetails"];
    Victim *victim = [self.victims[indexPath.row] copy];
    victimViewController.victim = victim;
    [self.navigationController pushViewController:victimViewController animated:YES];
}

#pragma mark - Custom

- (void)loadVictims {
    // Load all victim by default
    self.victims = [self.victimsManager victimsWithPredicate:nil sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:NO]];
}

#pragma mark - VictimTableViewCell delegate

- (void)checkKillVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim {
    for (Victim *aVictim in self.victims) {
        if(aVictim == upDatevictim) {
            [self.victimsManager setKillVictims:aVictim];
        }
    }
    [self loadVictims];
    [self.tableView reloadData];
}

- (void)deceasedVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim {
    for (Victim *aVictim in self.victims) {
        if(aVictim == upDatevictim) {
            [self.victimsManager setDeceasedVictims:aVictim];
        }
    }
    [self loadVictims];
    [self.tableView reloadData];
}

- (void)nextVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim {
    for (Victim *aVictim in self.victims) {
        if(aVictim == upDatevictim) {
            [self.victimsManager setNextVictims:aVictim];
        }
    }
    [self loadVictims];
    [self.tableView reloadData];
}
@end
