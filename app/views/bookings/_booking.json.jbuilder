json.extract! booking, :id, :user_id, :sport, :city, :date, :starting_hour, :duration, :price, :created_at, :updated_at
json.url booking_url(booking, format: :json)
