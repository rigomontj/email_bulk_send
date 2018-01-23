require 'gmail'
require_relative 'mairies.rb'
require "google_drive"

###########################
#get access to spreadsheet#
###########################

session = GoogleDrive::Session.from_config("config.json")
w = session.spreadsheet_by_key("1m4V2dhOK-_cNkMjtwoduDTxEkQEhcvAaARZ7bb3Ak8w").worksheets[0]

#######
#email#
#######

#authentification
puts "Gmail username (or email):"
login = gets.chomp
puts "Gmail password for '#{login}':"
pw = gets.chomp
gmail = Gmail.connect(login, pw)

#test if connection was successful?
puts "*Successfully logged in to Gmail servers!" if gmail.logged_in? == true

#compose + send email to each database email
y = 2
until (w[y, 1] == '' && w[y, 2] == '') #Tant que la case du spreadsheet est remplie
  gmail.deliver do
    to w[y, 2] #à 'email'
    subject "IMPORTANT - The HACKING Project"
    text_part do
      body "https://www.thehackingproject.org"
    end
  end
p "Email sent to #{w[y, 2]}" #CLI feedback
y += 1
end

#disconnect
gmail.logout
