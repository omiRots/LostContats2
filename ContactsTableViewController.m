//
//  ContactsTableViewController.m
//  LostContats2
//
//  Created by Rotem Shukron on 6/11/13.
//  Copyright (c) 2013 rotemss. All rights reserved.
//

#import "ContactsTableViewController.h"
#import <AddressBook/AddressBook.h>
#import "OpenedViewController.h"





@interface ContactsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation ContactsTableViewController


{
    Contact *Bendod Ata CONTACT!!!
    Contact *selectedContact;
}


-(void)customActionPressed :(UIButton *)sender
{
    
	//Get the superview from this button which will be our cell
	UITableViewCell *owningCell = (UITableViewCell*)[sender superview];

	NSIndexPath *pathToCell = [self.tableView indexPathForCell:owningCell];
    
    selectedContact = [self.tableData objectAtIndex:pathToCell.row];
    
    
    NSString* phone = selectedContact.phoneNumber1;
    
    NSString *cleanedString = [[phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    
    //call
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    UIApplication *myApp = [UIApplication sharedApplication];

    
    //sms
    MFMessageComposeViewController *controller;
    
    //mail
    MFMailComposeViewController *mailcontroller;
    NSString *email =selectedContact.homeEmail;
    NSArray *emailArray = [[NSArray alloc] initWithObjects:email, nil];
    
    //open

    

    
    switch (sender.tag) {
        case 1:

            [myApp openURL:telURL];
            
            NSLog(@"Phone number is %@", phone);
            
            break;
        case 2:
            controller = [[MFMessageComposeViewController alloc] init];
            if([MFMessageComposeViewController canSendText])
            {
                controller.body = @"YOYOYO";
                controller.recipients = [NSArray arrayWithObjects:@"%@",cleanedString, nil];
                controller.messageComposeDelegate = self;
                
                [self presentViewController:controller animated:YES completion:nil];
            }
            NSLog(@"SMS Sent to %@", phone);

            break;
        case 3:
            mailcontroller = [[MFMailComposeViewController alloc] init];
            [mailcontroller setMailComposeDelegate:self];
            [mailcontroller setToRecipients:emailArray];
            [mailcontroller setSubject:@"OMG ITS THE SUBJECT!"];
            [self presentViewController:mailcontroller animated:YES completion:nil];
            NSLog(@"WTF I JUST SENT A MAIL!");
            break;
        case 4:
            
            [self performSegueWithIdentifier:@"toOpened" sender:selectedContact];


            NSLog(@"OpenPressed");
            break;
        default:
            break;
    }
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"ARRIVED! prepareForSegue");
    if ([[segue identifier] isEqualToString:@"toOpened"]) {
        
        // Get destination view
        OpenedViewController *vc = [segue destinationViewController];
        Contact *openedContact = (Contact *)sender;
        // Pass the information to your destination view
        vc.contact = openedContact;
 
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableData = [[NSMutableArray alloc] init];
[self getPersonOutOfAddressBook];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPersonOutOfAddressBook
{
    CFErrorRef error = NULL;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (addressBook != nil)
    {
        NSLog(@"Succesful.");
        
        NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        NSUInteger i = 0;
        for (i = 0; i < [allContacts count]; i++)
        {
            Contact *contact = [[Contact alloc] init];
            
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            
            //phones
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(contactPerson,kABPersonPhoneProperty);
            
            NSUInteger i = 0;
            for (i = 0; i < ABMultiValueGetCount(phoneNumbers); i++)
            {
                NSString *phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
                if (i == 0)
                {
                    contact.phoneNumber1 = phoneNumber;
                    NSLog(@"Phone1 = %@ ", contact.phoneNumber1);
                    
                }
                
                else if (i==1)
                    contact.phoneNumber2 = phoneNumber;
                NSLog(@"Phone2 = %@ ", contact.phoneNumber2);
                
            }
            
            
            
            
            
            NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName =  (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            contact.firstName = firstName;
            contact.lastName = lastName;
            contact.fullName = fullName;
            
            //email
            ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
            
            NSUInteger j = 0;
            for (j = 0; j < ABMultiValueGetCount(emails); j++)
            {
                NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                if (j == 0)
                {
                    contact.homeEmail = email;
                    NSLog(@"person.homeEmail = %@ ", contact.homeEmail);
                }
                
                else if (j==1)
                    contact.workEmail = email;
            }
            
            [self.tableData addObject:contact];
        }
    }
    
    CFRelease(addressBook);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *label = (UILabel *) [cell viewWithTag:1];
    label.font = [UIFont fontWithName:@"Colleged" size:16];
    
    
    // Configure the cell...
    
    //making buttons
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[callButton addTarget:self action:@selector(customActionPressed:)
	 forControlEvents:UIControlEventTouchDown];
	callButton.frame = CGRectMake(33, 36, 44, 44);
    callButton.tag = 1;
    //    callButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CallButton.png"]];
	[cell addSubview:callButton];
    
    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[smsButton addTarget:self action:@selector(customActionPressed:)
	 forControlEvents:UIControlEventTouchDown];
	smsButton.frame = CGRectMake(103, 36, 44, 44);
    smsButton.tag = 2;
    smsButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"SmsButton.png"]];
	[cell addSubview:smsButton];
    
    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[mailButton addTarget:self action:@selector(customActionPressed:)
         forControlEvents:UIControlEventTouchDown];
	mailButton.frame = CGRectMake(173, 36, 44, 44);
    mailButton.tag =3;
    mailButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MailButton40x40.png"]];
	[cell addSubview:mailButton];
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[openButton addTarget:self action:@selector(customActionPressed:)
         forControlEvents:UIControlEventTouchDown];
	openButton.frame = CGRectMake(243, 36, 44, 44);
    openButton.tag =4;
    //	openButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OpenButton.png"]];
	[cell addSubview:openButton];
    
    Contact *contact = [self.tableData objectAtIndex:indexPath.row];
    
    label.text = contact.fullName;;
        
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    

//    selectedContact = [self.tableData objectAtIndex:indexPath.row];

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}




-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil]; // can deliver a block with an Alert to say the user he sent the mail. (can do on sms as well).
}

@end
