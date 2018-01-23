require "open-uri"
require "nokogiri"

def to_city_name_format(str)
str = str.split('')
str[0] = str[0].capitalize
 
  for i in 1..(str.length)
    if str[i-1] == "-"
      str[i] = str[i].capitalize
    end
  end

  for k in 1..(str.length)
    if (str[k] == 'L' || str[k] == 'D') && str[k-1] == '-' && str[k+1] == '-' #exception pour "-l'" et "-d'"
      str[k+1] = "'"
      str[k] = str[k].downcase
    end
  end
  return str.join('')
end

def get_info #fonction de scraping
  addresses = []
  db = Hash.new
  i = 0
  j = 0
#prompt de departement
  puts "Veuillez entrer une addresse de page de type 'http://annuaire-des-mairies.com/departement.html' :"
  urldpt = gets.chomp
  doc = Nokogiri::HTML(open(urldpt))
  doc.css('p a.lientxt').each do |children| #importation de toutes les mairies du departement
      addresses[i] =  "http://annuaire-des-mairies.com" + children["href"][1..-1]
      #puts "importing:  " + addresses[i]
      i = i + 1
  end

for j in 0...addresses.length #importation de l'addresse email de chaque mairie
  doc2 = Nokogiri::HTML(open(addresses[j])) 
  doc2.css('tr/td/p/font').each do |children| 
    if /@/ =~ children.text
      #puts "importing:  " + children.text[1..-1] 
      db[to_city_name_format((addresses[j][35..-6]).gsub('/-/', ' '))] = (children.text[1..-1]).downcase
    end 
  end
end 

return db
end
