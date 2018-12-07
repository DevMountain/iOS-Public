//
//  EntryDetailViewController.h
//  JournalC
//
//  Created by Jayden Garrick on 12/7/18.
//  Copyright © 2018 Jayden Garrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMEntryController.h"


NS_ASSUME_NONNULL_BEGIN

@interface EntryDetailViewController : UIViewController

@property (nonatomic, strong) DVMEntry *entry;

@end

NS_ASSUME_NONNULL_END
