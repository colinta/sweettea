# please organize by hierarchy and alphabetically, double spaces between classes

# the Helpers
#
def get_image_and_rect(view, img, insets=nil)
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

  if view.frame.size.width == 0 and view.frame.size.height == 0
    new_frame = CGRect.new(view.frame.origin, image.size)
    if insets
      new_frame.origin.x -= insets[1]
      new_frame.origin.y -= insets[0]
      new_frame.size.width += insets[1] + insets[3]
      new_frame.size.height += insets[0] + insets[2]
    end
    view.frame = new_frame
  end
  return image
end

# the Views
#
Teacup.handler UIView, :backgroundColor, :background { |color|
  self.backgroundColor = color.uicolor
}

Teacup.handler UIView, :contentMode { |mode|
  mode = mode.uicontentmode if mode.is_a?(Symbol)
  self.contentMode = mode
}

Teacup.handler UIView, :shadow { |shadow|
  {
    opacity: :'shadowOpacity=',
    radius: :'shadowRadius=',
    offset: :'shadowOffset=',
    color: :'shadowColor=',
    path: :'shadowPath=',
  }.each { |key, msg|
    if value = shadow[key]
      if key == :color
        value = value.uicolor.CGColor
      end
      NSLog "Setting layer.#{msg} = #{value.inspect}" if self.respond_to? :debug and self.debug
      self.layer.send(msg, value)
      self.layer.masksToBounds = false
      self.layer.shouldRasterize = true
    end
  }
}

# you would think this should be on UIImageView, but you can't subclass
# UIImageView, and any subclass of UIView that has an image will find this
# handler helpful.
Teacup.handler UIView, :image { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img)
  end
  self.image = image
}


Teacup.handler UIActivityIndicatorView, :color { |color|
  self.color = color.uicolor
}

Teacup.handler UIActivityIndicatorView, :activityIndicatorViewStyle, :style { |style|
  style = style.uiactivityindicatorstyle if style.is_a?(Symbol)
  self.activityIndicatorViewStyle = style
}


##|
##|  UIButton
##|
Teacup.handler UIButton, :font { |font|
  self.titleLabel.font = font.uifont
}

Teacup.handler UIButton, :textColor, :color { |color|
  self.titleLabel.textColor = color.uicolor
}

Teacup.handler UIButton, :normal, :image { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :highlighted, :pushed { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :disabled { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setImage(image, forState: UIControlStateDisabled)
}

Teacup.handler UIButton, :bg_normal, :bg_image { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setBackgroundImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :bg_highlighted, :bg_pushed { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setBackgroundImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :bg_disabled { |img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(self, img, self.contentEdgeInsets)
  end
  self.setBackgroundImage(image, forState: UIControlStateDisabled)
}


Teacup.handler UIDatePicker, :mode, :datePickerMode { |mode|
  mode = mode.uidatepickermode if mode.is_a? Symbol
  self.setDatePickerMode(mode)
}


##|
##|  UILabel
##|
Teacup.handler UILabel, :shadowColor { |color|
  self.shadowColor = color.uicolor
}

Teacup.alias UILabel, :autoshrink => :adjustsFontSizeToFitWidth
Teacup.alias UILabel, :minimumSize => :minimumFontSize

Teacup.handler UILabel, :textColor, :color { |color|
  self.textColor = color.uicolor
}

Teacup.handler UILabel, :font { |font|
  self.font = font.uifont
}

Teacup.handler UILabel, :highlightedTextColor, :highlightedColor { |color|
  self.highlightedTextColor = color.uicolor
}

Teacup.handler UILabel, :lineBreakMode { |mode|
  mode = mode.uilinebreakmode if mode.is_a? Symbol
  self.lineBreakMode = mode
}

Teacup.handler UILabel, :textAlignment, :alignment { |alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  self.textAlignment = alignment
}

Teacup.handler UILabel, :baselineAdjustment, :baseline { |baseline|
  baseline = baseline.uibaselineadjustment if baseline.is_a? Symbol
  self.baselineAdjustment = baseline
}

Teacup.handler UILabel, :sizeToFit { |truthy|
  self.sizeToFit if truthy
}

##|
##|  UINavigationBar
##|
Teacup.handler UINavigationBar, :backgroundImage { |styles|
  styles.each do |metric, image|
    metric = metric.uibarmetrics if metric.is_a? Symbol
    self.setBackgroundImage(image.uiimage, forBarMetrics:metric)
  end
}


##|
##|  UITableView
##|
Teacup.handler UITableView, :separatorStyle, :separator { |separator|
  separator = separator.uitablecellseparatorstyle if separator.is_a? Symbol
  self.separatorStyle = separator
}


##|
##|  UITextField
##|
Teacup.alias UITextView, :secure => :secureTextEntry

Teacup.handler UITextField, :keyboardType { |type|
  type = type.uikeyboardtype if type.is_a?(Symbol)
  self.setKeyboardType(type)
}

Teacup.handler UITextField, :returnKeyType, :returnKey, :returnkey { |type|
  type = type.uireturnkey if type.is_a? Symbol
  self.setReturnKeyType(type)
}

Teacup.handler UITextField, :textColor, :color { |color|
  self.textColor = color.uicolor
}

Teacup.handler UITextField, :font { |font|
  self.font = font.uifont
}

Teacup.handler UITextField, :textAlignment, :alignment { |alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  self.textAlignment = alignment
}

Teacup.handler UITextField, :borderStyle, :border { |border|
  border = border.uibordertype if border.is_a? Symbol
  self.borderStyle = border
}

Teacup.handler UITextField, :background { |image|
  self.background = image.uiimage
}


##|
##|  UITextView
##|
Teacup.alias UITextView, :secure => :secureTextEntry

Teacup.handler UITextView, :keyboardType { |type|
  type = type.uikeyboardtype if type.is_a?(Symbol)
  self.setKeyboardType(type)
}

Teacup.handler UITextView, :returnKeyType, :returnKey, :returnkey { |type|
  type = type.uireturnkey if type.is_a? Symbol
  self.setReturnKeyType(type)
}

Teacup.handler UITextView, :textColor, :color { |color|
  self.textColor = color.uicolor
}

Teacup.handler UITextView, :font { |font|
  self.font = font.uifont
}

Teacup.handler UITextView, :textAlignment, :alignment { |alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  self.textAlignment = alignment
}
