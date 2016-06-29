require "sinatra"
require "sendgrid-ruby"
include SendGrid

get "/" do
  erb :index
end

post "/email_response" do
  from = Email.new(email: params[:from])
  subject = params[:subject]
  to = Email.new(email: params[:to])
  content = Content.new(type: 'text/plain', value: params[:body])
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  "Email is sent."
end