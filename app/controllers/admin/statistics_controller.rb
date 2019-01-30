module Admin
  class StatisticsController < BaseController
    def index
      @borrows = Borrow.group_date
    end
  end
end
