//
//  ListViewController.m
//  PrivateATM
//
//  Created by Maxim Ohrimenko on 10/12/17.
//  Copyright © 2017 Maxim Ohrimenko. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController{
    NSNumber *number;
}

@synthesize nameCity;

- (void)viewDidLoad {
    [super viewDidLoad];
    number = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles {
    switch (pickerView.tag) {
        case 1: [buttonCity setTitle:[titles componentsJoinedByString:@" - "] forState:UIControlStateNormal];
            NSLog(@"%@", titles.firstObject);
            nameCity = titles.firstObject;
            number = [NSNumber numberWithInt:1];
        break;
    }
}




- (IBAction)nameCity:(id)sender {
    IQActionSheetPickerView *pickerCity = [[IQActionSheetPickerView alloc] initWithTitle:@"select city" delegate:self];
    NSMutableArray *picArray =  [[NSMutableArray alloc] init];
    picArray = [NSMutableArray arrayWithObjects:@"Винница", @"Днепропетровск", @"Донецк", @"Житомир", @"Запорожье", @"Ивано-Франковск", @"Киев", @"Кировоград", @"Луганск", @"Луцк", @"Львов", @"Николаев", @"Одесса", @"Полтава", @"Ровно", @"Сумы", @"Тернополь", @"Ужгород", @"Харьков", @"Херсон", @"Хмельницкий", @"Черкассы", @"Чернигов", @"Черновцы", nil];
    [pickerCity setTag:1];
    [pickerCity setTitlesForComponents:@[picArray]];
    [pickerCity show];
}


- (IBAction)goToMaps:(id)sender {
    NSLog(@"NAME CITY: %@", number);
    NSNumber *one = [NSNumber numberWithInt:1];
    
    if ([number isEqualToNumber:one]) {
        [self performSegueWithIdentifier:@"goMap" sender:sender];
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Вы не выбрали город!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
                                            
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"goMap"] ){
        MapViewController *mapView  = segue.destinationViewController;
        
        mapView.nameCity = nameCity;
        NSLog(@"send data to next VC");
    }
}

@end
