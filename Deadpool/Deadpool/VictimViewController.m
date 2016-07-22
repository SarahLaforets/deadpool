//
//  VictimViewController.m
//  Deadpool
//
//  Created by Sarah Laforets on 14/07/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "VictimViewController.h"
#import "Constants.h"

@interface VictimViewController () <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageVictim;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstname;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastname;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPrice;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (weak, nonatomic) IBOutlet UIButton *buttonCheckKilled;
@property (weak, nonatomic) IBOutlet UIButton *buttonDeceased;
@property (weak, nonatomic) IBOutlet UIButton *buttonKillNext;

@property (strong, nonatomic) Victim *oldVictim;
@property (strong, nonatomic) NSString *pictureNewName;

@end

@implementation VictimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.victim.imageName isEqualToString:@"picture-spyMaleFilled-white"]) {
        self.imageVictim.image = [UIImage imageNamed:@"picture-spyMaleFilled-white.png"];
    } else {
        self.imageVictim.image = [self readImage:self.victim.imageName];
    }
    
    self.textFieldFirstname.text = self.victim.firstName;
    self.textFieldLastname.text = self.victim.lastname;
    self.textFieldPrice.text = [NSString stringWithFormat:@"%tu", self.victim.price];
    self.textViewDescription.text = self.victim.whyDescription;
    
    if (!self.victim.kill) {
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckbox-grey.png"] forState:UIControlStateNormal];
    } else {
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckboxFilled-red.png"] forState:UIControlStateNormal];
    }
    
    if (!self.victim.deceased) {
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poison-grey.png"] forState:UIControlStateNormal];
    } else {
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poisonFilled-red.png"] forState:UIControlStateNormal];
    }
    
    if (!self.victim.killNext) {
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-star-grey.png"] forState:UIControlStateNormal];
    } else {
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-starFilled-red.png"] forState:UIControlStateNormal];
    }
    self.textFieldFirstname.delegate = self;
    self.textFieldLastname.delegate = self;
    self.textFieldPrice.delegate = self;
    self.textViewDescription.delegate = self;
    
    self.oldVictim = [self.victim copy];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.victim.firstName = self.textFieldFirstname.text;
    self.victim.lastname = self.textFieldLastname.text;
    self.victim.price = [self.textFieldPrice.text integerValue];
    self.victim.whyDescription = self.textViewDescription.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:sentVictimBack object:self userInfo:@{@"victim":self.victim, @"oldVictim":self.oldVictim}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textFieldFirstname) {
        [self.textFieldLastname becomeFirstResponder];
    } else if (textField == self.textFieldLastname) {
        [self.textFieldPrice becomeFirstResponder];
    } else if (textField == self.textFieldPrice) {
        [self.textViewDescription becomeFirstResponder];
    }
    return YES;
}

#pragma mark - textview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if (textView == self.textViewDescription) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}

#pragma mark - Actions
- (IBAction)killedAction:(id)sender {
    self.victim.kill = !self.victim.kill;
    self.victim.deceased = YES;
    self.victim.killNext = NO;
    if (!self.victim.kill) {
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckbox-grey.png"] forState:UIControlStateNormal];
    } else {
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckboxFilled-red.png"] forState:UIControlStateNormal];
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poisonFilled-red.png"] forState:UIControlStateNormal];
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-star-grey.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)deceasedAction:(id)sender {
    self.victim.deceased = !self.victim.deceased;
    if (!self.victim.deceased) {
        self.victim.kill = NO;
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poison-grey.png"] forState:UIControlStateNormal];
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckbox-grey.png"] forState:UIControlStateNormal];
    } else {
        self.victim.killNext = NO;
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poisonFilled-red.png"] forState:UIControlStateNormal];
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-star-grey.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)killeNextAction:(id)sender {
    self.victim.killNext = !self.victim.killNext;
    
    if (!self.victim.killNext) {
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-star-grey.png"] forState:UIControlStateNormal];
        
    } else {
        self.victim.kill = NO;
        self.victim.deceased = NO;
        [self.buttonKillNext setImage:[UIImage imageNamed:@"control-starFilled-red.png"] forState:UIControlStateNormal];
        [self.buttonDeceased setImage:[UIImage imageNamed:@"control-poison-grey.png"] forState:UIControlStateNormal];
        [self.buttonCheckKilled setImage:[UIImage imageNamed:@"control-checkedCheckbox-grey.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)changePicture:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    //[self presentModalViewController:imagePickerController animated:YES];
}

- (UIImage *)readImage:(NSString *)pictureName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:savedImagePath];
    
    UIImage* image = nil;
    
    if(!success) {
        return nil;
    } else {
        image = [[UIImage alloc] initWithContentsOfFile:savedImagePath];                                                                                                                                                                                               YES;
    }
    return image;
}

#pragma mark - ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    // Dismiss the image selection, hide the picker and
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageName = [NSString stringWithFormat:@"%@_%@.png",self.victim.firstName, self.victim.lastname];
    self.victim.imageName = [imageName copy];
    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
    self.imageVictim.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
