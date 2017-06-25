//
//  ViewController.m
//  TribalScaleApp
//
//  Created by Siamac 6 on 6/23/17.
//  Copyright © 2017 Siamac6. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+Awesome.h"
#import "AFNetworking.h"
#import "JSONModel.h"
#import "PersonModel.h"
#import "DetailsViewController.h"

@interface ViewController ()
    {
        NSArray *peopleArr;
        NSArray *list;
    }
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDataTask:^(NSArray* arr){
        if (arr){
            peopleArr = arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            peopleArr = nil;
        }
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"People List";
    [self.navigationController.navigationBar  setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:1.f]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.title=@"";
    [self.navigationController.navigationBar lt_reset];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
}

-(void)configureDataTask:(void(^)(NSArray* dataArr))completion {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *afManager =[[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    [afManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://randomuser.me/api/?results=50"]];
    NSURLSessionDataTask *dataTask = [afManager dataTaskWithRequest:req completionHandler:^(NSURLResponse* res, id responseObj, NSError* error){
        if (!error){
            NSMutableArray* arr = [[NSMutableArray alloc]init];
            for (NSDictionary *result in [responseObj valueForKey:@"results"]) {
                PersonModel *person = [[PersonModel alloc]initWithDictionary:result error:&error];
                [arr addObject:person];
            }
            completion([arr copy]);
            
        } else {
            NSLog(@"Error %@",error);
            NSArray *nilArr=nil;
            completion(nilArr);
        }
    }];
    [dataTask resume];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offSetY = scrollView.contentOffset.y;
    if (offSetY > 0) {
        float alpha = 1 - (offSetY/1000);
        if (alpha > 0.3) {
            [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:alpha]];
        }
    } else {
        float degree = -1 * (offSetY + 64);
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:(0.f+degree)/255 green:175.f/255 blue:240.f/255 alpha:1.f]];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  MARK: - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return peopleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    PersonModel *person = [peopleArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [person.name valueForKey:@"first"],[person.name valueForKey:@"last"]];
    cell.detailTextLabel.text= person.email;
    NSURL *url = [NSURL URLWithString:[person.picture valueForKey:@"thumbnail"]];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;

    return cell;
}

//  MARK:- UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonModel *person = [peopleArr objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"PersonDetails" sender:person];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PersonModel *person = (PersonModel*)sender;
    if ([segue.identifier  isEqualToString: @"PersonDetails"] ) {
        DetailsViewController *detailView = [segue destinationViewController];
        detailView.person = person;
         [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.f/255 green:175.f/255 blue:240.f/255 alpha:0.0]];
    }
}


@end

