//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Suresh on 2/21/17.
//  Copyright © 2017 Suresh. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"

@interface ViewController (){
 //   NSArray *textArray;
    NSMutableArray *resultArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    resultArray = [[NSMutableArray alloc]init];
    
    [self fetchData];

    [self.tableView reloadData];
}
-(void)fetchData{
    NSManagedObjectContext *context = [self getContext];
    
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"textinfo" ascending:YES];
    

    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Information"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"textinfo" ascending:YES]];
    
    resultArray = [[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:nil]];
    
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext *)getContext{
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    
    return context;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return resultArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSManagedObject *object = [resultArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [object valueForKey:@"textinfo"];
    
    return cell;

}
- (IBAction)addTex:(id)sender {
    
    if (self.textField.text.length > 0) {
        
    
    
    
    NSManagedObjectContext *context = [self getContext];
    
    NSManagedObject *obj1 = [NSEntityDescription insertNewObjectForEntityForName:@"Information" inManagedObjectContext:context];
    
    [obj1 setValue:self.textField.text forKey:@"textinfo"];
   

   
    [self fetchData];
    
    [self.tableView reloadData];

    self.textField.text = @"";
    
    [context save:nil];
    }

}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self getContext];
        [context deleteObject:[resultArray objectAtIndex:indexPath.row]];

//        NSManagedObject *obj = [resultArray objectAtIndex:indexPath.row];
//        [context deleteObject:obj];
        [resultArray removeObjectAtIndex:indexPath.row];
        [context save:nil];

        
        [tableView reloadData];
    }
}


@end
