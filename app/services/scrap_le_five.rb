require 'nokogiri'
require 'mechanize'


class ScrapLeFive

  def initialize
  end
  
  def perform
    
    puts ENV['USER_EMAIL']
    puts ENV['USER_PASSWORD']
    agent = Mechanize.new

    page = agent.get('https://www.soccerpark.fr/identifiez-vous/') # Get the Login page
    login_form = page.forms.last # Get the last form of the page = the form for login
    email_field = login_form.field_with(name: 'users_email') # Field for user email
    password_field = login_form.field_with(name: 'users_password') # Field for password

    email_field.value = ENV['USER_EMAIL'] # Set the value in the email field
    password_field.value = ENV['USER_PASSWORD'] # Set the value in the password field
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
    center_field.value = center_field.options[1]
    page = agent.submit(page.form)

    list = page.forms.last

    # Type de sport
    # Index 0 for ID : 3 => PADEL
    # Index 1 for ID : 1 => FOOT
    type_sport = list.field_with(name: 'reservations_terrains_typesport')
    
    
    type_sport.value = type_sport.options[1]

    # Type de terrains
    # Index 0 for ID : 1 => INDOR
    # Index 1 for ID : 7 => INDOR FILME
    playfield_type = list.field_with(name: 'reservations_terrains_type')
    playfield_type = playfield_type.options[0]

    # Capacité
    # Index 0 for ID : 4 => 2X2 pour PADEL
    # Index 1 for ID : 10 => 10 joueurs pour Foot
    capacity = list.field_with(name: 'reservations_capacite')
    capacity.value = capacity.options[1]

    # date de reservation
    # ADD VALUE like this : DD/MM/YYYY
    # EX 28/12/2019
    date = list.field_with(name: 'reservations_date')
    date.value = '21/12/2019'

    # Heure de début de séance (10:00 à 22:00)
    # Index 0 => 10:00
    # Index 1 => 10:30
    # Index 2 => 11:00
    # ...
    # Index 24 => 22:00

    start = list.field_with(name: 'reservations_debut')
    start.value = start.options[0]

    # Durée de la séance (1:00, 1:30, ou 2:00)
    # Index 0 => 1:00
    # Index 1 => 1:30
    # Index 2 => 2:00
    duration = list.field_with(name: 'reservations_duree')
    duration.value = duration.options[0]

    # Type de paiement ()
    # payment = list.field_with(:name => "reservations_typepaiement")
    # payment.value = payment.options[4]

    page = agent.submit(page.forms.last, page.forms.last.button)
    board = page.parser.xpath('//html/body/div[1]/div[2]/div/div/div[2]')
    line_1_date = board.xpath('div[2]/div[1]').text
    line_1_time = board.xpath('div[2]/div[2]').text
    line_1_duration = board.xpath('div[2]/div[3]').text
    line_1_price = board.xpath('div[2]/div[6]').text
    #center_field.value = center_field.options_with(:text => @city)[0].value


    return line_1_date, line_1_time, line_1_duration, line_1_price   
 
  end


end
