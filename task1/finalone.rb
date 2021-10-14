
require 'nokogiri'
require 'curb'
require 'csv'

puts "введите ссылка на страницу категории: "
url=gets
ur=URI::encode(url)
puts "введите имя файла в который будет записан результат: "
filename=gets
tomassiv(ur,filename)

##########################################################################################################
def tomassiv(urll,filename)
  puts "идет запись на файл..."

  http=Curl.get(urll)
  doc = Nokogiri::HTML(http.body)
  products=[]

  doc.xpath('//*[@class = "attribute_radio_list pundaline-variations"]/*' ).each do |row|
    tempPrice = row.search('span.price_comb').text.strip
    tempVes = row.search('span.radio_label').text.strip
    tempImage=row.at_xpath('//img[@id="bigpic"]/@src').text.strip
    tempName=row.at_xpath('//h1[@class="product_main_name"]').text.strip

    products.push(
      name:tempName,
      ves:tempVes,
      price:tempPrice,
      image:tempImage
    )
  end

  column_header=["name","ves","price","image"]
  CSV.open(filename,"a+" ,force_quotes:true ) do |wr|
      wr<<column_header if wr.count.eql? 0
      products.each do |i|
      wr<<i.values
    end
  end
  puts "записано!!"
end
#############################################################################################################




