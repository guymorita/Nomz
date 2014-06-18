//
//  FilterTableViewController.m
//  Nomz
//
//  Created by Guy Morita on 6/16/14.
//  Copyright (c) 2014 geemoo. All rights reserved.
//

#import "FilterTableViewController.h"
#import "FilterSwitchTableViewCell.h"
#import "FilterCollapsibleTableViewCell.h"
#import "NomzSwitch.h"

@interface FilterTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *filterTableView;

@end

@implementation FilterTableViewController

- (id)init {
    self = [super init];
    self.filters = @[[@{@"nibname": @"FilterSwitchCell",
                       @"name": @"Deals",
                       @"sectionTitle": @"Deals",
                       @"value": @(0)} mutableCopy],
                     [@{@"type": @"cSection",
                       @"collapsed": @(0),
                       @"sectionTitle": @"Categories",
                       @"contents": @[@"American", @"Asian", @"Barbeque", @"Breakfast & Brunch", @"Burmese", @"Chinese", @"Dim Sum", @"Creperies"],
                       @"selected": @(0),
                       @"value": @(0)} mutableCopy],
                     [@{@"type": @"cSection",
                        @"collapsed": @(0),
                        @"sectionTitle": @"Radius",
                        @"contents": @[@"50 Meters", @"250 Meters", @"1 Km", @"5 Km", @"25 Km"],
                        @"selected": @(0),
                        @"value": @(0)} mutableCopy],
                     [@{@"type": @"cSection",
                        @"collapsed": @(0),
                        @"sectionTitle": @"Sort",
                        @"contents": @[@"Best Match", @"Distance", @"Highest Rated"],
                        @"selected": @(0),
                        @"value": @(0)} mutableCopy]
                     ];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterTableView.dataSource = self;
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"FilterSwitchCell"];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FilterCollapsibleTableViewCell" bundle:nil] forCellReuseIdentifier:@"FilterCollapsibleCell"];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(fireSearch:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)fireSearch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.filters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.filters[section][@"type"] isEqualToString:@"cSection"]) {
        NSNumber *myNum = self.filters[section][@"collapsed"];
        BOOL myBoo = [myNum boolValue];
        return myBoo ? 1: [self.filters[section][@"contents"] count];
    } else {
        return 1;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.filters[section][@"sectionTitle"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.filters[indexPath.section][@"type"] isEqualToString:@"cSection"]) {
        NSInteger index;
        NSNumber *isCollapsedNumber = self.filters[indexPath.section][@"collapsed"];
        BOOL isCollapsed = [isCollapsedNumber boolValue];
        if (isCollapsed){
            index = [self.filters[indexPath.section][@"selected"] integerValue];
        } else {
            index = indexPath.row;
        }
        FilterCollapsibleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCollapsibleCell" forIndexPath:indexPath];
        cell.filterTitle.text = self.filters[indexPath.section][@"contents"][index];
        return cell;
    } else {
        NSDictionary *filter = self.filters[indexPath.row];
        FilterSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:filter[@"nibname"] forIndexPath:indexPath];
        
        cell.filterBasicLabel.text = filter[@"name"];
        cell.filterBasicSwitch.on = [filter[@"value"] boolValue];
        cell.filterBasicSwitch.indexPath = indexPath.section;
        
        [cell.filterBasicSwitch addTarget:self action:@selector(switchFlipped:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.filters[indexPath.section][@"type"] isEqualToString:@"cSection"]) {
        self.filters[indexPath.section][@"collapsed"] = [self.filters[indexPath.section][@"collapsed"] isEqualToNumber:@(0)] ? @(1) : @(0);
        NSNumber *num = [NSNumber numberWithInt:indexPath.row];
        self.filters[indexPath.section][@"selected"] = num;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                      withRowAnimation:UITableViewRowAnimationNone];
    }
    NSLog(@"%d %d %@", indexPath.section, indexPath.row, self.filters[indexPath.section][@"collapsed"]);
}


- (void)switchFlipped:(id)sender {
    NomzSwitch *sw = (NomzSwitch *)sender;
    BOOL state = [sender isOn];
    NSNumber *rez = state == YES ? @(1) : @(0);
    self.filters[sw.indexPath][@"value"] = rez;
    NSLog(@"%@, %i", rez, sw.indexPath);
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
