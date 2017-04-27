//
//  WebViewController.h
//  Browser
//
//  Created by GreenRoot on 4/22/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>{

    NSString *urlText;
    
    NSMutableArray *urlArray;
    
    NSInteger tabCount;
    
    NSInteger countTab;
    
    float addTen ;
    
    NSURL *btn;
    

}
//propartes
@property (strong, nonatomic) IBOutlet UIButton *CloseHistory;

@property (strong, nonatomic) IBOutlet UITextField *urlTextBar;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

//methods
- (IBAction)CloseHistory:(id)sender;

- (IBAction)goButton:(id)sender;

- (IBAction)forwardButton:(id)sender;

- (IBAction)backButton:(id)sender;

- (IBAction)History:(id)sender;

- (IBAction)addToFavorites:(id)sender;

- (IBAction)openFavorites:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *historyScroll;

//@property (strong, nonatomic) IBOutlet UITableView *historyTable;


@end
