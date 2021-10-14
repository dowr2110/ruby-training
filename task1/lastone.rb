require 'nokogiri'
require 'curb'
require 'csv'

puts "введите ссылка на страницу категории: "
url=gets.chomp
convertedToUrl=URI.parse(url)
puts "введите имя файла в который будет записан результат: "
$filename=gets
$http=Curl.get(convertedToUrl)
$doc = Nokogiri::HTML($http.body)

def parsing(url)
  convertedToUrl=URI.parse(url)
  http=Curl.get(convertedToUrl)
  doc = Nokogiri::HTML(http.body)
  products=[]
  doc.xpath('//*[@class = "attribute_radio_list pundaline-variations"]/*' ).each do |row|
    itemPrice = row.search('span.price_comb').text.strip
    itemImage=row.at_xpath('//img[@id="bigpic"]/@src').text.strip
    itemNameAndWeight=row.at_xpath('//h1[@class="product_main_name"]').text.strip + "\n" + row.search('span.radio_label').text.strip
    products.push(
      name:itemNameAndWeight, price:itemPrice, image:itemImage
    )
  end
  return products
end

def recordToCsv(products)
  column_header=["Name","Price","Image"]
  CSV.open($filename,"a+" ,force_quotes:true ) do |wr|
    wr<<column_header if wr.count.eql? 0
    products.each do |i|
      wr<<i.values
      puts i.to_s
    end
  end
end

def getAllUrls(countOfAllProducts,url)
  for i in 1..countOfAllProducts
    http=Curl.get(url+"?p=#{i}")
    doc = Nokogiri::HTML(http.body)
    num=0
    doc.xpath('//div[@class = "product-container"]').each do |row|
      num+=1
    end
    products=[]
    allUrls=doc.xpath('//div[@class=\'product-desc display_sd\']/a/@href').first(num)
    allUrls.each do |i|
      products+=parsing(i.text)
    end
    recordToCsv(products)
  end
end

def finalMethod(url)
  puts "идет запись на файл..."
  n=$doc.xpath("//ul[contains(@class, 'pagination')]/li[position() = (last() - 1)]/a/span/text()").text.to_i
  getAllUrls(n,url)
  puts "записано!!"
end

finalMethod(convertedToUrl)



