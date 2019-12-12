
class ScrapUrbanSoccer
 
    def perform(city,time,duration,date)
      return nil if ScrapUrbanSoccer.unperformable(city,time,duration,date)
          opts = {
        headless: true
      }
  
      if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
        opts.merge!( options: {binary: chrome_bin})
      end 
  
      browser = Watir::Browser.new :chrome  #, opts
      browser.goto 'https://my.urbansoccer.fr/user?goto=reserver'
      email_field = browser.text_field(type: 'email')
      password_field = browser.text_field(type: 'password')
      email_field.set(ENV['URBAN_EMAIL'])
      password_field.set(ENV['URBAN_PASSWORD'])
 
  
      password_field.send_keys(:enter)
 
  
      idf = browser.path(id: "IDF")
      sleep rand(0.1..0.3)
      idf.double_click
  
      play_city = browser.div(text: city)
  
      sleep rand(0.1..0.3)
      play_city.wait_until(&:present?).double_click
      # cliquer sur la fleche droite du calendrier pour le mois suivant
      #browser.span(class:["DayPicker-NavButton", "DayPicker-NavButton--next"]).click
  
  
  
  #dropdown heuresend_keys('\n')
  
 
  
      browser.option(value:time).click
      
  #dropdown durée
  if duration == "01:00"
    duration = "60"
  elsif duration =="01:30"
    duration ="90"
  elsif duration == "02:00"
    duration = "120"
  end

      browser.option(value:duration).click

      if city!= "Puteaux"
        browser.span(text:"Intérieur").click
      else  
        browser.span(text:"Filmé indoor").click
      end
     

      if Date.strptime("#{date}").month != Date.current.month

        browser.span(class:["DayPicker-NavButton", "DayPicker-NavButton--next"]).click
      end
      play_date = browser.div(text: "#{Date.strptime(date).day}") # Choisir le jour. Faire en dernier sinon bug sur chrome
      play_date.click
      #ScrapUrbanSoccer.perform("Meudon","14h00","01:00","2019-12-30")
     
  
      
      no_timeslot_message = "Désolé, il n'y a aucun créneau disponible correspondant a vos critères"
      sleep 1
    
        if browser.div(class:"liste-attente").exist? == true
          return no_timeslot_message
       elsif browser.div(class:"liste-attente").exist? == false
       timeslot_date = browser.element(:xpath => "//div[3]/span[2]").text
       timeslot_time = browser.element(:xpath => "//div[2]/div[1]/span[2]").text
       timeslot_duration =  browser.element(:xpath => "//div[2]/div[2]/span[2]").text
       timeslot_price =  browser.element(:xpath => "//div[2]/div[3]/span[2]").text

       return timeslot_date, timeslot_time,timeslot_duration,timeslot_price
       end
    
      
      
    end
 

    private
    def self.unperformable(city,time,duration,date)
        city == "Ville" || time == "Début" || duration == "Durée" || date == "" || ScrapUrbanSoccer.urban_array.exclude?(city)
    end

    def self.urban_array
      return ["Puteaux", "Meudon", "Orsay ", "Asnieres-Gennevilliers ", "Porte d'aubervilliers", "Evry-Courcouronnes", "La Défense ", " Porte d'Ivry", "Guyancourt", "Marne La Vallée"]
    end
  
   end
  
  
  #type de terrain : browser.element(:xpath => "//div[2]/span[2]").text
  # date : browser.element(:xpath => "//div[3]/span[2]").text
  # durée : browser.element(:xpath => "//div[2]/div[2]/span[2]").text
  # browser.element(:xpath =>    "//div[2]/div[3]/span[2]).text
  # prix : browser.element(:xpath => "//div[2]/div[3]/span[2]").text
  
