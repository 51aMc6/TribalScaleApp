//
//  ViewController.h
//  TribalScaleApp
//
//  Created by Siamac 6 on 6/23/17.
//  Copyright © 2017 Siamac6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

