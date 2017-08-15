# frozen_string_literal: true

user1 = User.create(email: 'user1@example.me', password: '123456')
user2 = User.create(email: 'user2@example.me', password: '654321')

event1 = user1.events.create(
  name: 'Summer Party',
  start: 3.days.from_now,
  place: 'Paradise Beach',
  description: 'The best party of this summer'
)

event2 = user1.events.create(
  name: 'Meeting',
  start: 7.days.from_now,
  place: 'Brownie Caffee'
)

event3 = user1.events.create(
  name: 'The movie',
  start: 2.weeks.from_now,
  place: 'Cinema Paradise',
  description: 'The Guardians of Galaxy 2'
)

user1.calendar.events << [event1, event2, event3]

event4 = user2.events.create(
  name: 'Flight Novosibirsk - Moscow',
  start: 2.days.from_now,
  place: 'Tolmachevo Airport',
  description: 'Very important trip'
)

event5 = user2.events.create(
  name: 'Breakfast with brother',
  start: 5.days.from_now,
  place: 'Coffee story'
)

user2.calendar.events << [event4, event5]

# share event
user2.calendar.events << event3
user2.notifications.create(event_id: event3.id)
