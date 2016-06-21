class MessengerController < Messenger::MessengerController
  before_action :set_first_entry

  def webhook
    if params['hub.verify_token'] == ENV['FB_VERIFY_TOKEN']
      render text: params['hub.challenge'] and return
    elsif @first_entry.callback.message?
      message_answer
    elsif @first_entry.callback.postback?
      postback_answer
    else
      render text: 'error' and return
    end
  end

  private

  def message_answer
    @first_entry = fb_params.first_entry
    @location = Geocoder.coordinates(@first_entry.callback.text)
    if @location
      @companies = Company.search('*', where: search_conditions(@location), order: sort_conditions(@location), page: 1, per_page: 3)
      if @companies.any?
        bubbles = bubble_creation(@companies)
        generic = Messenger::Templates::Generic.new(elements: bubbles)
        Messenger::Client.send(
          Messenger::Request.new(generic, @first_entry.sender_id)
        )
        render nothing: true, status: 200
      else
        fail_message(@first_entry.callback.text, @first_entry.sender_id)
      end
    else
      fail_message(@first_entry.callback.text, @first_entry.sender_id)
    end
  end

  private

  def set_first_entry
    @first_entry = fb_params.first_entry
  end

  def search_conditions(location)
    search_conditions = {
      activated: true,
      location: {
        near:   location,
        within: "5km"
      }
    }
  end
  def sort_conditions(location)
      sort_conditions = [
        {
          _geo_distance: {
            location: {
              lat: location[0],
              lon: location[1]
              },
            order: "asc",
            unit: "km",
            mode: "min"
          }
        }
      ]
    end

    def bubble_creation(companies)
      bubbles = []
      @companies.each do |company|
        buttons = buttons_creation(company)
        bubble =Messenger::Elements::Bubble.new(
          title: "#{company.name}",
          subtitle: "#{company.city}",
          item_url: "http://localhost:3000/companies/#{company.id}",
          image_url: "#{company.picture.url}",
          buttons: buttons

        )
        bubbles << bubble
      end
      return bubbles
    end

    def buttons_creation(company)
      buttons = []
      buttons << Messenger::Elements::Button.new(
        type: 'postback',
        title: "Place en open space",
        value: "user_books_in_company_#{company.id}_open_space"
      )
      buttons << Messenger::Elements::Button.new(
        type: 'postback',
        title: "Bureau séparé",
        value: "user_books_in_company_#{company.id}_closed_office"
      )
      buttons << Messenger::Elements::Button.new(
        type: 'postback',
        title: "Salle de réunion",
        value: "user_books_in_company_#{company.id}_meeting_room"
      )
    end
    def fail_message(text, sender_id)
      Messenger::Client.send(
        Messenger::Request.new(
          Messenger::Elements::Text.new(text: "Nous n'avons rien trouvé pour l'endroit : '#{text}'" ),
          sender_id
        )
      )
      render nothing: true, status: 200
    end
end
