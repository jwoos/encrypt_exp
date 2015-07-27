require 'openssl'
require 'base64'
require 'colorize'

if ARGV.empty?
  puts "Please put in a file name as the first argument and encrypt/decrypt as the second".red
elsif ARGV.length == 1
  puts "Both file name and action must be supplied in that order".red
else
  name = ARGV[0]
  to_do = ARGV[1].downcase

  case to_do
  when "encrypt"
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

  when "decrypt"
    in_file = File.path(name)
    input_data =Base64.decode64( IO.readlines(in_file)[1].chomp)

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

  else
    puts "Error".red
  end #end switch statement

end
