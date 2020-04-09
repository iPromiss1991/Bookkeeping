
//
//  QuysLoginApi.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/31.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginApi.h"
#import "QuysLoginModel.h"
@implementation QuysLoginApi
- (NSString *)requestUrl
{
    return nil;//TODO
}

- (NSString *)baseUrl
{
    return nil;//TODO

}

- (id)requestArgument
{
    
    return nil;//TODO
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}


- (id)responseJSONObject
{
    QuysLoginModel *model = [QuysLoginModel yy_modelWithJSON:[super responseJSONObject]];
    return model;
}
@end
