# please organize by hierarchy and alphabetically, double spaces between classes

# the Helpers
#
def get_image_and_rect(view, img)
  image = img.uiimage
  if not image
    NSLog("WARN: Could not find #{img.inspect}")
    return
  end
  raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

  if view.frame.size.width == 0 and view.frame.size.height == 0
    view.frame = [view.frame.origin, image.size]
  end
  return image
end

# the Views
#
Teacup.handler UIView, :backgroundColor, :background { |view, color|
  view.backgroundColor = color.uicolor
}

Teacup.handler UIView, :shadow { |view, shadow|
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
      NSLog "Setting layer.#{msg} = #{value.inspect}" if view.respond_to? :debug and view.debug
      view.layer.send(msg, value)
      view.layer.masksToBounds = false
      view.layer.shouldRasterize = true
    end
  }
}


Teacup.handler UIActivityIndicatorView, :color { |view, color|
  view.color = color.uicolor
}

Teacup.handler UIActivityIndicatorView, :activityIndicatorViewStyle, :style { |view, style|
  style = style.uiactivityindicatorstyle unless style.is_a?(Fixnum)
  view.activityIndicatorViewStyle = style
}


Teacup.handler UIButton, :normal, :image { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :highlighted, :pushed { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :disabled { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setImage(image, forState: UIControlStateDisabled)
}

Teacup.handler UIButton, :bg_normal, :bg_image { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setBackgroundImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :bg_highlighted, :bg_pushed { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setBackgroundImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :bg_disabled { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.setBackgroundImage(image, forState: UIControlStateDisabled)
}

Teacup.handler UIButton, :returnKeyType, :returnkey { |view, type|
  type = type.uireturnkey if type.is_a? Symbol
  view.setReturnKeyType(type)
}


Teacup.handler UIDatePicker, :mode, :datePickerMode { |view, mode|
  mode = mode.uidatepickermode if mode.is_a? Symbol
  view.setDatePickerMode(mode)
}


Teacup.handler UIImageView, :image { |view, img|
  if img == nil
    image = nil
  else
    image = get_image_and_rect(view, img)
  end
  view.image = image
}


##|
##|  UILabel
##|
Teacup.alias UILabel, :autoshrink => :adjustsFontSizeToFitWidth
Teacup.alias UILabel, :minimumSize => :minimumFontSize

Teacup.handler UILabel, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UILabel, :font { |view, font|
  view.font = font.uifont
}

Teacup.handler UILabel, :highlightedTextColor, :highlightedColor { |view, color|
  view.highlightedTextColor = color.uicolor
}

Teacup.handler UILabel, :lineBreakMode { |view, mode|
  mode = mode.uilinebreakmode if mode.is_a? Symbol
  view.lineBreakMode = mode
}

Teacup.handler UILabel, :textAlignment, :alignment { |view, alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  view.textAlignment = alignment
}

Teacup.handler UILabel, :baselineAdjustment, :baseline { |view, baseline|
  baseline = baseline.uibaselineadjustment if baseline.is_a? Symbol
  view.baselineAdjustment = baseline
}

Teacup.handler UIView, :shadow { |view, shadow|
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
      NSLog "Setting layer.#{msg} = #{value.inspect}" if view.respond_to? :debug and view.debug
      view.layer.send(msg, value)
      view.layer.masksToBounds = false
      view.layer.shouldRasterize = true
    end
  }
}


##|
##|  UINavigationBar
##|
Teacup.handler UINavigationBar, :backgroundImage { |view, styles|
  styles.each do |metric, image|
    metric = metric.uibarmetrics if metric.is_a? Symbol
    view.setBackgroundImage(image.uiimage, forBarMetrics:metric)
  end
}


##|
##|  UITextField
##|
Teacup.handler UITextField, :keyboardType { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType type
}

Teacup.handler UITextField, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UITextField, :font { |view, font|
  view.font = font.uifont
}

Teacup.handler UITextField, :textAlignment, :alignment { |view, alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  view.textAlignment = alignment
}

Teacup.handler UITextField, :borderStyle, :border { |view, border|
  border = border.uibordertype if border.is_a? Symbol
  view.borderStyle = border
}

Teacup.handler UITextField, :background { |view, image|
  view.background = image.uiimage
}


##|
##|  UITextView
##|
Teacup.handler UITextView, :keyboardType { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType type
}

Teacup.handler UITextView, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UITextView, :font { |view, font|
  view.font = font.uifont
}

Teacup.handler UITextView, :textAlignment, :alignment { |view, alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  view.textAlignment = alignment
}
