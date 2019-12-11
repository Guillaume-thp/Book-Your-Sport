
class ScrapUrbanSoccer
 class << self
    def perform(city,time,duration)
    
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
  
      puteaux = browser.div(text: city)
  
      sleep rand(0.1..0.3)
      puteaux.wait_until(&:present?).double_click
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
     
      browser.span(text:"Intérieur").click
      binding.irb
      date = browser.div(text: "21") # Choisir le jour. Faire en dernier sinon bug sur chrome
      date.click
  
  
  
  
  
  
      return browser.div(class: "reservation-header").text #browser.div(class: "reservation-header").text
    end
 

 private
   
   
    def urban_duration(duration)
     
        
        return duration
    end
end  
end
  
  
  #type de terrain : browser.element(:xpath => "//div[2]/span[2]").text
  # date : browser.element(:xpath => "//div[3]/span[2]").text
  # durée : browser.element(:xpath => "//div[2]/div[2]/span[2]").text
  # browser.element(:xpath => "//div[2]/div[3]/span[2]).text
  # prix : browser.element(:xpath => "//div[2]/div[3]/span[2]").text
  
