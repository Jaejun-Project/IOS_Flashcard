//
//  ViewController.m
//  Homework4
//
//  Created by JaeJun Min on 08/03/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"

@interface ViewController ()
@property (strong, nonatomic) FlashcardsModel* data;
@property (weak, nonatomic) IBOutlet UILabel *bigLabel;
@property (strong, nonatomic) Flashcard* flashcard;
@property (strong, nonatomic) UIColor* cardinalRed;

@property (weak, nonatomic) IBOutlet UIButton *favButton;

@property (strong, nonatomic) UIImage* favOn;
@property (strong, nonatomic) UIImage* favOff;
@property BOOL checkFirstLoad;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cardinalRed = [UIColor colorWithRed: 183.0/255.0 green: 0.0 blue: 0.0 alpha: 1.0];
    self.favOff = [UIImage imageNamed:@"star"];
    self.favOn = [UIImage imageNamed:@"starFilled"];
    self.checkFirstLoad = YES;
   
    //self.data=[FlashcardsModel sharedModel];
    // self.flashcard = self.data.randomFlashcard;

}

- (void) viewDidAppear:(BOOL)animated{
   [super viewDidAppear:animated];
   self.data=[FlashcardsModel sharedModel];
    if(self.checkFirstLoad ==YES)
    {
        self.bigLabel.text=@"Single tap to see a question, double tap to see an answer. \n Swipe left or right to go to next question.";
        self.bigLabel.textColor = UIColor.blackColor;
        self.checkFirstLoad=NO;
    }
    
    if(self.data.numberOfFlashcards >0){
        self.flashcard = self.data.randomFlashcard;
        [self.favButton setEnabled:YES];
    }else{
        self.bigLabel.text =  @"There are no more flashcards" ;
        self.bigLabel.textColor =UIColor.blueColor;
        [self.favButton setEnabled:NO];
    }
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer: recognizer];
    //[recognizer];
    
    
    UISwipeGestureRecognizer* right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [right setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer: right];
    //[recognizer];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    [self.view addGestureRecognizer: singleTap];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer: doubleTap];
    [singleTap requireGestureRecognizerToFail: doubleTap];
    
  
   // self.bigLabel.textColor =UIColor.blackColor;
    
}

-(void) favCheck:(BOOL) isfav{
    
    if(isfav == YES){
        
        [self.favButton setImage:self.favOn forState:UIControlStateNormal];
        NSLog(@"FAV");
    }
    else if(isfav == NO)
    {
        [self.favButton setImage:self.favOff forState:UIControlStateNormal];
        NSLog(@"notFav");
    }
}

- (void) singleTapped: (UITapGestureRecognizer *) recognizer {

    if(self.data.numberOfFlashcards ==0){
        [self outAndIn: @"There are no more flashcards" color: UIColor.blueColor];
    }else{
        [self outAndIn: self.flashcard.question color: UIColor.blueColor];
        [self favCheck:self.flashcard.isFavorite];
    }
}


- (void) doubleTapped: (UITapGestureRecognizer *) recognizer {

    if(self.data.numberOfFlashcards ==0){
        [self outAndIn: @"Please add some flashcards" color: self.cardinalRed];
    }else{
         [self outAndIn: self.flashcard.answer color: self.cardinalRed];
         [self favCheck:self.flashcard.isFavorite];
    }
   
    
}
-(void) swipeLeft: (UISwipeGestureRecognizer *) recognizer{
    if([recognizer direction] == UISwipeGestureRecognizerDirectionLeft){
        if(self.data.numberOfFlashcards >0){
            self.flashcard=self.data.prevFlashcard;
            self.bigLabel.text=
            self.flashcard.question;
            self.bigLabel.textColor=[UIColor blueColor];
            [self favCheck:self.flashcard.isFavorite];
        }
    }

}

-(void) swipeRight: (UISwipeGestureRecognizer *) recognizer{
    if([recognizer direction] == UISwipeGestureRecognizerDirectionRight){
        if(self.data.numberOfFlashcards >0){
            self.flashcard=self.data.prevFlashcard;
            self.bigLabel.text=
            self.flashcard.question;
            self.bigLabel.textColor=[UIColor blueColor];
            [self favCheck:self.flashcard.isFavorite];
        }
    }
    
}



- (void) inAndOut: (NSString *) msg {
    self.bigLabel.alpha = 0;
    self.bigLabel.text = msg;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bigLabel.alpha = 1;
                         self.favButton.alpha =1;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration: 2.0 animations: ^{
                             self.bigLabel.alpha = 0;
                             self.favButton.alpha=0;
                         }];
                     }];
}

- (void) fadeInLabel:(NSString *) msg {
    // Alpha = 0 means the text is transparent
    self.bigLabel.alpha = 0;
    self.bigLabel.text = msg;
    
    [UIView animateWithDuration:1.0 animations:^{
        // Fade in the text of the label
        self.bigLabel.alpha = 1;
        self.favButton.alpha=1;
    }];
}

- (void) outAndIn: (NSString *) msg color: (UIColor *) textColor {
    [UIView animateWithDuration:1.0
                     animations:^{
                         // Fade out the text of the label
                         self.bigLabel.alpha = 0;
                         self.favButton.alpha=0;
                     } completion: ^(BOOL finished) {
                         // Set color
                         self.bigLabel.textColor = textColor;
                       //  self.favButton.alpha=1;
                         [self fadeInLabel: msg];
                     }];
}
- (IBAction)buttonTapped:(id)sender {
    if(self.favButton.imageView.image == self.favOn){
        NSLog(@"chekcehck");
        [self.favButton setImage:self.favOff forState:UIControlStateNormal];
        [self.data toggleFavorite];
    }else if (self.favButton.imageView.image == self.favOff)
    {
        [self.favButton setImage:self.favOn forState:UIControlStateNormal];
        [self.data toggleFavorite];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
