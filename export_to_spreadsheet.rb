require "google_drive"
require_relative "mairies.rb"

session = GoogleDrive::Session.from_config("config.json")

w = session.spreadsheet_by_key("1m4V2dhOK-_cNkMjtwoduDTxEkQEhcvAaARZ7bb3Ak8w").worksheets[0]

y = 2
get_info.each do |city, email|
w[y, 1] = city
w[y, 2] = email
y += 1
end

w.save
