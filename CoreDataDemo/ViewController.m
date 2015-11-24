//
//  ViewController.m
//  CoreDataDemo
//
//  Created by tropsci on 15/11/24.
//  Copyright © 2015年 topsci. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "Card.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *persons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadDataFromCoreData];
//    Person *person = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:managerContext];
//    [person setValue:@"MJ" forKey:@"name"];
//    [person setValue:@(32) forKey:@"age"];
//    
//    Card *card = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Card class]) inManagedObjectContext:managerContext];
//    [card setValue:@"222213001233" forKey:@"no"];
//    
//    [person setValue:card forKey:@"card"];
//    
//    NSError *error1 = nil;
//    BOOL success = [managerContext save:&error1];
//    if (!success || error1) {
//        [NSException raise:@"访问数据库信息错误" format:@"%@", [error1 localizedDescription]];
//    }
}

- (void)reloadDataFromCoreData {
    NSManagedObjectContext *managerContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:NSStringFromClass([Person class]) inManagedObjectContext:managerContext];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    NSError *error = nil;
    self.persons = [managerContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
}

- (void)deletePerson:(Person *)person {
    NSManagedObjectContext *managerContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [managerContext deleteObject:person];
    if ([managerContext hasChanges]) {
        [managerContext save:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCellIdentifier = @"cellReusableID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    Person *person = [self.persons objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", person.age];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Person *person = [self.persons objectAtIndex:indexPath.row];
        [self deletePerson:person];
        [self reloadDataFromCoreData];
        [self.tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
