require 'net/https'
require 'nokogiri'

=begin

 ex. environment.yaml

  Gmail:
    sleep: 60
    channel: '#Mint@freenode'
    account: 'account'
    password: 'password'

=end
class Gmail < Mint::Plugin
  def initialize(*args)
    super

    @account = @config['account']
    @password = @config['password']

    proxy = ENV['https_proxy'] || ENV['http_proxy']
    if proxy
      @https = Net::HTTP::Proxy(URI.parse(proxy).host, URI.parse(proxy).port).new('mail.google.com', 443)
    else 
      @https = Net::HTTP.new('mail.google.com', 443)
    end
    @mail_cache = {}
  end

  def before_hook
    login
  end

  def login
    @https.use_ssl = true
    @https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @request = Net::HTTP::Get.new('/mail/feed/atom')
    @request.basic_auth(@account, @password)
  end

  def notify
    mail_list = Nokogiri::XML(@https.request(@request).body)
    (mail_list/'entry').each do |entry|
      id = entry.at('id').content
      unless @mail_cache.key? id
        @mail_cache[id] = true
        title = entry.at('title').text
        name  = entry.at('name').text
        link  = entry.at('link')['href']

        @channels.each do |channel|
          message(channel, "Gmail: (#{name}) #{title} #{URI.short(link)}")
          sleep 5
        end
      end
    end
  end
end