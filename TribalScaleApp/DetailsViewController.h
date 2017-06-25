//
//  DetailsViewController.h
//  TribalScaleApp
//
//  Created by Siamac 6 on 6/23/17.
//  Copyright © 2017 Siamac6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"

@interface DetailsViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic,strong)PersonModel *person;
@end
