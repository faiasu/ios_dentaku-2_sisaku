//
//  HistoryViewController.m
//  dentaku
//
//  Created by Kazunori OYA on 12/07/25.
//  Copyright (c) 2012年 oya3.net. All rights reserved.
//

#import "HistoryViewController.h"
#import "MainViewController.h"
#import "HistoryViewDelegate.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

@synthesize historyViewDelegate = historyViewDelegate_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setHistory:(CalcHistory *)history
{
    history_ = history;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *array = [self.navigationController viewControllers];
    MainViewController *mainView = [array objectAtIndex:0];
    [mainView setSelectedIndex:-1]; // 未選択状態にする
    //NSLog(@"count[%d]", array.count);
    //for (int i=0; i<array.count; i++) {
    //    NSLog(@"[%d]0x%@",i,[array objectAtIndex:i]);
    //}
    
    //id mainViewController = [self.navigationController parentViewController];
    //mainViewController = [self.navigationController presentedViewController];
    //mainViewController = [self.navigationController presentingViewController];
    //
    //mainViewController = [self parentViewController];
    //mainViewController = [self presentedViewController];
    //mainViewController = [self parentViewController];
    //id topViewController = [self.navigationController topViewController];
    //if (mainViewController){
    //    //            [mainViewController setSelectedIndex:-1];
    //}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1; /* とりえあず１*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [history_ getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ( !cell ){
        //cell = [[[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:CellIdentifier]autorelease];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:CellIdentifier];
    }
    //cell.textLabel.text = 
    CalcData *cdp = [history_ getCalcData:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cdp->formula];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    //CalcData *cdp = [history_ getCalcData:indexPath.row];
    //cdp++;
    
    // プロパティを使ったムリムリ通知
#if 0
    NSArray *array = [self.navigationController viewControllers];
    MainViewController *mainView = [array objectAtIndex:0];
    [mainView setSelectedIndex:indexPath.row]; // 選択状態にする
#else
    // delegate で通知
    [self notifySlectedIndex:(int)indexPath.row];
#endif
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //[tableView didMoveToSuperview];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

- (void)notifySlectedIndex:(int)index
{
    if ( [self.historyViewDelegate respondsToSelector:@selector(selectedHistoryIndex:)] ) {
        [self.historyViewDelegate selectedHistoryIndex:index];
    }
    
}

@end
