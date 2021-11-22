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
 > rails db:create <br/>
 > rails db:migrate <br/>
 > rails db:seed

* Open a new tab in your terminal and run sidekiq using the following command
 > bundle exec sidekiq

## For running tests use the following command in your terminal
 > RAILS_ENV=test rails db:create <br/>
 > RAILS_ENV=test rails db:migrate <br/>
 > bundle exec rspec

## Authentication to the API using JWT

Use any REST Client tools or curl and create a user first using the following endpoint and with user hash of email and password and you should receive authentication token to use it in further requests

  > POST localhost:3000/api/v1/users <br/>
  > PARAMS: user[email] = 'email@email.com' and user['password'] = 'yourpassword'

And now hit the following endpoint to list queue jobs(I named them as movies) and you will see list of movies , remember use **Authorization** header in the request. If you don't pass **Authorization** header the server responds with **unauthorized** status which means you can not access the api without **Authorization** header. For token authentication I have used JWT gem.

## The following two endpoints (GET, POST movies) satisfies the first two points in the given task
  > GET localhost:3000/api/v1/movies

And to create a new movie use the following POST endpoint with movie params title, priority, status
  > POST localhost:3000/api/v1/movies <br/>
  > PARAMS: movie[title] = 'Movie Title'

If you don't pass status and priority and by default it uses its default status and priority
  > default status is **inprogress** <br/>
  > default priority is **low**



**The process of movie creation and keeping it in queue for background job would be like the following**
  > When we create a new movie with title then the system creates a movie record with status **inprogress** and keeps it in queue, So every job we create will be there in queue for background process which is to satisfy the point given in test taks **Jobs could be added by rails command line at any time by the user to the queue**

  > But if at all we dont want a movie to be in queue upon creation we should keep it's status as **waiting** which tells the system that don't keep it in queue which is to satisfy the point given in the test task **Jobs could be added and invoked by ignoring the queue at any point by the user from the command line.**
  > Please check for sample records that are there in db/seed.rb file for the above 2 points**

## Support for workers. Jobs should be picked by workers and one of the workers should be that API itself. The job should have the option to decide when they should run based on the time provided.

  Background jobs are running with sidekiq and I have additionally used sidekiq-scheduler which makes us to set cronjobs. Here in the application I have implemented 
**Movie::QueuerWorker** which runs daily and queues movie records for the given schedule_date. Please check this worker and it's associated queuer class at **app/services/movie/queuer.rb** and scheduler at **config/sidekiq-scheduler.yml**


## Monitoring of api
For checking api request usage by user hit the following endpoint with **Authorization** header

  > GET localhost:3000/api/v1/metrics
I have used **ActiveSupport::Notifications.subscribe** to monitor api controller requests.

## App structure and objects responsibilities

I have followed some of the design patterns to have better code quality and for better performance.

- **app/controllers/api/v1/_controllers.rb** where you can see api requests
- **app/decorators** where you can see api response objects and I have used it to manipulate view objects in the json response.
- **app/serializers** where you can see response with specified attributes and I have used to handle json response with specific set of columns.
- **app/queries** where you can see query objects and I have used them to deal with database logic
- **app/services** where you can see some of the services and I have used them to write some services like **AuthenticationTokenService, RequestMetricService etc.**
- **app/workers** where you can see all the workers for background jobs.

## Rails best practices, coding conventions and format checking

I have used rubocop gem for this.
