//
//  ViewController.h
//  CoreDataDemo
//
//  Created by Suresh on 2/21/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)addTex:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

