require 'nokogiri'
require 'mechanize'

#ScrapLeFive.new.perform
class ScrapLeFive

  def initialize
  end
  
  def perform(city,time,duration,date)

    return nil if ScrapLeFive.unperformable(city,time,duration,date)
  
   
    

    agent = Mechanize.new

    page = agent.get('https://www.soccerpark.fr/identifiez-vous/') # Get the Login page
    login_form = page.forms.last # Get the last form of the page = the form for login
    email_field = login_form.field_with(name: 'users_email') # Field for user email
    password_field = login_form.field_with(name: 'users_password') # Field for password

    email_field.value = ENV['LEFIVE_EMAIL'] # Set the value in the email field
    password_field.value = ENV['LEFIVE_PASSWORD'] # Set the value in the password field
  
    
    page = agent.submit(page.forms.last) # Submit the result for connect in var

    # Test for detect link with Réserver
    # agent.page.links.find { |link| link.text == 'Réserver' }
    # => #<Mechanize::Page::Link "Réserver" "/reservations/">

    book_link = agent.page.links.find { |link| link.text == 'Réserver' } # Link for book sport
    page = book_link.click # Click on the Book Link

    # test for show if i change url
    # book_link.uri
    #  => #<URI::HTTPS https://www.soccerpark.fr/index/nocentres/index.html?url_redirect=https://www.soccerpark.fr/reservations/>
    
    center_field = page.form.field_with(name: 'centres_id')
    # center_field.value = "39"
    center_field.value = center_field.option_with(:text =>"LE FIVE #{city}")

    page = agent.submit(page.form)

    list = page.forms.last

  
    type_sport = list.field_with(name: 'reservations_terrains_typesport')
    
    
    type_sport.value = type_sport.option_with(:text => "Foot")

    
    playfield_type = list.field_with(name: 'reservations_terrains_type')
    playfield_type = playfield_type.options[0]

 
    capacity = list.field_with(name: 'reservations_capacite')
    if city != "Paris 13" 
      capacity.value = capacity.option_with(:text => "10 joueurs (10)")
    else
      capacity.value = capacity.option_with(:text => "10 personnes (10)")
     
    end

    

    play_date = list.field_with(name: 'reservations_date')
         
           
    play_date.value = Date.strptime("#{date}").strftime("%d/%m/%Y") 
 


    start = list.field_with(name: 'reservations_debut')
    start.value = start.option_with(:text => "#{time}")

    play_duration = list.field_with(name: 'reservations_duree')
    play_duration.value = play_duration.option_with(:text => "#{duration}")

 

    page = agent.submit(page.forms.last, page.forms.last.button)
    board = page.parser.xpath('//html/body/div[1]/div[2]/div/div/div[2]')
 
              

    i = 2
    date_array = []
    time_array = []
    duration_array = []
    price_array = []  
    
    until board.xpath('div['"#{i}"']/div[1]').text == "" do 
        date_array << board.xpath('div['"#{i}"']/div[1]').text
        time_array << board.xpath('div['"#{i}"']/div[2]').text
        duration_array << board.xpath('div['"#{i}"']/div[3]').text
        price_array << board.xpath('div['"#{i}"']/div[6]').text
        i = i +1
    end

    return date_array, time_array, duration_array, price_array
 
  end 


    #center_field.value = center_field.options_with(:text => @city)[0].value

    private
    def self.unperformable(city,time,duration,date)
        city == "Ville" || time == "Début" || duration == "Durée" || date == "" || ScrapLeFive.lefive_array.exclude?(city)
    end

    def self.lefive_array
      return ["Bezons", "Carrières-sous-poissy", "Bobigny", "Villette", "Créteil", "Paris 13", "Champigny"] 
    end
  
   end
  
  
  
  





