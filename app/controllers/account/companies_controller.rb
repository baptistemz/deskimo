module Account
  class CompaniesController < Account::Base
    def new
      @company = Company.new
    end

    def create
      raise
    end


  end
end
