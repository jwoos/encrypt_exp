require 'openssl'
require 'base64'

name = "test"

in_file = File.path(name)
input_data = IO.readlines(in_file)[1].chomp

cipher = OpenSSL::Cipher.new('AES-256-CBC')
cipher.encrypt

key_file = File.path("key")
iv_file = File.path("iv")
cipher.key = IO.readlines(key_file)[0].chomp
cipher.iv = IO.readlines(iv_file)[0].chomp

encrypted = cipher.update(input_data) + cipher.final

out_file = File.path(name + "-encrypted")
File.open(out_file, "w") do |x|
  x << IO.readlines(in_file)[0]
  x << Base64.encode64(encrypted)
end

puts "Succesfully encrypted".green
