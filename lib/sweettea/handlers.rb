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
      if key == :color && CFGetTypeID(value) != CGColorGetTypeID()
        value = value.uicolor.CGColor
      end
      NSLog "Setting layer.#{msg} = #{value.inspect}" if self.respond_to? :debug and self.debug
      self.layer.send(msg, value)
      self.layer.masksToBounds = false
      self.layer.shouldRasterize = true
    end
  }
}

Teacup.handler UIView, :sizeToFit { |truthy|
  self.sizeToFit if truthy
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


# CALayer
#
Teacup.handler CALayer, :backgroundColor, :background { |color|
  if CFGetTypeID(color) != CGColorGetTypeID()
    color = color.uicolor.CGColor
  end
  self.backgroundColor = color
}

Teacup.handler CALayer, :borderColor, :border { |color|
  if color.class.name != '__NSCFType'
    color = color.uicolor unless color.is_a?(UIColor)
    color = color.CGColor
  end
  self.borderColor = color
}


# UIActivityIndicatorView
#
Teacup.handler UIActivityIndicatorView, :color { |color|
  self.color = color.uicolor
}

Teacup.handler UIActivityIndicatorView, :activityIndicatorViewStyle, :style { |style|
  style = style.uiactivityindicatorstyle unless style.is_a?(Fixnum)
  self.activityIndicatorViewStyle = style
}


# UIButton
#
Teacup.handler UIButton, :font { |font|
  self.titleLabel.font = font.uifont
}

module Sweettea
  module_function

  def uibutton_state_handler(target, properties, state)
    actual_state = state.is_a?(Symbol) ? state.uicontrolstate : state
    properties.each do |property, value|
      if property == :image || property == :bg_image
        if value != nil
          value = get_image_and_rect(target, value, target.contentEdgeInsets)
        end
      end

      case property
      when :title
        target.setTitle(value, forState:actual_state)
      when :attributed
        target.setAttributedTitle(value, forState:actual_state)
      when :color
        target.setTitleColor(value, forState:actual_state)
      when :shadow
        target.setTitleShadowColor(value, forState:actual_state)
      when :bg_image
        target.setBackgroundImage(value, forState:actual_state)
      when :image
        target.setImage(value, forState:actual_state)
      else
        NSLog "SWEETTEA WARNING: Can't apply #{property.inspect} to #{target.inspect} forState:#{state.inspect}"
      end
    end
  end
end

Teacup.handler UIButton, :normal { |values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {normal: image} handler is deprecated in favor of normal: { image: image }")
    values = { normal: values }
  end
  Sweettea.uibutton_state_handler(self, values, :normal)
}

Teacup.handler UIButton, :disabled { |values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {disabled: image} handler is deprecated in favor of disabled: { image: image }")
    values = { disabled: values }
  end
  Sweettea.uibutton_state_handler(self, values, :disabled)
}

Teacup.handler UIButton, :selected { |values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {selected: image} handler is deprecated in favor of selected: { image: image }")
    values = { selected: values }
  end
  Sweettea.uibutton_state_handler(self, values, :selected)
}

Teacup.handler UIButton, :highlighted { |values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {highlighted: image} handler is deprecated in favor of highlighted: { image: image }")
    values = { highlighted: values }
  end
  Sweettea.uibutton_state_handler(self, values, :highlighted)
}

Teacup.handler UIButton, :textColor, :color { |color|
  self.titleLabel.textColor = color.uicolor
}

Teacup.handler UIButton, :image { |img|
  NSLog("SWEETTEA WARNING: The :image handler is deprecated in favor of normal: { image: img }")
  Teacup.apply(self, normal: { image: img })
}

Teacup.handler UIButton, :pushed { |img|
  NSLog("SWEETTEA WARNING: The :pushed handler is deprecated in favor of highlighted: { image: img }")
  Teacup.apply(self, highlighted: { image: img })
}

Teacup.handler UIButton, :bg_image { |img|
  NSLog("SWEETTEA WARNING: The :bg_image handler is deprecated in favor of normal: { bg_image: img }")
  Teacup.apply(self, normal: { bg_image: img })
}

Teacup.handler UIButton, :bg_pushed { |img|
  NSLog("SWEETTEA WARNING: The :bg_pushed handler is deprecated in favor of highlighted: { bg_image: img }")
  Teacup.apply(self, highlighted: { bg_image: img })
}

Teacup.handler UIButton, :bg_highlighted { |img|
  NSLog("SWEETTEA WARNING: The :bg_highlighted handler is deprecated in favor of highlighted: { bg_image: img }")
  Teacup.apply(self, highlighted: { bg_image: img })
}

Teacup.handler UIButton, :bg_selected { |img|
  NSLog("SWEETTEA WARNING: The :bg_selected handler is deprecated in favor of selected: { bg_image: img }")
  Teacup.apply(self, selected: { bg_image: img })
}

Teacup.handler UIButton, :bg_disabled { |img|
  NSLog("SWEETTEA WARNING: The :bg_disabled handler is deprecated in favor of disabled: { bg_image: img }")
  Teacup.apply(self, disabled: { bg_image: img })
}


# UIDatePicker
#
Teacup.handler UIDatePicker, :mode, :datePickerMode { |mode|
  mode = mode.uidatepickermode if mode.is_a? Symbol
  self.setDatePickerMode(mode)
}


# UIImageView
#
# image is handled by UIView, so that it can be used by subclasses of UIView
# that take an image

# UILabel
#
Teacup.alias UILabel, :autoshrink => :adjustsFontSizeToFitWidth
Teacup.alias UILabel, :minimumSize => :minimumFontSize

Teacup.handler UILabel, :shadowColor { |color|
  self.shadowColor = color.uicolor
}

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

# UINavigationBar
#
Teacup.handler UINavigationBar, :backgroundImage { |styles|
  styles.each do |metric, image|
    metric = metric.uibarmetrics if metric.is_a? Symbol
    self.setBackgroundImage(image.uiimage, forBarMetrics:metric)
  end
}


# UITableView
#
Teacup.handler UITableView, :separatorStyle, :separator { |separator|
  separator = separator.uitablecellseparatorstyle if separator.is_a? Symbol
  self.separatorStyle = separator
}


# UITextField
#
Teacup.alias UITextView, :secure => :secureTextEntry

Teacup.handler UITableView, :separatorStyle, :separator { |separator|
  separator = separator.uitablecellseparatorstyle if separator.is_a? Symbol
  self.separatorStyle = separator
}

Teacup.handler UITextField, :keyboardType { |type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  self.setKeyboardType(type)
}

Teacup.handler UITextField, :returnKeyType, :returnKey, :returnkey { |type|
  type = type.uireturnkey if type.is_a? Symbol
  self.setReturnKeyType(type)
}

Teacup.handler UITextField, :secure { |is_secure|
  self.secureTextEntry = is_secure
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


# UITextView
#
Teacup.alias UITextView, :secure => :secureTextEntry

Teacup.handler UITextView, :keyboardType { |type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  self.setKeyboardType(type)
}

Teacup.handler UITextView, :returnKeyType, :returnKey, :returnkey { |type|
  type = type.uireturnkey if type.is_a? Symbol
  self.setReturnKeyType(type)
}

Teacup.handler UITextView, :secure { |is_secure|
  self.secureTextEntry = is_secure
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
