//
//  PrimaryViewController.m
//  Nomz
//
//  Created by Guy Morita on 6/14/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import "PrimaryViewController.h"
#import "YelpClient.h"
#import "NomzTableViewCell.h"
#import "FilterTableViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface PrimaryViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet UITableView *nomzTableView;
@property (strong, nonatomic) NSDictionary *yelpResponse;
@property (strong, nonatomic) NSArray *yelpBusinesses;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) FilterTableViewController *filterVC;

@end

@implementation PrimaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self yelpRequest:@"delicious"];
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.title = @"Nomz";
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.searchBar.delegate = self;
        
        UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
        self.navigationItem.rightBarButtonItem = searchBarItem;
        
        UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(openFilterMenu:)];
        self.navigationItem.leftBarButtonItem = filterButton;
        self.filterVC = [[FilterTableViewController alloc] init];
    
        
   }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nomzTableView.dataSource = self;
    [self.nomzTableView registerNib:[UINib nibWithNibName:@"NomzTableViewCell" bundle:nil] forCellReuseIdentifier:@"NomzTableViewCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterButtonClicked {
    
}

- (void)yelpRequest:(NSString *)searchText {
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:searchText searchWithParameters:self.filterVC.filters success:^(AFHTTPRequestOperation *operation, id response) {
        self.yelpResponse = response;
        self.yelpBusinesses = self.yelpResponse[@"businesses"];
        NSLog(@"%@", response);
        [self.nomzTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yelpBusinesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NomzTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NomzTableViewCell" forIndexPath:indexPath];
    cell.nomzPlaceName.text = self.yelpBusinesses[indexPath.row][@"name"];
    return cell;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%@ was the text", searchBar.text);
    [self yelpRequest:searchBar.text];
    [searchBar resignFirstResponder];
}

- (IBAction)openFilterMenu:(id)sender {
    [self.navigationController pushViewController:self.filterVC animated:YES];
}



@end
