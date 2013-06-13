//
//  OpenedViewController.m
//  LostContacts
//
//  Created by Rotem Shukron on 6/9/13.
//  Copyright (c) 2013 OmiRot. All rights reserved.
//

#import "OpenedViewController.h"
#import "Contact.h"

@interface OpenedViewController ()

@end

@implementation OpenedViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _firstNameLabel.text = self.contact.firstName;
    _lastNameLabel.text = self.contact.lastName;
    _homeMailLabel.text = self.contact.homeEmail;
    _workMailLabel.text = self.contact.workEmail;
    _phone1Label.text = self.contact.phoneNumber1;
    _phone2Label.text = self.contact.phoneNumber2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
