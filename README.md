# IShowTime Api
## Technology Stack
###### Ruby Version: 2.7.3
###### Rails Version: 6.x

## How to run ?
* Open your terminal and run 
 > **gem install bundler** 

* And then run 
 > **bundle**

* Next run database tasks using following commands
 > rails db:create
 > rails db:migrate
 > rails db:seed

* Open a new tab in your terminal and run sidekiq using the following command
 > bundle exec sidekiq

* For running tests use the following command in your terminal
 > RAILS_ENV=test rails db:create
 > RAILS_ENV=test rails db:migrate
 > bundle exec rspec

Next use any REST Client tools and create a user first using the following endpoint and with user hash of email and password and you should receive authentication token to use it in further requests

  > POST localhost:3000/api/v1/users
  > PARAMS: user[email] = 'email@email.com' and user['password'] = 'yourpassword'

And now hit the following endpoint to list queue jobs(I named them as movies) and you will see list of movies , remember use **Authorization** header in the request. If you dont pass **Authorization** the server responds with **unauthorized** status which means you can not access the api without **Authorization** header.

  > GET localhost:3000/api/v1/movies

And to create a new movie use the following POST endpoint with movie params title, priority, status
  > POST localhost:3000/api/v1/movies
  > PARAMS: movie[title] = 'Movie Title'

If you dont pass status and priority and by default it uses its default status and priority
  > default status is **inprogress**
  > default priority is **low**

For checking api request usage by user hit the following endpoint with **Authorization** header

  > GET localhost:3000/api/v1/metrics
