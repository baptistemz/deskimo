module Account
  class CalendarsController < Account::Base

    def redirect
      client = Signet::OAuth2::Client.new({
        client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
        client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
        access_type: 'offline',
        redirect_uri: callback_account_calendars_url
      })

      redirect_to client.authorization_uri(:approval_prompt => :force).to_s
    end

    def callback
      client = Signet::OAuth2::Client.new({
        client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
        client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        redirect_uri: callback_account_calendars_url,
        code: params[:code]
      })
      response = client.fetch_access_token!
      if response['refresh_token']
        current_user.update!(calendar_access_token: response['access_token'], calendar_refresh_token: response['refresh_token'])
      end
      session[:access_token] = response['access_token']
      redirect_to account_calendars_path

    end

    def show
      @desks = current_user.company.desks.where("kind != 'open_space'")
      client = Signet::OAuth2::Client.new(access_token: session[:access_token])
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      @calendar_list = service.list_calendar_lists.items.collect{|i| [i.summary, i.id]}
    end

    def associate
      @desks = current_user.company.desks
      @desks.each do |desk|
        if params["#{desk.id}_calendar"].present?
          desk.update(calendar_id: params["#{desk.id}_calendar"])
          LinkCalendarToUnavailabilitiesJob.perform_later(desk.id)
        end
      end
      redirect_to account_company_desks_path(current_user.company)
    end
  end
end
