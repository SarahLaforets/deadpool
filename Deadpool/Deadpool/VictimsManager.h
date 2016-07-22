//
//  VictimsManager.h
//  Deadpool
//
//  Created by Sarah Laforets on 18/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Victim.h"

@interface VictimsManager : NSObject
+ (instancetype _Nonnull)sharedInstance;


- (NSArray * _Nonnull)addNewVictim;
- (NSArray * _Nonnull)victimsWithPredicate:(NSPredicate * _Nullable)predicate sortDescriptor:(NSSortDescriptor * _Nonnull)descriptor;
- (UIImage * _Nullable)readImage:(NSString * _Nonnull)pictureName;
- (void) setDeceasedVictims:(Victim * _Nonnull)victim;
- (void) setKillVictims:(Victim * _Nonnull)victim;
- (void) setNextVictims:(Victim * _Nonnull)victim;
@end
