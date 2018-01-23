require 'gmail'
require 'google_drive'

def send_emails()
###########################
#get access to spreadsheet#
###########################

session = GoogleDrive::Session.from_config("config.json")
w = session.spreadsheet_by_key($spreadsheet_key).worksheets[0]

#######
#email#
#######

#gmail authentification
error = 0
while error != 1
  puts "Please enter your login credentials again." if error == 2
 
  puts "Gmail username (or email):"
  login = gets.chomp
  puts "Gmail password for '#{login}':"
  pw = gets.chomp
  gmail = Gmail.connect(login, pw)

#test if connection was successful?
  if gmail.logged_in? == true
    puts "Successfully logged in to Gmail servers!" 
    error = 1
  else
    puts "It seems like something went wrong during authentification"
    sleep(2.5)
  end
end

#send email to each database email
y = 2
until (w[y, 1] == '' && w[y, 2] == '') #Tant que la case du spreadsheet est remplie
  gmail.deliver do
    content_type 'text/plain; charset=UTF-8'
    to w[y, 2] #à 'email'
    subject "IMPORTANT - The HACKING Project"
    html_part do
      body "<p>Aujourd'hui, faire du code devient aussi important que le passer. Pour se mouvoir
            avec aisance sur les autoroutes de l'information, une formation gratuite et ouverte à tous a
            été lancée il y a six mois.
            Cette formation s'appelle The Hacking Project (http://thehackingproject.org/) et repose
            sur le peer-learning : chaque jour, les élèves répartis en petites équipes autonomes
            travaillent sur de nouveaux projets concrets (réaliser une copie du site de Google en html,
            piloter un compte Twitter à distance, ...).
            Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident
            à faire de The Hacking Project un nouveau format d'éducation gratuite.</p>

            <p>Nous vous contactons pour vous parler du projet,
            et vous dire que vous pouvez ouvrir une cellule à #{w[y, 1]},
            où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes,
            ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite
            en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves),
            donc nous serions ravis de travailler en partenariat avec votre commune, #{w[y, 1]} !</p>

            <p><strong>Charles</strong>, co-fondateur de <i>The Hacking Project</i>
            pourra répondre à toutes vos questions : 06.95.46.60.80</p>"
    end
  end
puts "Email sent to #{w[y, 2]}" #CLI feedback
y += 1
end

#disconnect
gmail.logout

end
