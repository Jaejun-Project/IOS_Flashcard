//
//  AddFlachcardViewController.h
//  Hw5_Flashcard
//
//  Created by JaeJun Min on 15/04/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddFlashcard)(NSString* question, NSString* answer);


@interface AddFlachcardViewController : UIViewController

@property (copy, nonatomic) AddFlashcard addBlock;
@property (strong, nonatomic) NSString* customTitle;
@property (strong, nonatomic) NSString* placeholder1;
@end
