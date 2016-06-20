class MessengerController < Messenger::MessengerController

  # def message(event, sender)
  #   # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
  #   sender.reply({ text: "Reply: #{event['message']['text']}" })
  # end

  def webhook
    if params['hub.verify_token'] == ENV['FB_VERIFY_TOKEN']
      render text: params['hub.challenge'] and return
    elsif fb_params.first_entry.callback.message?
      answerback
    else
      render text: 'error' and return
    end
  end

  private

  def answerback
    @location = Geocoder.coordinates(fb_params.first_entry.callback.text)
    if @location
      search_conditions = {
        activated: true,
        location: {
          near:   @location,
          within: "5km"
        }
      }

      sort_conditions = [
        {
          _geo_distance: {
            location: {
              lat: @location[0],
              lon: @location[1]
              },
            order: "asc",
            unit: "km",
            mode: "min"
          }
        }
      ]

      @companies = Company.search('*', where: search_conditions, order: sort_conditions, page: (page_number || 1), per_page: 3)

      if @companies.any?
        bubbles = []
        @companies.each do |company|
          bubble =Messenger::Elements::Bubble.new(
            title: "#{company.name}",
            subtitle: "#{company.city}",
            item_url: "http://localhost:3000/companies/#{company.id}",
            image_url: "#{company.picture.url}",
            buttons: [
              Messenger::Elements::Button.new(
                type: 'postback',
                title: 'Reserver',
                value: "user_books_in_company_#{company.id}"
              )
            ]
          )
          bubbles << bubble
        end
        generic =Messenger::Templates::Generic.new(elements: bubbles)

        Messenger::Client.send(
          Messenger::Request.new(generic, fb_params.first_entry.sender_id)
        )
        render nothing: true, status: 200
      else
        Messenger::Client.send(
          Messenger::Request.new(
            Messenger::Elements::Text.new(text: "Nous n'avons rien trouvé à '#{fb_params.first_entry.callback.text}'" ),
            fb_params.first_entry.sender_id
          )
        )
        render nothing: true, status: 200
      end
    else
      Messenger::Client.send(
        Messenger::Request.new(
          Messenger::Elements::Text.new(text: "dans l'eau"),
          fb_params.first_entry.sender_id
        )
      )
      render nothing: true, status: 200
    end
  end

  # def delivery(event, sender)
  #   render nothing: true, status: 200
  # end

  # def postback(event, sender)
  #   payload = event["postback"]["payload"]
  #   case payload
  #   when :something
  #     #ex) process sender.reply({text: "button click event!"})
  #   end
  # end
end
