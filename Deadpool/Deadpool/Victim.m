//
//  Victim.m
//  Deadpool
//
//  Created by Sarah Laforets on 14/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "Victim.h"

@implementation Victim

- (id) init:(NSString *)firstname lastname:(NSString *)lastname price:(NSInteger)price whyDescription:(NSString *)whyDescription image:(NSString *)imageName deceased:(BOOL)deceased killNext:(BOOL)killNext kill:(BOOL)kill {
    self = [super init];
    if (self) {
        self.firstName = firstname;
        self.lastname = lastname;
        self.price = price;
        self.whyDescription = whyDescription;
        self.imageName = imageName;
        self.deceased = deceased;
        self.killNext = killNext;
        self.kill = kill;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    Victim *victim = [Victim new];
    victim.firstName = self.firstName;
    victim.lastname = self.lastname;
    victim.price = self.price;
    victim.whyDescription = self.whyDescription;
    victim.imageName = self.imageName;
    victim.deceased = self.deceased;
    victim.killNext = self.killNext;
    victim.kill = self.kill;
    return victim;
}
@end
