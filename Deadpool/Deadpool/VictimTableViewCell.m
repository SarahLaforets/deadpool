//
//  VictimTableViewCell.m
//  Deadpool
//
//  Created by Sarah LAFORETS on 13/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimTableViewCell.h"

@implementation VictimTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Actions

- (IBAction)checkKillAction:(id)sender {
    [self.delegate checkKillVictim:self upDatevictim:self.victim];
}

- (IBAction)deadAction:(id)sender {
    [self.delegate deceasedVictim:self upDatevictim:self.victim];
}

- (IBAction)killNextAction:(id)sender {
    [self.delegate nextVictim:self upDatevictim:self.victim];
}

@end
