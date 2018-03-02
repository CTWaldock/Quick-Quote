require 'twilio-ruby'
require 'gmail_sender'
require 'terminal-table'

# class to generate quote and send to client via text and email
class Quote
    attr_accessor :jobs, :distance_cost, :location, :contact

    # set variables for class
    def initialize(jobs, distance_cost, location, contact)
        @jobs = jobs
        @distance_cost = distance_cost
        @location = location
        @contact = contact

        # table template for quote
        @quote_1 =
        table = Terminal::Table.new :title => "Quick Quote" do |t|

        t << ["Job:", "#{@jobs[:name]}"]
        t.add_row ["Materials Cost:", "$#{@jobs[:materials_cost].to_i}"]
        t << :separator
        t.add_row ["Labour:", "Hours: #{@jobs[:time].to_i}\nRate: $50/hour"]
        t.add_separator
        t.add_row ["Total Labour:", "$#{@jobs[:time] * 50}"]
        t.add_row ["Travel to #{location}:", "$#{@distance_cost}"]
        t.add_row ["Total:", "$#{(@distance_cost + @jobs[:materials_cost].to_i + (@jobs[:time] * 50)).round(2)}"]

        end
    end

    # writes quote to .txt file
    def write_quote
      open('your_quote.txt', 'w') { |f| f << "#{@quote_1}" }
    end

    # puts a copy of quote on screne for user
    def put_quote
      puts @quote_1
    end


    # emails quote to client

    def email_quote
      g = GmailSender.new("quickquoteruby@gmail.com", "HelloWorld123")
      # you can attach any number of files, but there are limits for total attachments size
      g.attach('your_quote.txt')
      begin
        g.send(:to => "#{@contact[1]}",

              :subject => "Your Quick Quote",
              :content =>
    "Dear Client,

    please find attatched your own personal Quick Quote.

    Best wishes,
    The Quick Quote team!")
      rescue
        puts "No internet: Email can't be sent"
        #save your quoute to desktop
      end
  end

  # sends quote to client as a txt message
  def text_quote
    account_sid = 'ACf503a3a205fd784b4e8a185214772cbb'
    auth_token = 'b9c18d50b5f2bb3004b22c01e55f09f6'

    # set up a client to talk to the Twilio REST API
    begin
      client = Twilio::REST::Client.new account_sid, auth_token
      client.api.account.messages.create(
      from: '+61428189153',
      to: "#{@contact[0]}",
      body: "#{@quote_1}"
      )
    rescue
      puts "Text not sent: Invalid number"
    end
  end
end
