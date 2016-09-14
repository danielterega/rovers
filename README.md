```bash
$ git clone git@github.com:danielterega/rovers.git
$ cd rovers
$ bundle
$ rake # to run the tests suite
$ irb
```

```ruby
$LOAD_PATH.unshift('lib')
require 'rovers'
puts Rovers::InputFileHandler.new('spec/fixtures/files/input.txt').run
```