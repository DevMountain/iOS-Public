//
//  EntryDetailViewController.m
//  JournalC
//
//  Created by Jayden Garrick on 12/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import "EntryDetailViewController.h"
#import "DVMEntry.h"

@interface EntryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end

@implementation EntryDetailViewController

// MARK: - ViewLifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
}

// MARK: - Setup
- (void)updateViews
{
    if (self.entry) {
        self.titleTextField.text = self.entry.title;
        self.bodyTextView.text = self.entry.text;
    }
}

// MARK: - Actions
- (IBAction)clearButtonTapped:(id)sender
{
    self.titleTextField.text = @"";
    self.bodyTextView.text = @"";
}

- (IBAction)saveButtonTapped:(id)sender
{
    if (self.entry) {
        [[DVMEntryController sharedController] modifyEntry:self.entry withTitle:self.titleTextField.text text:_bodyTextView.text];
    } else {
        DVMEntry *entry = [[DVMEntry alloc] initWithTitle:self.titleTextField.text text:self.bodyTextView.text timestamp:[NSDate date]];
        [[DVMEntryController sharedController] addEntry:entry];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
