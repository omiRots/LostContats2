//
//  ContactsTableViewController.h
//  LostContats2
//
//  Created by Rotem Shukron on 6/11/13.
//  Copyright (c) 2013 rotemss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import <MessageUI/MessageUI.h>

@interface ContactsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

- (IBAction)callButton:(id)sender;
- (IBAction)smsButton:(id)sender;
- (IBAction)mailButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
