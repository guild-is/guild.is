# Guild CV Builder

## Build

Authorization comes from a [Google Service Account](https://console.cloud.google.com/iam-admin/serviceaccounts), which allows communication with the Google Sheets API. Once created, select the "create key" action, and store the file in `guild-cv/client_secret.json`

The html template is stored in: `cv.html.erb`, and styling is managed in `style.css`

`bundle install`
`bundle exec ruby build.rb`
