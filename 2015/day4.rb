require "digest"


def convert_md5(input)
  lowest_number = 0
  loop do
    hash = Digest::MD5.hexdigest("#{input}#{lowest_number}")
    puts hash
    break if hash.start_with?("000000") 
    lowest_number += 1
  end
  puts lowest_number
end

input = "bgvyzdsv"
convert_md5(input)

p 