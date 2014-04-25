//
//  Annotation.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

-(NSString*) title
{
    return self.subiect;
}

-(NSString*) subtitle
{
    return self.coment;
}

-(CLLocationCoordinate2D)coordinate
{
    return self.coordonata;
}

@end
