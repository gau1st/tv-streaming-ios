//
//  NationalityViewController.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CountryViewController.h"
#import "NavigationViewController.h"
#import "EditedCell_iPhone.h"
#import "Country.h"
#import "Reachability.h"
#import <unistd.h>
#import "StreamingApi.h"


@interface CountryViewController () {
    
    BOOL refreshButtonEnabled;
    
    Reachability * reach;
    
    StreamingApi * streamingApiClient;
    
}

@property (nonatomic, weak) IBOutlet UITableView *myTableView;

@end

@implementation CountryViewController

@synthesize nationList = _nationList;

#pragma mark - View Life Cycle Methods

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.title = @"Browse";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                        style:UIBarButtonSystemItemDone target:self action:@selector(loadThis)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        refreshButtonEnabled = YES;
    }
    return self;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(void)loadThis
{
    
    if (refreshButtonEnabled) {
        refreshButtonEnabled = NO;
        
        hud.userInteractionEnabled = NO;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
        
        
        [_nationList removeAllObjects];
        
        reach = [Reachability reachabilityWithHostname:@"www.google.com"];
        
        reach.reachableBlock = ^(Reachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"INTERNET CONNECTED");
            });
        };
        
        reach.unreachableBlock = ^(Reachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"INTERNET NOT CONNECTED");
            });
        };
        
        [reach startNotifier];
        
        [streamingApiClient getAllCountriesWithCallback:^(NSDictionary *response) {
            
            if([response[@"stat"] isEqualToString:@"ok"])
            {
                NSArray *countryFromJson = response[@"country"];
                
                for(int i=0;i<countryFromJson.count;i++)
                {
                    NSString *idCountry = response[@"country"][i][@"_id"];
                    NSString *name = response[@"country"][i][@"nation"];
                    NSString *flag = response[@"country"][i][@"flag"];
                    
                    Country *nation = [[Country alloc] initWithName:name idCountry:idCountry flag:flag];
                    
                    [_nationList addObject:nation];
                }
                
                [hud hide:YES];
                
                [self.myTableView reloadData];
                
                refreshButtonEnabled = YES;
            }
            else
            {
                NSLog(@"Message: %@", response[@"message"]);
                
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                                  message:@"This is your first UIAlertview message."
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
                
                
                [hud hide:YES];
                
                [self.myTableView reloadData];
                
                refreshButtonEnabled = YES;
            }
        }];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    streamingApiClient = [[StreamingApi alloc] init];
    
    self.myTableView.dataSource = self;
    
    _nationList = [[NSMutableArray alloc] init];
    
    
    [self loadThis];
    
    /*
     _nationList = @[@"Indonesia",
     @"China"
     ];
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     //Create an NSString object that we can use as the reuse identifier
     static NSString *cellIdentifier = @"NationalityCell_iPhone";
     
     //Check to see if we can reuse a cell from a row hat has just rolled off the screen
     UITableViewCell *cell = (NationalityCell_iPhone *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     
     
     //If there are no cells to be reused, create a new cell
     if (cell == nil)
     {
     NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NationalityCell_iPhone" owner:self options:nil];
     cell = [nib objectAtIndex:0];
     }
     
     //Set the text attribute to whatever we are currently looking in at our array
     cell.nameNationality.text = [_nationList objectAtIndex:indexPath.row];
     
     //Return the cell
     return cell;
     
     */
    
    static NSString *simpleTableIdentifier = @"EditedCell_iPhone";
    
    EditedCell_iPhone *cell = (EditedCell_iPhone *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditedCell_iPhone" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        } else {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EditedCell_iPad" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        }
    }
    
    Country* nationFromArray = [_nationList objectAtIndex:indexPath.row];
    
    cell.name.text = nationFromArray.nation;
    
    //NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:nationFromArray.flag]];
    
    //cell.icon.image = [[UIImage alloc] initWithData:imageData];
    [cell.icon setImageWithURL:[NSURL URLWithString:nationFromArray.flag]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NavigationViewController *nav = [[NavigationViewController alloc] initWithNibName:@"NavigationViewController_iPhone" bundle:Nil];
    
    nav.fromCountry = YES;
    
    Country* nationFromArray = [_nationList objectAtIndex:indexPath.row];
    
    nav.country = nationFromArray.nation;
    nav.idCountry = nationFromArray.idCountry;
    
    [self.navigationController pushViewController:nav animated:YES];
    [reach stopNotifier];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
