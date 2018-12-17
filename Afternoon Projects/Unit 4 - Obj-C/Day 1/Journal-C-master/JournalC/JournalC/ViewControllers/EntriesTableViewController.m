//
//  EntriesTableViewController.m
//  JournalC
//
//  Created by Jayden Garrick on 12/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "EntriesTableViewController.h"
#import "DVMEntry.h"
#import "DVMEntryController.h"
#import "EntryDetailViewController.h"

@interface EntriesTableViewController ()

@end

@implementation EntriesTableViewController

// MARK: - ViewLifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

// MARK: - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DVMEntryController sharedController] entries] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
    
    DVMEntry *entry = [[DVMEntryController sharedController] entries][indexPath.row];
    cell.textLabel.text = entry.title;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:entry.timestamp];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DVMEntry *entry = [[DVMEntryController sharedController] entries][indexPath.row];
        [[DVMEntryController sharedController] removeEntry:entry];
        [tableView reloadData];
    }
}

// MARK: - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EntryDetailViewController *destinationVC = [segue destinationViewController];
        DVMEntry *entry = [[DVMEntryController sharedController] entries][indexPath.row];
        destinationVC.entry = entry;
    }
}

@end
