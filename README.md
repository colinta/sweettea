sweettea
========

    teacup + sugarcube = sweettea


 handlers
----------

Handlers for teacup that add the coercion abilities of sugarcube to the style
abilities of teacup, for great good.

```ruby
# what was
my_image = UIImage.imageNamed("Logo")
style :label,
  font: UIFont.fontWithName("Inconsolata", size:UIFont.systemFontSize),
  image: my_image,
  origin: [10, 10],
  size: my_image.size

# sugarcube
my_image = "Logo".uiimage
style :label,
  font: "Inconsolata".uifont,
  image: my_image,
  origin: [10, 10],
  size: my_image.size

# sweettea
style :label,
  font: "Inconsolata",
  image: "Logo",
  origin: [10, 10]
  # size is set automatically, isn't that nice?
  # (it will not be set if frame.size is already set to something other than [0, 0])
```

 installation
--------------

    gem install sugarcube
    gem install teacup
    gem install sweettea

    # or in Gemfile
    gem 'sugarcube'
    gem 'teacup'
    gem 'sweettea'

    # in Rakefile
    require 'sugarcube'
    require 'teacup'
    require 'sweettea'


If you want to use the added base styles (secure_input, email_input, etc) add

    import :sweettea

to your stylesheet, you can then use them like this:

    style :password_field, extends: :secure_input,
      placeholder: "Password"

To learn about the included styles, check out [`styles.rb`][styles]

[styles]: https://github.com/colinta/sweettea/blob/master/lib/sweettea/styles.rb
