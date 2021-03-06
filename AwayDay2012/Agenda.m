//
//  Agenda.m
//  AwayDay2012
//
//  Created by xuehai zeng on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Agenda.h"
#import "Session.h"

@implementation Agenda
@synthesize agendaDate=_agendaDate;
@synthesize sessions=_sessions;

-(id)init{
    self=[super init];
    if(self){
        if(self.sessions==nil){
            NSMutableArray *array=[[NSMutableArray alloc]init];
            self.sessions=array;
        }
    }
    return self;
}
+(Agenda *)createAgenda:(NSDictionary *) agendaProperties{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    Agenda *agenda = [[Agenda alloc] init];
    [agenda setAgendaDate:[dateFormatter dateFromString:[agendaProperties objectForKey:@"agenda_date"]]];
    NSMutableArray *sessionList = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *sessions = [agendaProperties objectForKey:@"agenda_sessions"];
    for(NSDictionary *sessionObject in sessions){
        Session *session = [[Session alloc] init];
        [sessionList addObject:[session createSession:sessionObject]];
    }
    [agenda.sessions addObjectsFromArray:sessionList];

    return agenda;
}


@end
