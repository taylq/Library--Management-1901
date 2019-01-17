set :environment, "development"
set :output, "log/whenever.log"

every 1.day, at: "8:00 am" do
  runner "ReturnBookJob.perform_now"
end
