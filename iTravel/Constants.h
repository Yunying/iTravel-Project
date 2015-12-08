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
static NSString* const kEditSingleItemSegue = @"EditSingleItem";
static NSString* const kCostDetailSegue = @"CostDetail";
static NSString* const kMapViewSegue = @"ShowMapView";
static NSString* const kSharedTripSegue = @"SharedTripDetail";
static NSString* const kLoginSegue = @"Login";

//Class Names
static NSString* const kTripClass = @"Trip";
static NSString* const kTripDayClass = @"TripDay";
static NSString* const kSightClass = @"Sight";
static NSString* const kImageClass = @"TripImage";
static NSString* const kUserClass = @"User";
static NSString* const kThingClass = @"Thing";

//Travel
static NSString* const kTripName = @"Name";
static NSString* const kTripStartDate = @"StartDate";
static NSString* const kTripEndDate = @"EndDate";
static NSString* const kTripBudget = @"Budget";
static NSString* const kImageLocations = @"ImageLocation";
static NSString* const kTripParent = @"parent";

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
static NSString* const kTripDayHotelCost = @"HotelCost";
static NSString* const kTripDaySightCost = @"SightCost";
static NSString* const kTripDayOtherCost = @"OtherCost";

//Sight
static NSString* const kSightName = @"SightName";
static NSString* const kSightTransport = @"Transportation";
static NSString* const kSightAddress = @"SightAddress";
static NSString* const kSightParent = @"parent";
static NSString* const kSightCost = @"SightCost";

//Image
static NSString* const kImageFile = @"ImageFile";
static NSString* const kImageParent = @"parent";

//User
static NSString* const kUsername = @"Username";
static NSString* const kPassword = @"Password";

//Thing
static NSString* const kThingItem = @"ItemName";
static NSString* const kThingAmount = @"ItemAmount";
static NSString* const kThingParent = @"ItemParent";


//Utility
static NSInteger const kGenerateDaysThreshold = 20;


#endif /* Constants_h */
