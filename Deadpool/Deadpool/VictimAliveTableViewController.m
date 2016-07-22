//
//  VictimAliveTableViewController.m
//  Deadpool
//
//  Created by Sarah LAFORETS on 13/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimAliveTableViewController.h"
#import "VictimsManager.h"

@interface VictimAliveTableViewController ()

@end

@implementation VictimAliveTableViewController


#pragma mark -  VictimTableBase Override

- (void)loadVictims {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deceased == NO"];
    self.victims = [self.victimsManager victimsWithPredicate:predicate sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"lastname" ascending:YES]];
}

@end
