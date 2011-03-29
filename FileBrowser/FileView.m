//
//  FileView.m
//  FileBrowser
//
//  Created by hara on 11/03/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileView.h"


@implementation FileView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithURL:(NSString*)url{
    self = [super init];
    if(self){
        urlString = [NSString stringWithString:url];
    }
    return self;
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:[self.view frame]];
	[webView setDelegate:self];
    [scroller setContentSize:CGSizeMake(768, 1024)];
    webView.scalesPageToFit = YES;
	[self.view addSubview: webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    

    // Do any additional setup after loading the view from its nib.
}

- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller {
    return self; // プレビュー用に用いるビューコントローラ
}
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
    [controller autorelease];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
