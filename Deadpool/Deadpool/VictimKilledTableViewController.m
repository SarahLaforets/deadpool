//
//  VictimKilledTableViewController.m
//  Deadpool
//
//  Created by Sarah Laforets on 21/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimKilledTableViewController.h"
#import "VictimsManager.h"

@interface VictimKilledTableViewController ()

@end

@implementation VictimKilledTableViewController
#pragma mark -  VictimTableBase Override

- (void)loadVictims {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"kill == YES"];
    self.victims = [self.victimsManager victimsWithPredicate:predicate sortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES]];
}

@end
