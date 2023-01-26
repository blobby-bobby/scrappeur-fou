require 'nokogiri' 
require 'open-uri'

def open_nokigiri # appelle la page des cryptos
  Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))   
end

def fusiontab(tab1,tab2) # compile les données dans un Hash
  return Hash[tab1.zip(tab2)]
end

def crypto(page)
  array_name = Array.new
  array_price = Array.new
  array_sortie = Array.new

  page.xpath('//tr//td[3]/div').each {|name_crypto| array_name.push(name_crypto.text)} # extraction des devises

  page.xpath('//tr//td[5]/div/a/span').each {|price_crypto| array_price.push(price_crypto.text)} # extraction des valeurs
  array_price.map! {|s| s.gsub(/[^\d\.]/, '').to_f} # on enlève les dollars

  hash_sortie = Hash[array_name.zip(array_price)]

  hash_sortie.each do |key, value|
    little_hash = Hash.new
    little_hash.store(key,value)
    array_sortie.push(little_hash)
  end

  return array_sortie

end

def perform
  page = open_nokigiri
  array_crypto = crypto(page)
  puts array_crypto
end

perform