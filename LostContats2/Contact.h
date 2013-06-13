//
//  Contact.h
//  LostContacts
//
//  Created by Rotem Shukron on 6/2/13.
//  Copyright (c) 2013 OmiRot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *homeEmail;
@property (nonatomic, strong) NSString *workEmail;
@property (nonatomic, strong) NSString *phoneNumber1;
@property (nonatomic, strong) NSString *phoneNumber2;



@end
