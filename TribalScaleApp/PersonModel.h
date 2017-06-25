//
//  PersonModel.h
//  TribalScaleApp
//
//  Created by Siamac 6 on 6/23/17.
//  Copyright © 2017 Siamac6. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class IDModel, LocationModel, LoginModel, NameModel, PictureURLs;

@interface PersonModel : JSONModel

@property(nonatomic)NSString<Optional>* cell;
@property(nonatomic)NSString<Optional>* dob;
@property(nonatomic)NSString<Optional>* email;
@property(nonatomic)NSString<Optional>* gender;
@property(nonatomic)NSString<Optional>* nat;
@property(nonatomic)NSString<Optional>* phone;
@property(nonatomic)NSString<Optional>* registered;
@property(nonatomic)IDModel * id;
@property(nonatomic)LocationModel* location;
@property(nonatomic)LoginModel* login;
@property(nonatomic)NameModel* name;
@property(nonatomic)PictureURLs* picture;
@end

@interface IDModel : JSONModel
@property(nonatomic)NSString<Optional>* name;
@property(nonatomic)NSString<Optional>* value;
@end

@interface LocationModel : JSONModel
@property(nonatomic)NSString<Optional>* city;
@property(nonatomic)NSString<Optional>* postcode;
@property(nonatomic)NSString<Optional>* state;
@property(nonatomic)NSString<Optional>* street;
@end

@interface LoginModel : JSONModel
@property(nonatomic)NSString<Optional>* md5;
@property(nonatomic)NSString<Optional>* password;
@property(nonatomic)NSString<Optional>* salt;
@property(nonatomic)NSString<Optional>* sha1;
@property(nonatomic)NSString<Optional>* sha256;
@property(nonatomic)NSString<Optional>* username;
@end

@interface NameModel : JSONModel
@property(nonatomic)NSString<Optional>* first;
@property(nonatomic)NSString<Optional>* last;
@property(nonatomic)NSString<Optional>* title;
@end

@interface PictureURLs : JSONModel
@property(nonatomic)NSString<Optional>* large;
@property(nonatomic)NSString<Optional>* medium;
@property(nonatomic)NSString<Optional>* thumbnail;

@end

