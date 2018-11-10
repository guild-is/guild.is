require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'pdfkit'
require 'erb'

SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

PDFKit.configure do |config|
  #config.default_options = {:javascript_delay => 5000}
  config.wkhtmltopdf = `which wkhtmltopdf`.chomp
  config.verbose = true
end

service = Google::Apis::SheetsV4::SheetsService.new
service.client_options.application_name = 'Guild CV Builder'
service.authorization = Google::Auth.get_application_default(SCOPE)

# spreadsheet_id for "Guild Track Record" sheet
spreadsheet_id = '15j1gEDL3bEoQeY7R49JwX1ZtSD-xqy2QdVsDjo5JEz0'
range = 'Guild Track Record!A2:E'
response = service.get_spreadsheet_values(spreadsheet_id, range)

records_by_category = response.values.group_by { |record| record[3] }

template = File.read('./cv.html.erb')
erb = ERB.new(template)
html = erb.result(binding)

# kit = PDFKit.new(html, :page_size => 'A4', 'dpi' => 300)
# kit.stylesheets << 'style.css'

# PDFKIT_OUTFILE = ENV['PDFKIT_OUTFILE'] || raise('no $PDFKIT_OUTFILE provided')

# file = kit.to_file(PDFKIT_OUTFILE)

File.open("cv.html", 'w') do |f|
  f.write(html)
end


