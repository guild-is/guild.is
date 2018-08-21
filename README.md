# guild.is
WIP website for `guild.is` using `jekyll`. Deployed automatically using `netlify`.

## Temporary URL
[https://sad-cray-c888dd.netlify.com/](https://sad-cray-c888dd.netlify.com/)


## Building cv.pdf

The cv.pdf file gets built by running `./build_cv.sh` which creates the cv in ./cv.pdf

Make sure you have the following environment variables set for communication with the GoogleSheets API:

```
export GOOGLE_ACCOUNT_TYPE=service_account
export GOOGLE_CLIENT_ID=00000000000000000000000
export GOOGLE_CLIENT_EMAIL=xxxxxxxxx@xxxxxxxxxxxx.com
export GOOGLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n*****************\n-----END PRIVATE KEY-----\n"
```

The html template is stored in: `cv/cv.html.erb`, and styling is managed in `cv/style.css`
