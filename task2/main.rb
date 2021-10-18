require 'nokogiri'
require 'curb'
require 'csv'
require 'yaml'

class Product
  attr_accessor :name, :price, :image
  def initialize(name, price, image)
    @name = name
    @price = price
    @image = image
  end
  def to_s
    [@name, @price, @image].join(', ')
  end
end

module Parcable
  DOWNLOAD_FROM_YAML_FILE = YAML.load(File.read("params.yaml"))
  VESOVKA = DOWNLOAD_FROM_YAML_FILE['vesovka']
  NAME = DOWNLOAD_FROM_YAML_FILE['name']
  WEIGHT = DOWNLOAD_FROM_YAML_FILE['weight']
  IMAGE = DOWNLOAD_FROM_YAML_FILE['image']
  PRICE = DOWNLOAD_FROM_YAML_FILE['price']
  PRODUCT_CONTAINER = DOWNLOAD_FROM_YAML_FILE['product_container']
  PRODUCT_DESC = DOWNLOAD_FROM_YAML_FILE['product_desc']
  PAGINATION = DOWNLOAD_FROM_YAML_FILE['pagination']

  def get_doc(url)
    convert_to_url = URI.parse(url)
    http = Curl.get(convert_to_url)
    doc = Nokogiri::HTML(http.body)
  end

  def parse_product(url)
    doc = get_doc(url)
    products = []
    doc.xpath(VESOVKA).each do |row|
      product_price = row.search(PRICE).text.strip
      product_image = row.at_xpath(IMAGE).text.strip
      product_full_name = row.at_xpath(NAME).text.strip + "\n" + row.search(WEIGHT).text.strip
      product = Product.new( product_full_name, product_price, product_image)
      products.push( product )
    end
    products
  end

  def save_to_csv(products)
    column_header = [ "Name", "Price", "Image" ]
    CSV.open(@filename,"a+" ,force_quotes:true ) do |file|
      file << column_header if file.count.eql? 0
      products.each do |product|
        file << [ product.name, product.price, product.image ]
        puts product.to_s
      end
    end
  end

  def count_products_in_one_page(doc)
    count_of_products = 0
    doc.xpath(PRODUCT_CONTAINER).each do |row|
      count_of_products += 1
    end
    count_of_products
  end

  def get_and_save_products(doc)
    count_of_products = count_products_in_one_page(doc)
    products = []
    all_urls = doc.xpath(PRODUCT_DESC).first(count_of_products)
    all_urls.each do |url|
      products += parse_product(url.text)
    end
    save_to_csv(products)
  end

  def parse_by_url(count_of_pages, url)
    doc = get_doc(url)
    threads = []
    get_and_save_products(doc) #for first page
    (2..count_of_pages).each do |i| #for another pages
      threads << Thread.new(i) do |urll|
        doc = get_doc(url + "?p=#{i}")
        get_and_save_products(doc)
      end
    end
    threads.each {|thr| thr.join }
  end
end

class Category
  attr_accessor :url , :filename
  def initialize(url, filename)
    @url = url
    @filename = filename
  end
  include Parcable
  def get_all_pages()
    puts "идет запись на файл..."
    doc = get_doc(@url)
    count_of_pages = doc.xpath(PAGINATION).text.to_i
    parse_by_url(count_of_pages, @url)
    puts "записано!!"
  end
end

puts "введите ссылка на страницу категории: "
url = gets.chomp
puts "введите имя файла в который будет записан результат: "
filename = gets
category = Category.new(url , filename)
category.get_all_pages