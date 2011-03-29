//
//  FileView.h
//  FileBrowser
//
//  Created by hara on 11/03/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FileView : UIViewController <UIWebViewDelegate, UIDocumentInteractionControllerDelegate>{

    UIWebView *webView;
    IBOutlet UIScrollView *scroller;
    NSString *urlString;
    
}

-(id)initWithURL:(NSString*)url;
@end
