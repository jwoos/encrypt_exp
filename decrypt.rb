require 'openssl'
require 'base64'

name = "test-encrypted"

in_file = File.path(name)
input_data = Base64.decode64( IO.readlines(in_file)[1].chomp)

decipher = OpenSSL::Cipher.new('AES-256-CBC')
decipher.decrypt

key_file = File.path("key")
iv_file = File.path("iv")
decipher.key = IO.readlines(key_file)[0].chomp
decipher.iv = IO.readlines(iv_file)[0].chomp

decrypted = decipher.update(input_data) + decipher.final

out_file = File.path(name + "-decrypted")
File.open(out_file, "w") do |x|
  x << IO.readlines(in_file)[0]
  x << decrypted
end

puts "Succesfully decrypted".green
