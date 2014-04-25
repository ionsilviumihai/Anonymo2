
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface httpRequests: NSObject

/*

+(void)loginWithFacebookID:(NSString*)facebookID
                 firstName:(NSString*)firstName
                  lastName:(NSString*)lastName
                   success:(void (^)(NSDictionary*))successHandler
                     error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;


+(void)getUserLeaderboarsWithSuccess:(void (^)(NSDictionary*))successHandler
                               error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getRestaurantWithCityId:(NSString*)orasID
              lastRestaurantID:(NSString*)ID
                       success:(void (^)(NSDictionary*))successHandler
                         error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getCitiesWithSuccess:(void (^)(NSArray*))successHandler
                      error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;

+(void)getOneRestaurantWithID:(NSString*)restaurantID
                    andUserID:(NSString*)userID
                      success:(void (^)(NSDictionary*))successHandler
                        error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;
+(void)getDetaliiVin:(NSString*) vinID
             success:(void (^)(NSDictionary*))successHandler
               error:(void (^)(AFHTTPRequestOperation*, NSError*)) errorHandler;
*/

//POST creare user nou
+(void) createUserWithUsername:(NSString*)Username
                      password:(NSString*)password
                         email:(NSString*) emailAddress
                       success:(void (^)(id data))successHandler
                         error:(void (^)(AFHTTPRequestOperation* operation, NSError* error)) errorHandler;
//GET toti userii
+(void) getAllUserssuccess:(void (^)(id data))successHandler
                     error:(void (^)(AFHTTPRequestOperation* operation, NSError* error)) errorHandler;
//POST creare mesaj nou
+(void)createMessageWithUserID:(NSString*)UserID
                   messageText:(NSString *)messageText
                      latitude:(NSString *)latitude
                     longitude:(NSString*)longitude
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;

//GET ia toate mesajele
+(void)getAllMessagessuccess:(void (^)(id data))successHandler
                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;
//POST creaza event
+(void)createEventWithUserID:(NSString*)UserID
                        date:(NSNumber*)date
                 description:(NSString*)descriptions
                    latitude:(NSString *)latitude
                   longitude:(NSString *)longitude
                     success:(void (^)(id))successHandler
                       error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;
//Get ia toate evenimentele
+(void)getAllEventssuccess:(void (^)(id data))successHandler
                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;
//GET ia numarul de participanti la eveniment
+(void)getNumberOfParticipantsForEventWithEventID:(NSString *)EventID
                                     success:(void (^)(id data))successHandler
                                       error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;
//GET ia evenimentele pentru un user
+(void)getEventsforUserWithUserId:(NSString *)UserID
                           sucess:(void (^)(id data))successHandler
                            error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;
//DELETE sterge un user din tabelel user_event
+(void)deleteUserJoinedEventWithRegisterId:(NSString *)userEventID
                                    sucess:(void (^)(id data))successHandler
                                     error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;

//POST creare comment nou
+(void)createCommentWithUserID:(NSString*)UserID
                     messageID:(NSString*)messageID
                   commentText:(NSString *)commentText
                          date:(NSNumber *)date
                       success:(void (^)(id))successHandler
                         error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;

//PUT modificare
+(void)updateUserwithUserID:(NSString* )UserID
                   Username:(NSString *)username
                   password:(NSString *)password
                      email:(NSString *)emailAddress
                    success:(void (^)(id))successHandler
                      error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;
//POST un user da join la un eveniment
+(void)createUserEventWithUserID:(NSString*)UserID
                         eventID:(NSString*)EventID
                         success:(void (^)(id))successHandler
                           error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler;

//GET ia voturile la mesaj
+(void)getVotesForMessageID:(NSString *)MessageID
                    success:(void (^)(id))successHandler
                      error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler;

//POST user da like/dislike la mesaj
+(void)userGiveReviewToMessageID:(NSString*)MessageID
                          UserID:(NSNumber*)UserID
                           value:(NSString*)value
                         success:(void (^)(id))successHandler
                           error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;

//Get Get all comments of message x
+(void)getCommentsForMessageID:(NSString *)MessageID
                       success:(void (^)(id data))successHandler
                         error:(void (^)(AFHTTPRequestOperation * operation, NSError *error))errorHandler;


//Get ia toate voturile
+(void)getVotessuccess:(void (^)(id))successHandler
                 error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler;

+(void)getUserWithID:(NSString *)UserID
             success:(void (^)(id data))successHandler
               error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler;
;

//Post Pune poza la un mesaj
+(void)storePhotoForMessageID:(NSString*)MessageID
                        photo:(NSString*)photo
                      success:(void (^)(id data))successHandler
                        error:(void (^)(AFHTTPRequestOperation *, NSError *))errorHandler;
//Get ia imaginea pentru mesajul x
+(void)getPhotoforMessageID:(NSString *)messageID
                   ssuccess:(void (^)(id))successHandler
                      error:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorHandler;




@end
