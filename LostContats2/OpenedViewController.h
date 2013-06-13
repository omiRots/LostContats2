//
//  OpenedViewController.h
//  LostContacts
//
//  Created by Rotem Shukron on 6/9/13.
//  Copyright (c) 2013 OmiRot. All rights reserved.
//

#import "ViewController.h"
#import "Contact.h"

@interface OpenedViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *workMailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phone1Label;
@property (weak, nonatomic) IBOutlet UILabel *phone2Label;


@property (strong,nonatomic) Contact *contact;



//- (id)initWithContact:(Contact *)contact;


@end
