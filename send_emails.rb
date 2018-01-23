require 'gmail'
require 'google_drive'

###########################
#get access to spreadsheet#
###########################
puts "Please enter the key between 'https://docs.google.com/spreadsheets/d/' and '/edit#gid=0' in your spreadsheet URL:"
spreadsheet_key = gets.chomp

session = GoogleDrive::Session.from_config("config.json")
w = session.spreadsheet_by_key(spreadsheet_key).worksheets[0]

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

#send email to each database email
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
