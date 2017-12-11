# The Pivot - Base Project

The following Rails app is used as the base project for [The Pivot](http://backend.turing.io/module3/projects/the_pivot).

## Setup

Built using Ruby 2.4.1 and Rails 5.1.3

Install required gems:
`$ bundle install`

Load the database dump:
`$ rake import_dump:load`

After the import you should see a return value of 1011 when running `Item.count` in the console.

All users have a password of `password` if you want to login and explore.

