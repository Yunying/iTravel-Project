//
//  Constants.h
//  iTravel
//
//  Created by YUNYING TU on 12/2/15.
//  Copyright © 2015 Yunying Tu. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//Segue Identifiers
static NSString* const kAddTripSegue = @"AddTrip";
static NSString* const kSaveTripSegue = @"SaveTrip";
static NSString* const kTripDetailSegue = @"TripDetail";
static NSString* const kTripDayDetailSegue = @"TripDayDetail";
static NSString* const kAddNewHotelSegue = @"AddNewHotel";
static NSString* const kAddNewSightSegue = @"AddNewSight";
static NSString* const kShowImageSegue = @"ShowImages";

//Class Names
static NSString* const kTripClass = @"Trip";
static NSString* const kTripDayClass = @"TripDay";
static NSString* const kSightClass = @"Sight";
static NSString* const kImageClass = @"TripImage";

//Travel
static NSString* const kTripName = @"Name";
static NSString* const kTripStartDate = @"StartDate";
static NSString* const kTripEndDate = @"EndDate";
static NSString* const kTripBudget = @"Budget";

//Flight
static NSString* const kFlightDeparture = @"DepartTime"; //DateTime
static NSString* const kFlightArrival = @"ArrivalTime"; //DateTime
static NSString* const kFlightName = @"Flight";

//Hotel
static NSString* const kHotelName = @"HotelName";
static NSString* const kHotelAddress = @"HotelAddress";
static NSString* const kHotelEmail = @"HotelEmail";
static NSString* const kHotelPhone = @"HotelPhone";

//Trip Day
static NSString* const kDate = @"Date";
static NSString* const kRelatedTrip = @"parent";
static NSString* const kTripDayCost = @"Cost";
static NSString* const kTripDaySummary = @"Summary";
static NSString* const kTripDayImageCount = @"ImageCount";

//Sight
static NSString* const kSightName = @"SightName";
static NSString* const kSightTransport = @"Transportation";
static NSString* const kSightAddress = @"SightAddress";
static NSString* const kSightParent = @"parent";

//Image
static NSString* const kImageFile = @"ImageFile";
static NSString* const kImageParent = @"parent";

//Utility
static NSInteger const kGenerateDaysThreshold = 20;


#endif /* Constants_h */
