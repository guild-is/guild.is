require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'erb'

SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

service = Google::Apis::SheetsV4::SheetsService.new
service.client_options.application_name = 'Guild CV Builder'
service.authorization = Google::Auth.get_application_default(SCOPE)

# spreadsheet_id for "Guild Track Record" sheet
spreadsheet_id = '15j1gEDL3bEoQeY7R49JwX1ZtSD-xqy2QdVsDjo5JEz0'
range = 'Guild Track Record!A2:E'
response = service.get_spreadsheet_values(spreadsheet_id, range)

records_by_category = response.values.group_by { |record| record[3] }

template = File.read('views/cv.html.erb')
erb = ERB.new(template)
html = erb.result(binding)

File.open("public/cv.html", 'w') do |f|
  f.write(html)
end
