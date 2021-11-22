# frozen_string_literal: true

# Examples:

# The following will create a record in database and immediately it goes into queue. According to the point
# in the given task list 'Jobs could be added by rails command line at any time by the user to the queue'
Movie.create(title: 'Lord of the rings', priority: :high)

# The following will create a record in the database but it does not go into the queue, all waiting jobs will be
# queued once their status is changed to inprogress. According to your point in the given task list
# 'Jobs could be added and invoked by ignoring the queue at any point by the user from the command line.'
Movie.create(title: 'Star Wars', status: :waiting, priority: :low)

# I have added state mechine for movie model, by default when we create a new record it goes into the queue with status
# inprogress.
# If we want to ignore the queue we need to pass status 'waiting' when we are creating a new movie record.

# State mechine works as the following

# By default jobs has a inprogress status. Using state mechine transitions we can move jobs to inprogress from either
# waiting or from the failed status, but we can not move completed(done) jobs to inprogress which is the flow I have
# implemented for this test job.

Movie.create(title: 'RRR', status: :waiting, priority: :low, schedule_date: Time.zone.today)
