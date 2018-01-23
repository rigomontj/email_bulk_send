require_relative "export_to_spreadsheet.rb"
require_relative "send_emails.rb"

puts "Enter your spreadsheet key :"
$spreadsheet_key = gets.chomp
export()
send_emails()
