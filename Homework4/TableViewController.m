//
//  TableViewController.m
//  Hw5_Flashcard
//
//  Created by JaeJun Min on 15/04/2018.
//  Copyright © 2018 JaeJun Min. All rights reserved.
//

#import "TableViewController.h"
#import "FlashcardsModel.h"
#import "AddFlachcardViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) FlashcardsModel* data;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [FlashcardsModel sharedModel];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title=@"List of Flashcards";
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void) viewDidAppear:(BOOL)animated {
    // update table view
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.data numberOfFlashcards];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    Flashcard* flashcard = [self.data flashcardAtIndex:indexPath.row];
    // Configure the cell...
    
    cell.textLabel.text=[flashcard question];
    cell.textLabel.numberOfLines = 0;
  //  cell.detailTextLabel.text =[flashcard answer];
  //  NSLog(@"%@", [flashcard question]);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[self.data removeObjectAtIndex: indexPath.row];
        [self.data removeFlashcardAtIndex: indexPath.row];
       // NSLog(@"arry count: %zd", self.data.numberOfFlashcards );
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"addFlashcardSegue"]) {
     
         // Get the new view controller using [segue destinationViewController].
         AddFlachcardViewController * avc = [segue destinationViewController];
         avc.placeholder1 = @"Quetion";
         avc.customTitle = @"Add Flashcard";
 
        avc.addBlock = ^(NSString *question, NSString *answer)
         {
             if (question != nil && answer != nil ) {
             // Add to model
                 [self.data insertWithQuestion:question answer:answer favorite:NO];
             // update table view
             [self.tableView reloadData];
             }
             
             [self dismissViewControllerAnimated:YES completion:nil];
         };
     
    }
 }

@end
