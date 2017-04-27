//
//  WebViewController.m
//  Browser
//
//  Created by GreenRoot on 4/22/17.
//  Copyright © 2017 GreenRoot. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController ()

@end

@implementation WebViewController

//hide and show Methods for HistoryTable

-(void) hideHistory{
    _historyScroll.hidden = YES;
}

-(void) showHistory{
    _historyScroll.hidden = NO;
}
//----------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.historyScroll.layer.cornerRadius = 20;
    self.historyScroll.layer.shadowOpacity = 0.8;
    //self.historyTable.layer.cornerRadius = 20;
    self.CloseHistory.layer.cornerRadius = 20;
    addTen = 0;
}
//--------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//---------------------
-(void) urlRequest{ //this method read the url from the text view and open it in the web view.

    urlText = [_urlTextBar text];
    
    NSURL *url = [NSURL URLWithString:urlText];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
}
//-------------------
-(void)viewDidAppear:(BOOL)animated{
    
    
    [self hideHistory];
    
    [_webView setDelegate:self]; // to make the delegated methods impleminted
    
    
    
    NSUserDefaults *History=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray *storingArray = [[NSMutableArray alloc]init];
    
    [storingArray addObjectsFromArray:[History objectForKey:@"history"]];
    
    urlArray = [NSMutableArray array]; //this array contained all urls the user will open it
    
    [urlArray addObjectsFromArray:storingArray];

    tabCount =0;
    
    [self.historyScroll setScrollEnabled:YES];
    [self.historyScroll setShowsVerticalScrollIndicator:YES];
    [self.historyScroll setShowsHorizontalScrollIndicator:YES];
    [self.historyScroll setBounces:NO];
    self.historyScroll.contentSize = CGSizeMake(400, 1000);
    
    
    
}
//-------------------------
//delegated methods form UIWebViewDelegate
//start
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showHUDAddedTo:_webView animated:YES];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideHUDForView:_webView animated:YES];

}
//end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-----------------------
- (IBAction)CloseHistory:(id)sender {
    _historyScroll.hidden=YES;
}
//--------------------
- (IBAction)goButton:(id)sender {
    
    if ([[_urlTextBar text ]  isEqual: @""]) {
        
        [_urlTextBar setText:@"its none type url pleas"];
    
    }else{
    
        [self urlRequest];
    
        NSString *m = [_urlTextBar text];
    
        [urlArray addObject: m];
        
        NSUserDefaults *History = [NSUserDefaults standardUserDefaults];
        
        [History setObject:urlArray forKey:@"history"];
        
        [History synchronize];
    
        tabCount=tabCount+1; // this var for count user taps on goButton.
    
        countTab= tabCount; // to save count on var and edit it in the below code for back and forward Buttons.
    }
}
//-------------------
- (IBAction)forwardButton:(id)sender {
    
    if (countTab == ([urlArray count]-1) || countTab > ([urlArray count]-1) ){
        
        [_urlTextBar setText: @"Its the last url"];
    
    }else if (countTab < ([urlArray count]-1)){
        
        countTab = countTab+1;
        
        [_urlTextBar setText:[urlArray objectAtIndex:countTab]];
        
        [self urlRequest];
    
    }
}
//-----------------
- (IBAction)backButton:(id)sender {
    
    if (countTab == 1) {
        
        countTab = countTab-1;
        
        [_urlTextBar setText:[urlArray objectAtIndex:countTab]];
        
        [self urlRequest];
        
    } else if (countTab > 1 && countTab == [urlArray count]){
        
        countTab = countTab-2;

        [_urlTextBar setText:[urlArray objectAtIndex:countTab]];
        
        [self urlRequest];
        
    }else if (countTab <= -1 || countTab == 0){
        
        [_urlTextBar setText: @"no urls saved"];
        
    }else{
        
        countTab = countTab-1;
        
        [_urlTextBar setText:[urlArray objectAtIndex:countTab]];
        
        [self urlRequest];
    }
}
//-------------------

-(void) addButtonsByArray:(NSInteger)index{
    
    addTen = addTen +50;
    
    btn=[NSURL URLWithString:[urlArray objectAtIndex:index]];
    
    
 //   NSURL *urls = [NSURL URLWithString:[urlArray objectAtIndex:index]];
    
//    NSURLRequest *req = [NSURLRequest requestWithURL:urls];
    
    
    UILabel *labelUrl = [UILabel new];
    
    labelUrl.frame = CGRectMake(8, 0+addTen, 350, 30);
    labelUrl.backgroundColor = [UIColor whiteColor];
    labelUrl.textColor = [UIColor blueColor];
    
    [labelUrl setText:[urlArray objectAtIndex:index]];
    
    
    [self.historyScroll addSubview:labelUrl];
    
    
    
//    btn.layer.cornerRadius = 10;
//    btn.frame = CGRectMake(8, 0+addTen, 352, 30);
//    btn.backgroundColor = [UIColor blueColor];
//    
//    [btn setTag:index];
//    
//    [btn setTitle:[urlArray objectAtIndex:index] forState:UIControlStateNormal ];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    [btn addTarget:self action:@selector(callHistoryMember:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.historyScroll addSubview:btn];
    
    
    
    
}

/*//------------its method to make buttons in history work but i feild to connect it with buttons -----------

-(void) callHistoryMember:(UIButton*)Sender{
    
    NSString *urls = [urlArray objectAtIndex:[btn tag]];
    
    NSURL *url = [NSURL URLWithString:urls];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
}


----------------------*/
- (IBAction)History:(id)sender {
    
    
    for (NSUInteger i=0; i < [urlArray count]; i++) {
        
       [self addButtonsByArray:i];
        
    }

    [self showHistory];
}
//-------------
- (IBAction)addToFavorites:(id)sender {
    
    
    
}
//--------------
- (IBAction)openFavorites:(id)sender {

    

}
//------------
@end
