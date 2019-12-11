
class ScrapUrbanSoccer
    def initialize
    end
  
  
    def perform
  
        opts = {
      headless: true
    }
  
    if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
      opts.merge!( options: {binary: chrome_bin})
    end 
  
  browser = Watir::Browser.new :chrome, opts
  browser.goto 'https://my.urbansoccer.fr/user?goto=reserver'
  email_field = browser.text_field(type: 'email')
  password_field = browser.text_field(type: 'password')
  email_field.set(ENV['URBAN_EMAIL'])
  password_field.set(ENV['URBAN_PASSWORD'])
  password_field.send_keys(:enter)
  
  idf = browser.path(id: "IDF")
  idf.double_click
  
  puteaux = browser.div(text: "Puteaux")
  
  puteaux.wait_until(&:present?).double_click
  # cliquer sur la fleche droite du calendrier pour le mois suivant
   #browser.span(class:["DayPicker-NavButton", "DayPicker-NavButton--next"]).click
  
  
  
  #dropdown heuresend_keys('\n')
  
  browser.option(value: "15h00").click
  
  #dropdown durée
  browser.option(value: "120").click
  
  date = browser.div(text: "21") # Choisir le jour. Faire en dernier sinon bug sur chrome
  date.click
  
  
  
  #Type de terrain. Remplacer un tiret par un underscore dans un attribut.
  browser.span(text:"3 contre 3").click
  
  
  return browser.div(class: "reservation-header").text #browser.div(class: "reservation-header").text
    end
  end
  
  
  #type de terrain : browser.element(:xpath => "//div[2]/span[2]").text
  # date : browser.element(:xpath => "//div[3]/span[2]").text
  # durée : browser.element(:xpath => "//div[2]/div[2]/span[2]").text
  # browser.element(:xpath => "//div[2]/div[3]/span[2]).text
  # prix : browser.element(:xpath => "//div[2]/div[3]/span[2]").text
  
  