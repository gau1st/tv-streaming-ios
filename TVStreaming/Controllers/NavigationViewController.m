//
//  NavigationViewController.m
//  TVStreaming
//
//  Created by Gilang Esha Gautama on 11/21/12.
//  Copyright (c) 2012 ___GILANGGAUTAMA___. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "NavigationViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HttpPlayerViewController.h"
//#import "DetailViewController.h"
#import "EditedCell_iPhone.h"
#import "Station.h"
#import "Server.h"
#import "StreamingApi.h"

@interface NavigationViewController () {
    
    int serverIndex;
    HttpPlayerViewController * playerVC;
    StreamingApi * streamingApiClient;
    BOOL refreshButtonEnabled;
}

@property (nonatomic, weak) IBOutlet UITableView *myTableView;

@end

@implementation NavigationViewController

@synthesize channelList = _channelList;
@synthesize fromCountry = _fromCountry;
@synthesize country = _country;
@synthesize idCountry = _idCountry;
@synthesize serverList = _serverList;



#pragma mark - View Life Cycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Favourite";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        refreshButtonEnabled = YES;
    }
    return self;
}

- (void)loadThis
{
    
    if (refreshButtonEnabled) {
        refreshButtonEnabled = NO;
        
        hud.userInteractionEnabled = NO;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
        
        
        _channelList = [[NSMutableArray alloc] init];
        
        
        [streamingApiClient getStationsByCountry:_idCountry withCallback:^(NSDictionary *response) {
            
            if([response[@"stat"] isEqualToString:@"ok"])
            {
                NSArray *stationFromJson = response[@"station"];
                
                for(int i=0;i<stationFromJson.count;i++)
                {
                    NSString *idStation = response[@"station"][i][@"_id"];
                    NSString *name = response[@"station"][i][@"name"];
                    NSString *longName = response[@"station"][i][@"long_name"];
                    NSString *description = response[@"station"][i][@"description"];
                    NSString *logo = response[@"station"][i][@"logo"];
                    
                    Station *station = [[Station alloc] initWithName:name idStation:idStation longName:longName description:description logo:logo];
                    
                    [_channelList addObject:station];
                }
                
                [hud hide:YES];
                
                [self.myTableView reloadData];
                
                refreshButtonEnabled = YES;
            }
            else {
                NSLog(@"Message: %@", response[@"message"]);
                
                [hud hide:YES];
                
                [self.myTableView reloadData];
                
                refreshButtonEnabled = YES;
            }
            
        }];
    }
    
    
}

- (void)loadThisfavorite
{
    
    if (refreshButtonEnabled) {
        refreshButtonEnabled = NO;
        
        hud.userInteractionEnabled = NO;
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
        
        
        _channelList = [[NSMutableArray alloc] init];
        
        [streamingApiClient getAllStationsWithCallback:^(NSDictionary *response) {
            
            if([response[@"stat"] isEqualToString:@"ok"])
            {
                NSArray *stationFromJson = response[@"station"];
                
                for(int i=0;i<stationFromJson.count;i++)
                {
                    NSString *idStation = response[@"station"][i][@"_id"];
                    NSString *name = response[@"station"][i][@"name"];
                    NSString *longName = response[@"station"][i][@"long_name"];
                    NSString *description = response[@"station"][i][@"description"];
                    NSString *logo = response[@"station"][i][@"logo"];
                    
                    Station *station = [[Station alloc] initWithName:name idStation:idStation longName:longName description:description logo:logo];
                    
                    [_channelList addObject:station];
                }
                
                [hud hide:YES];
                
                [self.myTableView reloadData];
                
                refreshButtonEnabled = YES;
            }
            else
            {
                NSLog(@"Message: %@", response[@"message"]);
                
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
    
    serverIndex = 0;
    
    if (_fromCountry) {
        // Custom initialization
        self.title = @"Channels";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
       
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                        style:UIBarButtonSystemItemDone target:self action:@selector(loadThis)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        [self loadThis];
        
    } else {
        
        // Custom initialization
        self.title = @"Favorite";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                        style:UIBarButtonSystemItemDone target:self action:@selector(loadThisfavorite)];
        self.navigationItem.rightBarButtonItem = rightButton;
        
        [self loadThisfavorite];
        
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
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
    return _channelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    Station *stationFromArray = [_channelList objectAtIndex:indexPath.row];
    
    cell.name.text = stationFromArray.name;
    
    //NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:stationFromArray.logo]];
    
    [cell.icon setImageWithURL:[NSURL URLWithString:stationFromArray.logo]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [hud show:YES];
    refreshButtonEnabled = NO;
    
    Station *stationFromArray = [_channelList objectAtIndex:indexPath.row];
    
    
    //Query for get server data
    //NSString *url = [NSString stringWithFormat:@"http://192.168.1.6:3001/0.1/station/showserver/withstationid/%@", stationFromArray.idStation];
    
    _serverList = [[NSMutableArray alloc] init];
    
    [streamingApiClient getServersByStation:stationFromArray.idStation withCallback:^(NSDictionary *response) {
        
        if([response[@"stat"] isEqualToString:@"ok"])
        {
            NSArray *serverFromJson = response[@"server"];
            
            for(int i=0;i<serverFromJson.count;i++)
            {
                NSString *idServer = response[@"server"][i][@"url"];
                NSString *urlStreaming = response[@"server"][i][@"url"];
                NSURL *urlStreamingURL = [NSURL URLWithString:urlStreaming];
                NSString *typeStreaming = response[@"server"][i][@"type"];
                NSString *quality = response[@"server"][i][@"quality"];
                NSString *priority = response[@"server"][i][@"priority"];
                NSInteger priorityInt = [priority intValue];
                NSString *showAlert = response[@"server"][i][@"show_alert"];
                NSInteger showAlertInt = [showAlert intValue];
                NSString *alertMessage = response[@"server"][i][@"alert_message"];
                
                if ([urlStreamingURL.scheme isEqualToString:@"http"]) {
                    Server *server = [[Server alloc] initWithId:idServer url:urlStreaming type:typeStreaming quality:quality priority:priorityInt showAlert:showAlertInt alertMessage:alertMessage];
                    [_serverList addObject:server];
                }
            }
            
            [hud hide:YES];
            refreshButtonEnabled = YES;
            
            if (_serverList.count > 0) {
                
                Server *firstPriorityServer = [_serverList objectAtIndex:serverIndex];
                
                // Initialize the movie player view controller with a video URL string
                playerVC = [[HttpPlayerViewController alloc] initWithContentURL:[NSURL URLWithString:firstPriorityServer.url]];
                
                // Remove the movie player view controller from the "playback did finish" notification observers
                [[NSNotificationCenter defaultCenter] removeObserver:playerVC
                                                                name:MPMoviePlayerPlaybackDidFinishNotification
                                                              object:playerVC.moviePlayer];
                
                // Register this class as an observer instead
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(movieFinishedCallback:)
                                                             name:MPMoviePlayerPlaybackDidFinishNotification
                                                           object:playerVC.moviePlayer];
                
                // Set the modal transition style of your choice
                playerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                
                // Present the movie player view controller
                [self presentModalViewController:playerVC animated:YES];
                
                // Start playback
                [playerVC.moviePlayer prepareToPlay];
                //[playerVC.moviePlayer play];
                
            } else {
                
                //NSLog(@"tidak ada server HTTP");
                
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                  message:@"Sedang Tidak Ada Server yang Tersedia"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
                
            }
            
        }
        else
        {
            
            
            NSLog(@"Message: %@", response[@"message"]);
            
            [hud hide:YES];
            
            refreshButtonEnabled = YES;
            
        }
            
    }];
    
    
    
    
    
    /*
    else if ([firstPriorityServer.type isEqualToString:@"rtmp"] || [firstPriorityServer.type isEqualToString:@"rtsp"]){
        
        DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController_iPhone" bundle:Nil];
        NSLog(@"aaa %@", firstPriorityServer.url);
        detailView.urlRTMP = firstPriorityServer.url;
        detailView.titleName = stationFromArray.name;
        
        [self presentViewController:detailView animated:YES completion:nil];
        
    } */
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    
    //ureachable or no internet connection
    if([finishReason intValue] == 0)
        NSLog(@"Playback error");
        
        
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    
        
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        if([finishReason intValue] == 1){
            
            serverIndex += 1;
            
            if (serverIndex > (_serverList.count - 1) ) {
                
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                  message:@"Tidak Ada Lagi Server yang Tersedia"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil];
                [message show];
                
                [playerVC.moviePlayer stop];
                
            } else {
                
                Server *nextPriorityServer = [_serverList objectAtIndex:serverIndex];
                
                playerVC.moviePlayer.contentURL = [NSURL URLWithString:nextPriorityServer.url];
                
                playerVC.moviePlayer.initialPlaybackTime = -1;
                [playerVC.moviePlayer prepareToPlay];
                [playerVC.moviePlayer play];
            }
            
        } else {

            
            HttpPlayerViewController *moviePlayer = [aNotification object];
            
            // Remove this class from the observers
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:MPMoviePlayerPlaybackDidFinishNotification
                                                          object:moviePlayer];
            
            // Dismiss the view controller
            [self dismissModalViewControllerAnimated:YES];
            
            playerVC = nil;
            serverIndex = 0;
        
        }
    }
}

@end
