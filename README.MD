**Weblog Parser**

The purpose of this script it to accept a log file containing web uris with ip addresses and to parse them allowing the user to see the total number of views per page as well as the unique number of views per page.

The script can be run in 3 ways.

`ruby parser.rb weblog.log`

This will print out both the view count and unique view count.

`ruby parser.rb weblog.log count`

This will print out only the view count.

`ruby parser.rb weblog.log unique`

This will print out only the unique view count.