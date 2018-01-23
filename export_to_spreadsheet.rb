require "google_drive"
require_relative "mairies.rb"

def export()
session = GoogleDrive::Session.from_config("config.json")

w = session.spreadsheet_by_key($spreadsheet_key).worksheets[0]

y = 2
get_info.each do |city, email|
w[y, 1] = city
w[y, 2] = email
y += 1
end

w.save
end
