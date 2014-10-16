---
layout: post
category : lessons
title: "Geocoding Using Google's API"
tagline: "easy and fun" 
tags : [software, APIs]
---
{% include JB/setup %}

##What is Geocoding

Geocoding is the process of turning semi structured data (addresses, gps coordinates, street names, organization names) into GPS coordinates that can be placed on the map. Google has an [API](https://developers.google.com/maps/documentation/geocoding/) that does this very well.

##What's the catch?

Google only allows 2500 queries per day...bummer. Luckily we could spread these out into a bunch of Amazon or IPlant instances and make this little problem go away. I've written a [script](https://github.com/joshuaar/GeoCode) to make this happen. You can put it into a CRON job on a bunch of different computers and Google won't know the difference. With the ease of getting virtual instances these days, you should be able to geocode whatever you want with Google's excellent service (this may be abuse).

It is well documented for anyone interested in a simple use of Google's GeoCoding API.

Stay tuned for an actual application of this technique to map Github users by language use.
