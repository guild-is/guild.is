require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'pdfkit'
require 'erb'

SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY

PDFKit.configure do |config|
  config.default_options[:load_error_handling] = 'ignore'
  config.wkhtmltopdf = `which wkhtmltopdf`.chomp
  config.verbose = true
  config.threadsafe!
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

kit = PDFKit.new(html, :page_size => 'Letter')
kit.stylesheets << 'style.css'

PDFKIT_OUTFILE = ENV['PDFKIT_OUTFILE'] || raise('no $PDFKIT_OUTFILE provided')

file = kit.to_file(PDFKIT_OUTFILE)
