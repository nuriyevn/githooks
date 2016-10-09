=begin
./ngrok http 4567
and then
just copy the server name and create a webhooks
=end

require 'sinatra'
require 'json'

post '/payload' do
    push = JSON.parse(request.body.read)
    
    event_name = request.env['HTTP_X_GITHUB_EVENT']
    puts "Event name: " + event_name + "\n"

    
    if event_name === "commit_comment"
        puts "Comment Author: " + push['comment']['user']['login'] + "\n"
        puts "Comment body: " + push['comment']['body'] + "\n"
        puts "Repository FullName: " + push['repository']['full_name'] + "\n"
    elsif event_name === "push"
        puts "Who pushes head commit (username)? " + 
            push['head_commit']['committer']['username'] + "\n"
        puts "Who is author of head commit (username)? " +
            push['head_commit']['author']['username'] + "\n"
        puts "Push message: " + push['head_commit']['message'] + "\n"
    else
        puts "Sorry, unimplemented webhook!" + "\n"
    end
    #puts headers
end

get '/payload' do
    "Hello World!"
end
