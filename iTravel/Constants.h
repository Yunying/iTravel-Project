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

//Class Names
static NSString* const kTripClass = @"Trip";
static NSString* const kTripDayClass = @"TripDay";
static NSString* const kSightClass = @"Sight";

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
static NSString* const kHotelNote = @"HotelNote";

//Trip Day
static NSString* const kDate = @"Date";
static NSString* const kRelatedTrip = @"parent";
static NSString* const kTripDayCost = @"Cost";
static NSString* const kTripDaySummary = @"Summary";

//Sight
static NSString* const kSightName = @"SightName";
static NSString* const kSightTransport = @"Transportation";
static NSString* const kSightNote = @"SightNote";

//Utility
static NSInteger const kGenerateDaysThreshold = 10;


#endif /* Constants_h */
