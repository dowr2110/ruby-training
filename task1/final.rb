require 'nokogiri'
require 'curb'
require 'csv'
##########################################################################################################
def parsing(url)
  http=Curl.get(url)
  doc = Nokogiri::HTML(http.body)
  products=[]
  doc.xpath('//*[@class = "attribute_radio_list pundaline-variations"]/*' ).each do |row|
    tempPrice = row.search('span.price_comb').text.strip
    tempImage=row.at_xpath('//img[@id="bigpic"]/@src').text.strip
    tempNameAndWeight=row.at_xpath('//h1[@class="product_main_name"]').text.strip + "\n" + row.search('span.radio_label').text.strip
    products.push(
      name:tempNameAndWeight, price:tempPrice, image:tempImage
    )
  end
  return products
end
#############################################################################################################
def recordToCsv(url,filename)
  puts "идет запись на файл..."
  products=parsing(url)
  column_header=["Name","Price","Image"]
  CSV.open(filename,"a+" ,force_quotes:true ) do |wr|
    wr<<column_header if wr.count.eql? 0
    products.each do |i|
      wr<<i.values
    end
  end
  puts "записано!!"
end
#############################################################################################################
puts "введите ссылка на страницу категории: "
url=gets
convertedToUrl=URI::encode(url)
puts "введите имя файла в который будет записан результат: "
filename=gets
recordToCsv(convertedToUrl,filename)


