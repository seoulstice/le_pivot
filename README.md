# Le Pivot
This multi-tenant art sales platform completes Turing School's [Le Pivot](http://backend.turing.io/module3/projects/le_pivot) assignment.  Starting from [this base repo](https://github.com/turingschool-examples/the_pivot_base), features were added over two weeks by four students:
- Project Manager: [Young Jung](https://github.com/seoulstice)
- [Timothy Joo](https://github.com/Tyjoo26)
- [Josi McClellan](https://github.com/JosiMcClellan)
- [Alex Barnes](https://github.com/abarnes26)

The team inherited a code base for a retail e-commerce site and was tasked with cleaning up code via refactoring and expanding the code base to evolve the web application into a multi-tenant e-commerce platform. This involved significantly increasing the complexity of the web application, particularly user roles and user permissions. Additionally, each team member was tasked with implementing certain features to add functionality to the web application.

The team used Pivotal Tracker to manage project development and used git rebase for version control.

This involved setting up the web application to consume third party API data and to use that actionable data in several features. The third party APIs are listed below:

..* [USPS](https://www.usps.com/business/web-tools-apis/welcome.htm)
..* [Stripe](https://stripe.com/docs/api)
..* [Twilio](https://www.twilio.com/docs/api)
..* [Twitter](https://developer.twitter.com/en/docs)
..* [Websocket](https://www.npmjs.com/package/actioncable)

#### The following services were implemented in the e-commerce web application.

..* Twitter OAuth 2.0 for secure authorization and authentication
..* Payment Processing via Stripe
..* Live Chat implemented with ActionCable
..* Forgot Password Recovery Text Messaging via Twilio
..* Shipping Cost Estimation via USPS
..* Item Search through a Search API

## Setup on Local Machine
run these commands:
```bash
git clone https://github.com/seoulstice/le_pivot
cd le_pivot
bundle install
rake setup
rails server
```
All users have a password of `password` if you want to login and explore.

## View on Production Server
The web application can be acccessed at https://le-pivot-turing.herokuapp.com/

## How to Run the Test Suite

In order to run the full test suite, run the following command in your Terminal window:
```
'bundle exec rspec'
```
  
In order to run a single test file, run the following command in your Terminal window:
```
bundle exec rspec  spec/<FILE_PATH_FOR_SPEC>
  
ex. 'bundle exec rspec spec/features/user/stores/user_can_create_store_spec.rb'
```
  
In order to run a single line within a test file, run the following command in your Terminal window:
```
bundle exec rspec spec/<FILE_PATH_FOR_SPEC>:<LINE_#>
  
ex. 'bundle exec rspec spec/features/user/stores/user_can_create_store_spec.rb:5'
```

