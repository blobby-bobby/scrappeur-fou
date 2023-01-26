require 'nokogiri' 
require 'open-uri'

def get_townhall_email(townhall_url)
    townhall_mail_hash = Hash.new
    page_mairie = Nokogiri::HTML(URI.open(townhall_url))
    email = page_mairie.xpath('//*[text()[contains(., "@")]]').text
    return email
end

def get_townhall_urls(departement_url)    # 1- Entrée : une URL département / Sortie : la liste de toutes les URL de Mairie en array
    url_hash = Hash.new
    page_departement = Nokogiri::HTML(URI.open(departement_url))
    page_departement.xpath('//a[contains(@href, "95")]').each do |url_ville|
      ville = url_ville.text
      url = "https://www.annuaire-des-mairies.com" + url_ville["href"][1..-1]
      url_hash.store(ville, url)
    end
    return url_hash
end

  
  def perform 
    little_hash = Hash.new
    resultat = Array.new
  
    hash = get_townhall_urls("http://annuaire-des-mairies.com/val-d-oise.html")    # Ressort la liste des mairies avec leur url sous forme de hash
    
    hash.each do |town_name,townhall_url|
      coordonnes_hash = {}
      email_townhall = get_townhall_email(townhall_url)
      # print "Le site internet #{townhall_url} correspond à la ville : #{town_name} et à pour adresse e-mail #{email_townhall}\n"
      coordonnes_hash.store(town_name, email_townhall)
      puts coordonnes_hash
      resultat.push(coordonnes_hash)
    end
    puts resultat
  end
  
  perform