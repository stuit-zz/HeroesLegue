//
//  HLGlobals.h
//  Heroes League
//
//  Created by Ilkhom Khodjaev on 7/3/16.
//  Copyright © 2016 HL. All rights reserved.
//

#ifndef HLGlobals_h
#define HLGlobals_h

// Config
#define DOCUMENT_DIRECTORY                          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define DATA_BASE_NAME                              @"hl_db"
#define DATA_BASE_PATH                              [DOCUMENT_DIRECTORY stringByAppendingPathComponent:DATA_BASE_NAME]

#define MARVEL_PUBLIC_KEY                           @"6df6652489c79e8b21ff94be9a9d7dac"
#define MARVEL_PRIVATE_KEY                          @"c511976e8cbf4fe69c7cc365818a8a45267b81a3"

#define SERVER_URL                                  @"http://gateway.marvel.com/"
#define API_PATHERN                                 @"v1/public/"

// Metrics
#define MAIN_SCREEN_RECT                            [[UIScreen mainScreen] bounds]
#define MAIN_SCREEN_WIDTH                           MAIN_SCREEN_RECT.size.width
#define MAIN_SCREEN_HEIGHT                          MAIN_SCREEN_RECT.size.height

// Fields
#define REQUEST_FIELD                               @"request_field"
#define CHARACTER_ID_FIELD                          @"character_id_field"

// Methods
#define REQUEST_METHOD_GET_CHARACTERS               @"characters"
#define REQUEST_METHOD_GET_CHARACTER_COMICS         @"characters/%lu/comics"
#define REQUEST_METHOD_GET_CHARACTER_EVENTS         @"characters/%lu/events"
#define REQUEST_METHOD_GET_CHARACTER_SERIES         @"characters/%lu/series"
#define REQUEST_METHOD_GET_CHARACTER_STORIES        @"characters/%lu/stories"

// Path patterns
#define REQUEST_FIELD_GET_CHARACTERS                @"characters"
#define REQUEST_FIELD_GET_CHARACTER_COMICS          @"characters/:serverID/comics"
#define REQUEST_FIELD_GET_CHARACTER_EVENTS          @"characters/:serverID/events"
#define REQUEST_FIELD_GET_CHARACTER_SERIES          @"characters/:serverID/series"
#define REQUEST_FIELD_GET_CHARACTER_STORIES         @"characters/:serverID/stories"


//******************** Segue Identifiers ********************
static NSString *const kCharacterDetailsSegue     = @"CharacterDetailsSegue";


#endif /* HLGlobals_h */
