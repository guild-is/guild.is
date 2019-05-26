# guild.is

WIP website for `guild.is`. Deployed automatically using `netlify`.

The site consists of a static index page available at [public/index.html](public/index.html), and a cv.html that is published via a build script.

## Building cv.html

The only part of the site that is generated via build script is the cv.html file. The build script is located at [./build.rb](build.rb), and pulls data from google spreadsheets.

If you're wanting to test / edit the cv template, make sure you have the following environment variables set for communication with the GoogleSheets API:

```
export GOOGLE_ACCOUNT_TYPE=service_account
export GOOGLE_CLIENT_ID=00000000000000000000000
export GOOGLE_CLIENT_EMAIL=xxxxxxxxx@xxxxxxxxxxxx.com
export GOOGLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n*****************\n-----END PRIVATE KEY-----\n"
```

## Automatic building of cv

In addition to being rebuilt by netlify on every push to github, the cv also has a netlify build-hook in place, so that you can directly trigger a new build from the "Guild Track Record" google spreadsheet. Ask @cory or @hxrts if you can't find the spreadsheet!
