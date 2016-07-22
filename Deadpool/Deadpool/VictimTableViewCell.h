//
//  VictimTableViewCell.h
//  Deadpool
//
//  Created by Sarah LAFORETS on 13/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Victim.h"

@class VictimTableViewCell;

@protocol VictimTableViewCellDelegate <NSObject>

@required
- (void)checkKillVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;
- (void)deceasedVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;
- (void)nextVictim: (VictimTableViewCell *) sender upDatevictim:(Victim *)upDatevictim;

@end


@interface VictimTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewVictim;
@property (strong, nonatomic) IBOutlet UILabel *labelNameVictim;
@property (strong, nonatomic) IBOutlet UILabel *labelPriceVictim;
@property (strong, nonatomic) IBOutlet UIButton *buttonCheckKill;
@property (strong, nonatomic) IBOutlet UIButton *buttonDead;

@property (strong, nonatomic) IBOutlet UIButton *buttonKillNext;

@property (strong, nonatomic) Victim *victim;

@property (nonatomic, weak) id <VictimTableViewCellDelegate> delegate;
@end
