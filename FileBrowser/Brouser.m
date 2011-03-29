//
//  Brouser.m
//  FileBrowser
//
//  Created by hara on 11/03/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Brouser.h"


@implementation Brouser

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        directoryPath = [[NSString alloc] init];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style andPath:(NSString*)path
{
    self = [super initWithStyle:style];
    if (self) {
        directoryPath = [[NSString alloc] initWithString:path];
        NSArray *titleArray = [NSArray arrayWithArray:[directoryPath componentsSeparatedByString:@"/"]];
        int num = [titleArray count]-2;
        self.navigationItem.title = [titleArray objectAtIndex:num];
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
    
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];
	
	NSLog(@"direc is %@",directoryPath);
	NSURL *url = [NSURL URLWithString:@"http://192.168.100.209/cgi-bin/fileBrouser/readPath.cgi"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSString *dataString = [NSString stringWithFormat:@"selected=%@",directoryPath];
    [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NSURLResponse* response;
	NSError* error = nil;
	NSData* result = [NSURLConnection sendSynchronousRequest:request
										   returningResponse:&response
													   error:&error];	//リクエストを送信して結果を受信
	if(error)NSLog(@"error = %@", error);
    
	NSString *returnedString = [[NSString alloc ]initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"ret %@",returnedString);
    
    
    mArray = [[NSMutableArray alloc] initWithArray:[returnedString componentsSeparatedByString:@":"]];
    [mArray removeObjectAtIndex:0];//remove filepath.
    
    for (int i = 0; i<[mArray count] - 1; i++) {
        NSLog (@"%@",[mArray objectAtIndex:i]);
    }
    
    [returnedString release];
    [pool drain];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [mArray count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    NSArray *dirArray = [NSArray arrayWithArray:[[mArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"|"]];
    NSLog(@"%@",[dirArray objectAtIndex:0]);
    if ([dirArray count]>1) {
        cell.textLabel.text = [dirArray objectAtIndex:1];
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    }else{
        cell.textLabel.text = [mArray objectAtIndex:indexPath.row];
        cell.imageView.image = nil;
    }
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    NSArray *dirArray = [NSArray arrayWithArray:[[mArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"|"]];
    NSLog(@"%@",[dirArray objectAtIndex:0]);
    NSMutableString *mStr = [[NSMutableString alloc] initWithString:directoryPath];
    Brouser *nextBrouser;
    if ([dirArray count]>1) {
        [mStr appendString:[dirArray objectAtIndex:1]];
        [mStr appendString:@"/"];
        NSString *lString = [NSString stringWithString:[mStr stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        nextBrouser = [[Brouser alloc] initWithStyle:UITableViewStylePlain andPath:lString];
        [self.navigationController pushViewController:nextBrouser animated:YES];
        [nextBrouser release];
        
    }else{
        [mStr appendString:[dirArray objectAtIndex:0]];
        NSString *gString = [NSString stringWithString:[mStr stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        
        //[mStr appendString:[mArray objectAtIndex:indexPath.row]];
        //[mStr appendString:@"/"];
        /* file was selected */
        
        NSURL *url = [NSURL URLWithString:@"http://192.168.100.209/cgi-bin/fileBrouser/readPath.cgi"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
        [request setHTTPMethod:@"POST"];
        NSString *dataString = [NSString stringWithFormat:@"selected=%@",gString];
        [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLResponse* response;
        NSError* error = nil;
        NSData* result = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&error];	//リクエストを送信して結果を受信
        if(error)NSLog(@"error = %@", error);
        
        NSString *returnedString = [[NSString alloc ]initWithData:result encoding:NSUTF8StringEncoding];
        NSLog(@"ret %@",returnedString);

        
        
        FileView *fView = [[FileView alloc] initWithURL:[NSString stringWithFormat:@"%@",returnedString]];
        [self.navigationController pushViewController:fView animated:YES];
        [fView release];
        
    }
    [mStr release];
    
}

@end
