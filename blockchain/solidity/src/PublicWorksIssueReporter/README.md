# Public Works Issue Reporter

This is a tool for cities to use that allows citizens to report non-emergency issues that the city should be aware of. This includes potholes, streetsign maintenance, 

In turn, the city can update the status of these reports so that the reporter can find out if the issue has been resolved.

## How this works
Every user of this system will need an Ethereum account. This will provide authentication/authorization for City staff and will provide a mechanism to pay the transaction fees associated with creating a report as well as managing the reports.

All transaction fees go to the Ethereum network nodes for processing the reports. There is no requirement at this time that citizens should compensate the city for making reports or for the city to reward citizens for reporting important issues. 

There are three types of users in this system:
 - The Primary City Account. This account is the one that registers the city in this sytem. They have the ability to:
 -- Identify accounts that are used by the city to update status of reported issues
 -- Cancel the city's use of the system. (Though because this is blockchain, previously-created entries and their last status will remain)
 - The City's 'daily-use' accounts. This account is used to update the status of reported issues.
 - Citizen's accounts. Individual citizens can create reports of non-emergency issues for the city to investigate and address.
 
 ## Getting Started
 *Create Accounts*
 You'll need at least two accounts. One as the Primary City Account and one to be able to update issue status. Larger cities will need more. The initial limit is 10 accounts per city.
 
 *Identify Custom Categories*
 There are pre-defined categories, but each city can have their own unique needs. Up to 20 additional categories can be defined. 
 
 Pre-defined categories
  - Pothole
  - Streetsign Issue
  - Public Nuisance (code violations, disturbances, etc.)
  - Street Lights
  - Water Leak
  - Graffiti
  - Sidewalks (being blocked, damaged, etc.)
  - Trash
  - City Park (garbage, landscape maintenance, facility maintenance, etc.)
  - Animal Control (stray animal, dead animal, etc.)
  - Streets and Crosswalks
  - Traffic Lights
  - Tree Trimming
  - Snow Clearing
  - Parking (Abandon Vehicle, Parking Violation, etc.)
  
*Rollout*
  There will be a basic UI provided to perform all the actions of this system. If you are interested in re-branding, embedding on your official site, or creating a mobile app, you are free to do so. 

## Managing reports
You will likely have other systems that track details of work being done, so the management of issues in this system will be very simple. You will be able to set the status for each item using any of the pre-defined statuses. There are no rules on which statuses must be used and in what order. 

Statuses
 - Reported (Default value for new reports)
 - Investigating
 - Unable to confirm issue
 - Addressed
 - Partially Addressed
 - Will Not Address
 - Call for more info
 - Cancelled by reporter

## Citizen Reporting
Anyone can create a report. There are no restrictions, though there will be the transaction fees associated with making the report.

The modifiable fields allowed for reports are the following
 - Category
 - Latitude / Longitude coordinates for the report
 - Optional Call-back number
 
 Additional information associated with the report include:
 - The account of the person making the report
 - The date/time of the report
 - A report ID will be generated
  
# Technical Details

## Design Decisions
Some of the design decisions were based on limiting some of the negative impacts of publicly-available systems.
 - It should be more expensive to create a report than it is to mark it as a completed item. If someone decides to spend hundreds or thousands of dollars creating reports, it should be much less expensive to clean them up.
  - Free-form text set by anonymous users in a public setting is a recipe for a bad time. By not providing any mechanism for free-form text, we limit potentially embarrassing, vulgar or abusive content. 
  - With the inclusion of free-form numeric values, there is the potential of someone encoding a message within those values or abuse that in some way. This will be considered a known potential issue and less potential downside and more value provided to the system by including them.
  - The min/max latitude/longitude values are a simple way to limit the area for reports. It simplifies the storage requirements, while leaving some room for error in reporting.
 

## Exposed Methods

 *Register a city*
 You'll provide:
 -- An encrypted message consisting of the name of your city's website using the SSL key for your city's website so that the users can validate they are going to a legitimate reporting site.
 -- the name of your city's website
 -- the main contact phone number for issues reported
 -- min/max latitude and longitude values. These are used to limit reports to the general vicinity of your town.
 
 *Update encrypted message*
 When your ssl certificate expires, you'll want to update the encrypted message so that users can validate that you have a legitimate claim to set up this system. Only the primary account can make this change
 
 *Update phone number*
 It may be a simple extension change or it could be a full area-code change. Only the primary account can make this change
 
 *Update status*
 Any of the daily-use accounts can update the status of any of the reported items. You'll have to provide:
  - The report ID
  - The new status
  
 *Add Custom Category*
 There will be up to 20 custom categories that you can add. You will be limited to 30 characters for the description. Using custom categories will cost more to process (both for the city and the citizens) since they will use the full name instead of an ID fo pre-defined categories.
 
 *Remove Custom Category*
 This will not remove the category for reported items, only make it unavailable for users to use when creating new reports

 *Show Reports For Account*
 Given a specific account, all reference numbers for reports created by that account will be listed. This can only be called by daily-use city accounts
  
  *Create Report*
Anyone can create a report. Here are the fields
 - latitude and longitude values for where the issue occurs (required)
 - category id/name (required)
 - callback number (optional)
 
 *Get My Reports*
 Ethereum won't return a report id in the same call that creates the id, so we'll need a mechanism to show what reports a user has submitted.
 
 *Get Report Status*
 Required input:
 - report reference number
 Output:
 - current status id/name
 
 *Cancel Report*
 Only the reporter of the issue can cancel a report
  Required input:
 - report reference number