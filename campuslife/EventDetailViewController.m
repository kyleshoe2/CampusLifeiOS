//
//  EventDetailViewController.m
//  campuslife
//
//  Created by Clayton Yager on 10/8/14.
//  Copyright (c) 2014 LCSC. All rights reserved.
//

#import "EventDetailViewController.h"
#import "MonthlyEvents.h"
#import "UpdateEventViewController.h"
#import "CalendarViewController.h"


@interface EventDetailViewController (){
    MonthlyEvents *events;
}
@end

@implementation EventDetailViewController

- (NSString *)twentyFourToTwelve:(NSString *)time
{
    NSRange stringHourRange = NSMakeRange(0, 2);
    NSString *stringHour = [time substringWithRange:stringHourRange];
    int hourInt = [stringHour intValue];
    
    NSRange stringMinRange = NSMakeRange(2, 3);
    NSString *restOfString = [time substringWithRange:stringMinRange];
    
    
    if (hourInt == 0)
    {
        time = [NSString stringWithFormat:@"%d%@ AM", 12, restOfString];
    }
    
    else if(hourInt < 12)
    {
        time = [NSString stringWithFormat:@"%d%@ AM", hourInt, restOfString];
    }
    
    else if (hourInt == 12)
    {
        time = [NSString stringWithFormat:@"%d%@ PM", 12, restOfString];
    }
    
    else if (hourInt >= 13)
    {
        time = [NSString stringWithFormat:@"%d%@ PM", hourInt - 12, restOfString];
    }
    
    return time;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    events = [MonthlyEvents getSharedInstance];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %d, %d", [events getMonthBarDate], [events getSelectedDay], [events getSelectedYear]];

    
    if ([[_eventDict objectForKey:@"start"] objectForKey:@"dateTime"] == nil)
    {
        self.Time.text = @"All Day Event";
    }
    else
    {
    NSString *startTimeHold = [[[[[_eventDict objectForKey:@"start"] objectForKey:@"dateTime"] componentsSeparatedByString:@"T"][1] componentsSeparatedByString:@"."][0] substringWithRange:NSMakeRange(0, 5)];
    NSString *endTimeHold = [[[[[_eventDict objectForKey:@"end"] objectForKey:@"dateTime"] componentsSeparatedByString:@"T"][1] componentsSeparatedByString:@"."][0] substringWithRange:NSMakeRange(0, 5)];
        startTimeHold = [self twentyFourToTwelve:startTimeHold];
        endTimeHold = [self twentyFourToTwelve:endTimeHold];
        self.Time.text = [NSString stringWithFormat:@"%@ - %@",startTimeHold,endTimeHold];
    }
    
    
    NSString *titleToParse = [_eventDict objectForKey:@"summary"];
    titleToParse = [titleToParse stringByReplacingOccurrencesOfString:@":" withString:@"\n"];
    titleToParse = [titleToParse stringByReplacingOccurrencesOfString:@": " withString:@"\n"];
    titleToParse = [titleToParse stringByReplacingOccurrencesOfString:@"(" withString:@"\n("];
    self.Title.text = titleToParse;
    
    
    self.Location.text = [_eventDict objectForKey:@"location"];
    self.Description.text = [_eventDict objectForKey:@"description"];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end