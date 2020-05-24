//
//  AddFlachcardViewController.m
//  Hw5_Flashcard
//
//  Created by JaeJun Min on 15/04/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import "AddFlachcardViewController.h"

@interface AddFlachcardViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UITextField *questionTF;
@property (weak, nonatomic) IBOutlet UITextField *answerTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation AddFlachcardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton.enabled = false;
    self.titleLabel.text = @"Enter question and answer for new flashcard";
    self.navItem.title = self.customTitle;
    self.questionTF.placeholder = self.placeholder1;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual: self.questionTF]) {
        [self.answerTF becomeFirstResponder];
    } else {
        [self.answerTF resignFirstResponder];
    }
    
    return YES;
    
}


- (IBAction)saveButtonTouched:(id)sender {
    if (self.addBlock){
        self.addBlock(self.questionTF.text, self.answerTF.text);
    }
}
- (IBAction)cancelButtonTouched:(id)sender {
    if (self.addBlock) {
        self.addBlock(nil, nil);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *changedString = [textField.text
                               stringByReplacingCharactersInRange:range withString:string];
    
    if ([textField isEqual: self.questionTF]) {
        [self enableSaveButton: changedString
                         answer: self.answerTF.text];
    } else if ([textField isEqual: self.answerTF]) {
        [self enableSaveButton: self.questionTF.text
                         answer: changedString
                          ];
    } else {
        [self enableSaveButton: self.questionTF.text
                         answer: self.answerTF.text
                    ];
    }
    
    return YES;
}

- (void)enableSaveButton: (NSString *) question
                   answer: (NSString *) answer{
    
    self.saveButton.enabled = (question.length > 0 &&
                               answer.length > 0
                              );
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
