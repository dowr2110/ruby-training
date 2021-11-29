def check_prostoe(num)
  q = 0
  (2..num - 1).each do |i|
    if (num % i).zero?
      q += 1
    end
  end

  if q.positive?
    0
  else
    1
  end
end

def print_all_prostoe(num)
  sum = 0
  start = Time.now.to_f
  (2..num).each do |i|
    if check_prostoe(i) == 1
      puts i
      sum += 1
    end
  end
  puts "всего найдено #{sum} простых чисел до N"
  endd = Time.now.to_f
  time = endd - start
  puts "всего времени это заняло #{time} миллисекунт"
end

##################################################################################################
puts 'добро пожаловать на программу которая выводит просты числа!'

(1..100).each do |i|
  puts "1) проверить является ли число простым \n2) вывод всех простых чисел до N "
  puts 'выберите пункт :'
  a = gets.to_i
  case a
  when 1
    puts 'введите N:'
    num = gets.to_i
    if check_prostoe(num) == 0
      puts 'это не простое число!'
    elsif check_prostoe(num) == 1
      puts 'это ПРОСТОЕ число!'
    end
  when 2
    puts 'введите N:'
    num = gets.to_i
    puts 'все простые числа до N'
    print_all_prostoe(num)
  end

  puts 'желаете продолжить?(Y-0/N-1)'
  continue = gets.to_i
  if continue == 1
    puts 'до следующец игры! ПОКА!))'
    break
  else
    continue
  end
  puts "погнали еще раз :)\n\n"
end








