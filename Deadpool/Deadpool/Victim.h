//
//  Victim.h
//  Deadpool
//
//  Created by Sarah Laforets on 14/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Victim : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *whyDescription;
@property (nonatomic, copy) NSString *imageName;
@property NSInteger price;
@property BOOL deceased;
@property BOOL killNext;
@property BOOL kill;

- (id) init:(NSString*)firstname lastname:(NSString *)lastname price:(NSInteger)price whyDescription:(NSString *)whyDescription image:(NSString *)imageName deceased:(BOOL)deceased killNext:(BOOL)killNext kill:(BOOL)kill;

@end
