# The BeerHub Data Architecture

This document describe the structure of data  (databases and and their tables, types, views, triggers, etc; media files storage) that used in BeerHub app.

## General information

The BeerHub app uses the relational databases (SQLite) to store core data and translations (external app database), and user data (internal app database).

The internal app database (user database) contains user specific data such as user comments, favorites places and etc. This database is created just like any SQLite database in an Android app and used in read/write mode.

The external database (core database) unpacked during first start (or app update, if needed) to app internal (secure) place (folder) in device file system with all needed media files (such as images, sounds, etc) that stored separately from the database. This database used in read mode, only and represents a trade secret. The unpacking process contains some security checks and if it fail, this database will not be unpacked (for more information about it, please see Security section).

As mentioned above, all media files (such as photos, beers/breweries/places logos and etc) unpacked during first start together with the external database.

## Core Database

The core database includes all data and translations needed to app work. This means that the app cannot work without it. If we cannot unpack this database during first start app (or app update) process (by security reasons, for example), we should notify user about it.

## User Database
*TBD*

## Security
*TBD*
