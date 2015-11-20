module Account
  class CompaniesController < Account::Base
    def new
      @company = Company.new
    end


  end
end
