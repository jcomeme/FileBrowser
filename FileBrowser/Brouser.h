//
//  Brouser.h
//  FileBrowser
//
//  Created by hara on 11/03/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Brouser : UITableViewController {
    NSMutableArray *mArray;
    NSString *directoryPath;
}
- (id)initWithStyle:(UITableViewStyle)style andPath:(NSString*)path;
@end
