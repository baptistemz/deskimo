module ApplicationHelper

  def get_displayable_companies(companies)
    raise
    @companies = []
    companies.each do |company|
      if company.desks.where(activated:true)
        @companies << company
      end
    end
    return @companies
  end
end
