

#import "httpRequests.h"
#import "AFHTTPClient.h"


@implementation httpRequests


//private methods

NSString *serverUrl = @"http://89.45.249.251/Anonimo"; //base url
//NSString *serverUrl = @"http://10.11.194.230:8080/Anonimo"; //base url
+(void)sendPostRequest:(NSString *)relativeUrl
                  data:(NSDictionary *)dict
               success:(void (^)(id))successHandler
                 error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler
{
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
  
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:relativeUrl
                                                      parameters:dict];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^internalSuccessHandler)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation* operation, id responseObject) {
        
        NSError *error;
        NSLog(@"%@: %@", relativeUrl, [operation responseString]);
        NSData *data = [[operation responseString] dataUsingEncoding:NSUTF8StringEncoding];
        if(data)
        {
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        successHandler(responseObj);
        }
        else
        {
            NSLog(@"///////%d", [(NSHTTPURLResponse*)responseObject statusCode]);
            successHandler(nil);

            
        }
    };
    
    [operation setCompletionBlockWithSuccess:internalSuccessHandler failure:errorHandler];
    
    [operation start];
}

/*
+(void)sendPutRequest:(NSString *)relativeUrl
                  data:(NSDictionary *)data
               success:(void (^)(id))successHandler
                 error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler
{
    
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT" path:relativeUrl parameters:data];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^internalSuccessHandler)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation* operation, id responseObject) {
        NSError *error;
        //NSLog(@"%@", [operation responseString]);
        NSData *data = [[operation responseString] dataUsingEncoding:NSUTF8StringEncoding];
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        successHandler(responseObj);
    };
    
    [operation setCompletionBlockWithSuccess:internalSuccessHandler failure:errorHandler];
    
    [operation start];
}
 */
+(void)sendPutRequest:(NSString *)relativeUrl
                 data:(NSDictionary *)data
              success:(void (^)(id))successHandler
                error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler
{
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];

    NSMutableURLRequest *request = [httpClient requestWithMethod:@"PUT"
                                                            path:relativeUrl
                                                      //parameters:data];
                                                      parameters:@{@"name":@"name",
                                    @"password":@"password",
                                    @"email":@"email"}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)responseObject;
        //int code = [httpResponse statusCode];
        //NSLog(@"Response code: %d", code);
        NSLog(@"Response code:%ld", (long)operation.response.statusCode);
        //NSLog(@"Response %@:", operation.responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    //[operation start];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}  

+(void)sendGetRequest:(NSString*)relativeUrl
                 data:(NSDictionary *)data
              success:(void (^)(id))successHandler
                error:(void (^)(AFHTTPRequestOperation*, NSError*))errorHandler
{
    
    NSURL *url = [NSURL URLWithString:serverUrl];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:relativeUrl parameters:data];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    void (^internalSuccessHandler)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation* operation, id responseObject) {
        NSError *error;
        //NSLog(@"%@", [operation responseString]);
        NSData *data = [[operation responseString] dataUsingEncoding:NSUTF8StringEncoding];
        id responseObj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        successHandler(responseObj);
    };
    
    [operation setCompletionBlockWithSuccess:internalSuccessHandler failure:errorHandler];
    
    [operation start];

}
/*
//pana aici nu modific :D
//public methods
+(void)loginWithFacebookID:(NSString *)facebookID  //trikmite la server id fn si ln 
                 firstName:(NSString *)firstName
                  lastName:(NSString *)lastName
                   success:(void (^)(NSDictionary *))successHandler 
                     error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    ///folosesc post daca fac modificari pe server
    [self sendPostRequest:@"fblogin" //concatenare la base url / se cheama URI
                       data:[NSDictionary dictionaryWithObjectsAndKeys:
                             facebookID, @"facebook_id", //nume parametrii de pe server
                             firstName,@"prenume",
                             lastName,@"nume",
                             nil]
                    success:^(NSDictionary *data) //data primeste de pe server
     {
         successHandler(data);
     }
     
     error:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}

+(void)getUserLeaderboarsWithSuccess:(void (^)(NSDictionary *))successHandler
                               error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    [self sendGetRequest:@"getusertop"
                    data:nil
                 success:^(NSDictionary *data)
                    {
                        successHandler(data);
                    }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                        errorHandler(operation,error);
                    }];
}

+(void)getRestaurantWithCityId:(NSString *)orasID
              lastRestaurantID:(NSString *)ID
                       success:(void (^)(NSDictionary *))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    if (ID)
    {
        [data setValue:ID forKey:@"lastId"];
    }
    
    [data setValue:orasID forKey:@"idOras"];
    [data setValue:@"10"
            forKey:@"nrRestaurant"];

    
    [self sendPostRequest:@"getRestaurant"
                     data:data
                 success:^(NSDictionary *data)
                    {
                     successHandler(data);
                    }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
                    {
                       errorHandler(operation,error);

                   }];
}

+(void)getCitiesWithSuccess:(void (^)(NSArray*))successHandler
                      error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    [self sendGetRequest:@"getorase"
                    data:nil
                 success:^(NSArray *data)
     {
         successHandler(data);
     }
                   error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
     }];
    
}

+(void)getOneRestaurantWithID:(NSString *)restaurantID
                    andUserID:(NSString *)userID
                      success:(void (^)(NSDictionary *))successHandler
                        error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    [data setValue:restaurantID forKey:@"restaurant_id"];
    [data setValue:userID forKey:@"user_id"];
    
    
    [self sendPostRequest:@"getOneRestaurant"
                     data:data
                  success:^(NSDictionary *data)
     {
         successHandler(data);
     }
                    error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
         
     }];
    
    
}

+(void)getDetaliiVin:(NSString *)vinID
             success:(void (^)(NSDictionary *))successHandler
               error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    
    [data setValue:vinID forKey:@"id"];
    [data setValue:@"2" forKey:@"restaurant_id"];

    
    
    [self sendPostRequest:@"getDetaliiVin"
                     data:data
                  success:^(NSDictionary *data) 
     {
         successHandler(data);
     }
                    error:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         errorHandler(operation,error);
         
     }];

}
*/

//POST creare user
+(void)createUserWithUsername:(NSString *)Username
                     password:(NSString *)password
                        email:(NSString *)emailAddress
                      success:(void (^)(id))successHandler
                        error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary *dataDict=[[NSMutableDictionary alloc]init];
    
    [dataDict setValue:Username forKey:@"name"];
    [dataDict setValue:password forKey:@"password"];
    [dataDict setValue:emailAddress forKey:@"email"];
    
    
    [self sendPostRequest:@"users" //concatenare la base url / se cheama URI
                     data:dataDict
                  success:^(NSDictionary *data) //data primeste de pe server
     {
         successHandler(data);
     }
     
                    error:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
}

//POST creare mesaj
+(void)createMessageWithUserID:(NSString*)UserID
                   messageText:(NSString *)messageText
                      latitude:(NSString *)latitude
                     longitude:(NSString *)longitude
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    [dataDict setValue:date forKey:@"date"];
    [dataDict setValue:latitude forKey:@"latitude"];
    [dataDict setValue:longitude forKey:@"longitude"];
    [dataDict setValue:messageText forKey:@"text"];
    [dataDict setValue:UserID forKey:@"userId"];
    
    [self sendPostRequest:@"messages"
                     data:dataDict
                  success:^(NSDictionary *data)
    {
        successHandler(data);
    }
                    error:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
}

//POST creare comment
+(void)createCommentWithUserID:(NSString*)UserID
                     messageID:(NSString*)messageID
                   commentText:(NSString *)commentText
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc]init];
    [dataDict setValue:date forKey:@"date"];
    [dataDict setValue:commentText forKey:@"text"];
    [dataDict setValue:UserID forKey:@"userId"];
    [dataDict setValue:messageID forKey:@"messageId"];
    
    [self sendPostRequest:@"comments"
                     data:dataDict
                  success:^(NSDictionary *data)
     {
         successHandler(data);
     }
                    error:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
}
//GET ia toti userii
+(void)getAllUserssuccess:(void (^)(id data))successHandler
                    error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler
{
    [self sendGetRequest:@"users" data:nil success:^(id data) {
        successHandler(data);
        
    } error:^(AFHTTPRequestOperation * operation, NSError *error) {
        
    }];
}

//GET ia toate mesajele
+(void)getAllMessagessuccess:(void (^)(id data))successHandler
                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler
{
    [self sendGetRequest:@"messages" data:nil success:^(id data) {
        successHandler(data);
        
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//GET ia userul cu id x
+(void)getUserWithID:(NSString *)UserID
             success:(void (^)(id))successHandler
               error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler
{
    [self sendGetRequest:[NSString stringWithFormat:@"users/%@",UserID] data:nil success:^(id data) {
        successHandler(data);
    }
                   error:^(AFHTTPRequestOperation *operation, NSError *error) {
                       errorHandler(operation, error);
                   }];
}



//PUT UPDATE USER
+(void)updateUserwithUserID:(NSString* )UserID
                   Username:(NSString *)username
                   password:(NSString *)password
                      email:(NSString *)emailAddress
                    success:(void (^)(id data))successHandler
                      error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setValue:username forKey:@"name"];
    [dataDict setValue:password forKey:@"password"];
    [dataDict setValue:emailAddress forKey:@"email"];
    
    [self sendPutRequest:[NSString stringWithFormat:@"users/%@", UserID]
                    data:dataDict
                 success:^(NSDictionary *data)
     {
         successHandler(data);
     }
                   error:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
}


@end
