require 'openssl'
require 'colorize'

key = ARGV[0]
iv = ARGV[1]
name = ARGV[2]

in_file = File.path(name + ".txt")
input_data = IO.readlines(in_file)

data = input_data[1]

cipher = OpenSSL::Chipher.new('AES-256-CBC')
cipher.encrypt
encrypted = cipher.update(data)

out_file = File.path(name + "-encrypted.txt")
File.open(filename, "w") do |x|
  p input_data[0]
  p
end
