require 'openssl'

data = "This is a string"

cipher = OpenSSL::Cipher.new('AES-256-CBC')
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
encrypted = cipher.update(data) + cipher.final

decipher = OpenSSL::Cipher.new('AES-256-CBC')
decipher.decrypt
decipher.key = key
decipher.iv = iv
plain = decipher.update(encrypted) + decipher.final
puts data == plain
