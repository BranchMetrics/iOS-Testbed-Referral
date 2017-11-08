//
//  CreditHistoryTVC.m
//  TestBed Referrals
//
//  Created by Parth Kalavadia on 10/24/17.
//  Copyright © 2017 Parth Kalavadia. All rights reserved.
//

#import "CreditHistoryTVC.h"
#import "Branch.h"
#import "AlertHelper.h"

@interface CreditHistoryTVC ()
@property (strong,nonatomic)NSArray *transactions;
@end

@implementation CreditHistoryTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[Branch getInstance] getCreditHistoryWithCallback:^(NSArray * _Nullable transactions, NSError * _Nullable error) {        
        if (error) {
            [AlertHelper showAlertMessageWithTitle:@"Credit history error" withMessage:error.localizedDescription fromViewController:self];
        }
        else {
            self.transactions = transactions;
            [self.tableView reloadData];
        }
    }];
    
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    return [self.transactions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *creditDetails = [self.transactions objectAtIndex:indexPath.row];
    NSDictionary *trasaction = creditDetails[@"transaction"];

    int type = [trasaction[@"type"] intValue];
    
    UITableViewCell *cell;
    if (type == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"creditRedeemCellId" forIndexPath:indexPath];

    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"creditHistoryCell" forIndexPath:indexPath];
        
        NSDictionary *event = creditDetails[@"event"];
        
        UILabel *eventLbl = (UILabel*)[cell viewWithTag:105];
        eventLbl.text = [NSString stringWithFormat:@"Event: %@",event[@"name"]];
        
        UILabel *referreeLbl = (UILabel*)[cell viewWithTag:101];
        referreeLbl.text = creditDetails[@"referree"];
        
        UILabel *referrerLbl = (UILabel*)[cell viewWithTag:102];
        referrerLbl.text = creditDetails[@"referrer"];
        
    }
    
    // Configure the cell...
    
    
    
    UILabel *bucketLbl = (UILabel*)[cell viewWithTag:103];
    bucketLbl.text = trasaction[@"bucket"];
    
    UILabel *amountLbl = (UILabel*)[cell viewWithTag:104];
    amountLbl.text = [NSString stringWithFormat:@"%d",[trasaction[@"amount"] intValue]];
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *creditDetails = [self.transactions objectAtIndex:indexPath.row];
    NSDictionary *trasaction = creditDetails[@"transaction"];
    
    int type = [trasaction[@"type"] intValue];

    UITableViewCell *cell;
    //CGFloat heigh;
    if (type == 2) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"creditRedeemCellId"];
        
    }else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"creditHistoryCell"];
    }
    
    return cell.frame.size.height;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
