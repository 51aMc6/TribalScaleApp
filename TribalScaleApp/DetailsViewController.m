//
//  DetailsViewController.m
//  TribalScaleApp
//
//  Created by Siamac 6 on 6/23/17.
//  Copyright © 2017 Siamac6. All rights reserved.
//

#import "DetailsViewController.h"
#import "UINavigationBar+Awesome.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *natLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
@property (weak, nonatomic) IBOutlet UILabel *dobLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *streetLbl;
@property (weak, nonatomic) IBOutlet UILabel *cityLbl;


@end

@implementation DetailsViewController
@synthesize person;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[person.picture valueForKey:@"large"]];
    self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.scroll.delegate = self;
    
    self.nameLbl.text = [NSString stringWithFormat:@"%@ %@",[person.name valueForKey:@"first"],[person.name valueForKey:@"last"]];
    self.genderLbl.text= person.gender;
    self.natLbl.text = person.nat;
    self.dobLbl.text = [self stringToDate:person.dob];
    self.emailLbl.text = person.email;
    self.cellLbl.text = person.cell;
    self.phoneLbl.text = person.phone;
    self.streetLbl.text = [person.location valueForKey:@"street"];
    self.cityLbl.text = [person.location valueForKey:@"city"];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:0.6f]];
//    [self.navigationController.navigationBar lt_setElementsAlpha:0.0];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

-(void)viewDidAppear:(BOOL)animated {
   
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:0.6f]];
    self.navigationItem.title= [person.name valueForKey:@"first"];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetY = self.scroll.contentOffset.y;

    if (offsetY < 0) {
        float scale = 1.0 + fabsf(offsetY)/ self.scroll.frame.size.height;
        scale = MAX(0.0, scale);
        self.imgView.transform = CGAffineTransformMakeScale(scale, scale);
        float alpha = (offsetY/100)+ 1;
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:alpha]];
    } else {
         [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:0.6]];
        return;
    }
}

-(NSString*)stringToDate:(NSString*)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"MMM dd yyyy"];
    dateString = [formatter stringFromDate:date];
    return  dateString;
}

@end
