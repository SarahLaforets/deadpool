//
//  VictimsManager.m
//  Deadpool
//
//  Created by Sarah Laforets on 18/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimsManager.h"
#import "Constants.h"


@interface VictimsManager ()
@property (strong, nonatomic) NSArray<Victim *> *victimsSort;
@property (strong, nonatomic) NSMutableArray<Victim *> *victims;
@end


@implementation VictimsManager

+ (instancetype)sharedInstance {
    static VictimsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VictimsManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.victims = [[NSMutableArray alloc] init];
        self.victimsSort = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVictim:) name:sentVictimBack object:nil];
    }
    
    return self;
}

#pragma mark - Getters
- (NSArray *)victimsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor * _Nonnull)descriptor {
    NSArray *filteredVictims;
    if (predicate) {
        filteredVictims = [self.victims filteredArrayUsingPredicate:predicate];
    } else {
        filteredVictims = [self.victims copy];
    }
    
    NSArray *victimsSort = [filteredVictims sortedArrayUsingDescriptors:@[descriptor]];
    
    return victimsSort;
}

#pragma mark - Setters

- (void) updateVictim:(Victim *)victim withOldVictim:(Victim *)updateVictim {
    for ( Victim *aVictim in self.victims) {
        if([aVictim.firstName isEqualToString:updateVictim.firstName]) {
            aVictim.firstName = victim.firstName;
            aVictim.lastname = victim.lastname;
            aVictim.price = victim.price;
            aVictim.whyDescription = victim.whyDescription;
            aVictim.killNext = victim.killNext;
            aVictim.kill = victim.kill;
            aVictim.deceased = victim.deceased;
            aVictim.imageName = victim.imageName;
        }
    }
}

- (void) setDeceasedVictims:(Victim *)victim {
    for ( Victim *aVictim in self.victims) {
        if ([aVictim.firstName isEqualToString:victim.firstName]) {
            aVictim.deceased = !victim.deceased;
            aVictim.killNext = NO;
            if (!aVictim.deceased) {
                aVictim.kill = NO;
            }
        }
    }
}

- (void) setKillVictims:(Victim *)victim {
    for ( Victim *aVictim in self.victims) {
        if ([aVictim.firstName isEqualToString:victim.firstName]) {
            aVictim.kill = !victim.kill;
            aVictim.deceased = YES;
            aVictim.killNext = NO;
        }
    }
}

- (void) setNextVictims:(Victim *)victim {
    for ( Victim *aVictim in self.victims) {
        if ([aVictim.firstName isEqualToString:victim.firstName]) {
            aVictim.killNext = !victim.killNext;
            aVictim.kill = NO;
            aVictim.deceased = NO;
        }
    }
}

#pragma mark - Creation

- (Victim *) createVictim {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSString *number = @"0123456789";
    NSString *firstname = [self randomStringWithLength:4 letters:letters];
    NSString *lastname = [self randomStringWithLength:6 letters:letters];
    NSString *whyDescription = [self randomStringWithLength:50 letters:letters];
    NSString *imageName = @"picture-spyMaleFilled-white";
    NSInteger price = [[self randomStringWithLength:5 letters:number] integerValue];
    Victim *victim = [[Victim alloc] init:firstname lastname:lastname price:price whyDescription:whyDescription image:imageName deceased:false killNext:false kill:false];
    return victim;
}

- (NSArray *)addNewVictim {
    [self.victims addObject:[self createVictim]];
    return [self.victims copy];
}

#pragma mark - Custom

-(NSString *) randomStringWithLength: (int) len letters:(NSString*)letters {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (UIImage *)readImage:(NSString * _Nonnull)pictureName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:savedImagePath];
    
    UIImage* image = nil;
//    image = [[UIImage alloc] initWithContentsOfFile:savedImagePath];
    if(!success) {
        return nil;
    } else {
        image = [[UIImage alloc] initWithContentsOfFile:savedImagePath];
    }
    return image;
}

#pragma mark - Notification
- (void)updateVictim:(NSNotification *) notification {
    NSDictionary* userInfo = notification.userInfo;
    Victim* oldVictim = (Victim*)userInfo[@"oldVictim"];
    Victim* victim = (Victim*)userInfo[@"victim"];
    [self updateVictim:victim withOldVictim:oldVictim];
}
    
@end
