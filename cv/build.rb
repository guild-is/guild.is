require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'erb'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'.freeze
CREDENTIALS_PATH = 'credentials.json'.freeze
TOKEN_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize

  client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

  service = Google::Apis::SheetsV4::SheetsService.new
  service.client_options.application_name = 'Guild CV Builder'
  service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: File.open('client_secret.json'),
    scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY)




# Initialize the API
# service = Google::Apis::SheetsV4::SheetsService.new
# service.client_options.application_name = APPLICATION_NAME
# service.authorization = authorize

# Prints the names and majors of students in a sample spreadsheet:
# https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
spreadsheet_id = '15j1gEDL3bEoQeY7R49JwX1ZtSD-xqy2QdVsDjo5JEz0'
range = 'Guild Track Record!A2:E'
response = service.get_spreadsheet_values(spreadsheet_id, range)

records_by_cat = response.values.group_by { |record| record[3] }

template = File.read('./cv.html.erb')
erb = ERB.new(template)

File.open('index.html', 'w') do |f|
  f.write erb.result(binding)
end
