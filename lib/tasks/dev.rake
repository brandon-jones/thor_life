require 'csv'

require 'socket'

namespace :dev do
  desc "Use HOST=example.com to set a hostname on the certs, or USEIP=true to use the address of
  interface en0, or USEIP=ppp0 to use ppp0, for example".squish
  task :setup_ssl => :environment do
    base_path = "#{Rails.root}/tmp/certificates"
    puts "USE IP" if ENV['USEIP']
    host = if ENV['USEIP']
      # Defaults to using "en0" if ENV['USEIP'] is "t" or "true", assumes it's
      # an interface name otherwise
      interface = ENV["USEIP"] =~ /\At(rue)?\Z/i ? "en0" : ENV["USEIP"]
      addr = `ifconfig #{interface} inet | grep inet | cut -d ' ' -f 2`.strip
      puts addr
      raise "Couldn't get address of #{interface}" if addr.empty?
      addr
    else
      ENV['host'] || Socket.gethostname
    end

    puts "Generating certificates using host #{host}"

    # make sure our directory exists
    FileUtils.mkdir_p(base_path)
    FileUtils.mkdir_p(File.join(base_path, 'intermediates'))

    puts
    puts '== GENERATING PRIVATE KEY =='
    puts

    `openssl genrsa -des3 -out #{base_path}/ssl.key 1024`

    puts
    puts '== GENERATING CSR =='
    puts

    File.open("#{base_path}/ssl.cnf", 'w') do |config|
      config.puts "
[req]
distinguished_name      = req_distinguished_name
prompt                  = no

[req_distinguished_name]
countryName             = US
stateOrProvinceName     = California
localityName            = Bakersfield
organizationName        = Lightspeed Systems
organizationalUnitName  = Development
commonName              = #{host}
emailAddress            = developer@lightspeedystems.com
"
    end

    `openssl req -new -key #{base_path}/ssl.key -out #{base_path}/ssl.csr -config #{base_path}/ssl.cnf`

    puts
    puts '== REMOVING PRIVATE KEY PASSWORD =='
    puts

    FileUtils.cp("#{base_path}/ssl.key", "#{base_path}/ssl.key.bak")
    `openssl rsa -in #{base_path}/ssl.key.bak -out #{base_path}/ssl.key`

    puts
    puts '== GENERATING CERTIFICATE =='
    puts

    `openssl x509 -req -days 365 -in #{base_path}/ssl.csr -signkey #{base_path}/ssl.key -out #{base_path}/ssl.crt`

    # create pem compatible with pound
    `cat #{base_path}/ssl.key #{base_path}/ssl.crt > #{base_path}/ssl.pem`

    # copy into the public directory for download
    FileUtils.cp("#{base_path}/ssl.crt", "#{Rails.root}/public/ssl.crt")
  end

  # change the final path to the location pound uses on the back end before running.
  # the cert will get the copied to this env so you are ready to run
  task :setup_ssl_env => :environment do
    base_path = "#{Rails.root}/tmp/certificates"
    final_path = '/Users/bjones/Documents/Development/Ruby/MM/mm_commander/tmp/certificates/'
    interface = "en4"
    addr = `ifconfig #{interface} inet | grep inet | cut -d ' ' -f 2`.strip
    if addr.empty?
      interface = "en0"
      addr = `ifconfig #{interface} inet | grep inet | cut -d ' ' -f 2`.strip
    end
    raise "Couldn't get address of #{interface}" if addr.empty?
    host = addr

    puts "Generating certificates using host #{host}"

    # make sure our directory exists
    FileUtils.mkdir_p(base_path)
    FileUtils.mkdir_p(File.join(base_path, 'intermediates'))

    puts
    puts '== GENERATING PRIVATE KEY =='
    puts

    `openssl genrsa -des3 -out #{base_path}/ssl.key 1024`

    puts
    puts '== GENERATING CSR =='
    puts

    File.open("#{base_path}/ssl.cnf", 'w') do |config|
      config.puts "
                  [req]
                  distinguished_name      = req_distinguished_name
                  prompt                  = no
                  [req_distinguished_name]
                  countryName             = US
                  stateOrProvinceName     = California
                  localityName            = Bakersfield
                  organizationName        = The House of Thor
                  organizationalUnitName  = ThorLife
                  commonName              = #{host}
                  emailAddress            = admin@thorlife.com
                  "
    end

    `openssl req -new -key #{base_path}/ssl.key -out #{base_path}/ssl.csr -config #{base_path}/ssl.cnf`

    puts
    puts '== REMOVING PRIVATE KEY PASSWORD =='
    puts

    FileUtils.cp("#{base_path}/ssl.key", "#{base_path}/ssl.key.bak")
    `openssl rsa -in #{base_path}/ssl.key.bak -out #{base_path}/ssl.key`

    puts
    puts '== GENERATING CERTIFICATE =='
    puts

    `openssl x509 -req -days 365 -in #{base_path}/ssl.csr -signkey #{base_path}/ssl.key -out #{base_path}/ssl.crt`

    # create pem compatible with pound
    `cat #{base_path}/ssl.key #{base_path}/ssl.crt > #{base_path}/ssl.pem`

    # copy into the public directory for download
    # FileUtils.cp("#{base_path}/ssl.crt", "#{Rails.root}/public/ssl.crt")

    # copy into mm_commander (final_path) for usage
    puts 'Copying pem file to final path'
    FileUtils.cp("#{base_path}/ssl.pem", final_path)
    puts 'file copied. ready to run!'
  end

end