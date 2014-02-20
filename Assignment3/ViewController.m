//
//  ViewController.m
//  Assignment3
//
//  Created by Build User on 2/4/14.
//  Copyright (c) 2014 Pitt. All rights reserved.
//

#import "ViewController.h"
#import "Fruit.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    _allSelected = NO;
    _fillCart.enabled = NO;
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Hello there!" message: @"Are you the Mr.Bond?" delegate: nil cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [alert show];
    [alert resignFirstResponder];*/
    
    self.title = @"Banana Bar";
    [self loadCart];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void) loadCart
{
    _cart = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    //Fruit *tempFruit;
    
    for (int i=0; i<50; i++) {
        
        /*if(i % 10 == 0){
         tempFruit = [[Fruit alloc] initWithWithName:@"Free Banana" andColor:@"Yellow" andShape:@"Curvy"];
         tempFruit.url = @"http://www.clker.com/cliparts/c/9/8/0/11949861231045503408banana.svg.hi.png";
         }
         else{
         tempFruit = [[Fruit alloc] initWithWithName:@"Banana" andColor:@"Yellow" andShape:@"Curvy"];
         tempFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
         }*/
        Fruit *tempFruit = [[Fruit alloc] initWithWithName:@"Bananas" andColor:@"Yellow" andShape:@"Curvy"];
        tempFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [_cart addObject:tempFruit];
        [self.cartView reloadData];
        
    }

}
-(IBAction)selectAllOrNone:(id)sender{
    _allSelected = !_allSelected;
    
    if(_allSelected){
        [_selectAll setTitle:@"Select None" forState:UIControlStateNormal];
    } else {
        [_selectAll setTitle:@"Select All" forState:UIControlStateNormal];
    }
    
    [_cartView reloadData];
}

//Should remove all of the fruit in the cart.
-(IBAction)removeAllFruitInCart:(id)sender
{
    _allSelected = NO;
    _emptyCart.enabled = NO;
    _fillCart.enabled = YES;
    _selectAll.enabled = NO;
    self.cart = nil;
    self.cart = [[NSMutableArray alloc] initWithCapacity:0];
    [self.cartView reloadData];
    
    
}

//should add 50 bananas to the cart and display them!
-(IBAction)fillCartWithBananas:(id)sender
{
    _selectAll.enabled = YES;
    _emptyCart.enabled = YES;
    _fillCart.enabled = NO;
    [self loadCart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_cart count] == 0){
        return 1;
    }
    return [_cart count];
}
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fruit";
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
    }
    if([_cart count] == 0){
        cell.textLabel.text = @"No Fruit in Cart";
        cell.detailTextLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        
    } else {
        Fruit * tempFruit = [_cart objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempFruit name];
        cell.detailTextLabel.text = [tempFruit color];
        
        if(_allSelected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Fruit *currentFruit =[_cart objectAtIndex:indexPath.row];
    DetailViewController *detailedView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:Nil];
    detailedView.url = currentFruit.url;

    [self.navigationController pushViewController:detailedView animated:YES];

}

-(void) alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Paper");
            break;
        case 1:
            NSLog(@"Plastic");
            break;
        case 2:
            NSLog(@"Other");
            break;
        case 3:
            NSLog(@"Cancel");
            break;
        default:
            NSLog(@"Got here");
            break;
    }
}
-(void) alertViewCancel:(UIAlertView *)alertView{
    
}

@end
