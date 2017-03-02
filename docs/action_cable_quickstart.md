### Action Cable Quickstart

Action Cable is a production ready transport built into Rails 5.

#### 1 Get Rails 5

You need to be on rails 5 to use ActionCable.  Make sure you upgrade to rails 5 first.

#### 2 Add Hyperloop gems

If you have not already installed the `hyper-component` and `hyper-model` gems, then do so now using the [hyper-rails](https://github.com/ruby-hyperloop/hyper-rails) gem.

- add `gem 'hyper-rails'` to your gem file (in the development section)
- run `bundle install`
- run `rails g hyperloop:install --all` (make sure to use the --all option)
- run `bundle update`

#### 3 Set the transport

TODO check below

Once you have Hyperloop installed then add this initializer:
```ruby
#config/initializers/hyperloop.rb
Hyperloop.configuration do |config|
  config.transport = :action_cable
end
```

#### 4 Setup ActionCable

If you are already using ActionCable in your app that is fine, as Hyperloop will not interfere with your existing connections.

Otherwise go through the following steps to setup ActionCable.

##### Make sure the `action_cable` js file is required in your assets

Typically `app/assets/javascripts/application.js` will finish with a `require_tree .` and this will pull in the `cable.js` file which will pull in `action_cable.js`

However at a minimum if `application.js` simply does a `require action_cable` that will be sufficient for Hyperloop.

##### Make sure you have a cable.yml file

```yml
# config/cable.yml
development:
  adapter: async

test:
  adapter: async

production:
  adapter: redis
  url: redis://localhost:6379/1
```

#### Set allowed request origins (optional)

**By default action cable will only allow connections from localhost:3000 in development.**  If you are going to something other than localhost:3000 you need to add something like this to your config:

```ruby
# config/environments/development.rb
Rails.application.configure do
  config.action_cable.allowed_request_origins = ['http://localhost:3000', 'http://localhost:5000']
end
```

#### 5 Try It Out  

If you don't already have a model to play with, add one now:

`bundle exec rails generate model Word text:string`

`bundle exec rake db:migrate`

Move `app/models/word.rb` to `app/hyperloop/models/word.rb` and move
`app/models/application_record.rb` to `app/hyperloop/models/application_record.rb`

**Leave** `app/models/model.rb` where it is.  This is your models client side manifest file.

Whatever model(s) you will plan to access on the client need to moved to the `app/hyperloop/models` directory.  This allows Hyperloop to build a client side proxy for the Models.  Models not moved will be completely invisible on the client or in your Isomorphic code.

**Important** in rails 5 there is also a base `ApplicationRecord` class, that all other models are built from.  This class must be moved to `app/hyperloop/models` directory as well.

If you don't already have a simple component to play with,  here is a simple one (make sure you added the Word model):

```ruby
# app/views/components/app.rb
class App < Hyperloop::Component

  def add_new_word
    # for fun we will use setgetgo.com to get random words!
    HTTP.get("http://randomword.setgetgo.com/get.php", dataType: :jsonp) do |response|
      Word.new(text: response.json[:Word]).save
    end
  end

  render(DIV) do
    SPAN { "Count of Words: #{Word.count}" }
    BUTTON { "add another" }.on(:click) { add_new_word }
    UL do
      Word.each { |word| LI { word.text } }
    end
  end
end
```

Add a controller:

```ruby
#app/controllers/test_controller.rb
class TestController < ApplicationController
  def app
    render_component
  end
end
```

Add the `test` route to your routes file:

```ruby
#app/config/routes.rb

  get 'test', to: 'test#app'

```

Fire up rails with `bundle exec rails s` and open your app in a couple of browsers.  As data changes you should see them all updating together.

You can also fire up a rails console, and then for example do a `Word.new(text: "Hello").save` and again see any browsers updating.

If you want to go into more details with the example check out [words-example](/docs/words-example.md)

TODO check link above
