# please organize by hierarchy and alphabetically, double spaces between classes

# the Helpers
#
module Sweettea
  module_function

  def uibutton_state_handler(target, properties, state)
    actual_state = state.is_a?(Symbol) ? state.uicontrolstate : state
    properties.each do |property, value|
      if property == :image || property == :bg_image || property == :backgroundImage
        if value
          value = Sweettea.get_image_and_rect(target, value, target.contentEdgeInsets)
        end
      end

      case property
      when :title
        target.setTitle(value.localized, forState:actual_state)
      when :attributed
        target.setAttributedTitle(value, forState:actual_state)
      when :color
        target.setTitleColor(value && value.uicolor, forState:actual_state)
      when :shadow
        target.setTitleShadowColor(value && value.uicolor, forState:actual_state)
      when :bg_image, :backgroundImage
        target.setBackgroundImage(value && value.uiimage, forState:actual_state)
      when :image
        target.setImage(value && value.uiimage, forState:actual_state)
      else
        NSLog "SWEETTEA WARNING: Can't apply #{value.inspect} to #{property.inspect} forState: #{state.inspect} to #{target.inspect}"
      end
    end
  end

  def get_image_and_rect(view, img, insets=nil)
    return nil unless img

    image = img.uiimage
    if img && ! image
      NSLog("WARN: Could not find #{img.inspect}")
      return nil
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

end

# the Views
#
Teacup.handler UIView, :backgroundColor, :background { |view, color|
  view.backgroundColor = color.uicolor
}

Teacup.alias UIView, :clips => :clipsToBounds

Teacup.handler UIView, :contentMode { |view, mode|
  mode = mode.uicontentmode if mode.is_a?(Symbol)
  view.contentMode = mode
}

Teacup.handler UIView, :autoresizingMask, :autoresizing { |view, masks|
  if masks.is_a? Enumerable
    actual_mask = 0
    masks.each do |mask|
      mask = mask.uiautoresizemask if mask.is_a? Symbol
      actual_mask |= mask
    end
  elsif masks.is_a? Symbol
    actual_mask = masks.uiautoresizemask
  else
    actual_mask = masks
  end
  view.autoresizingMask = actual_mask
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
      if key == :color && CFGetTypeID(value) != CGColorGetTypeID()
        value = value.uicolor.CGColor
      end
      NSLog "Setting layer.#{msg} = #{value.inspect}" if view.respond_to? :debug and view.debug
      view.layer.send(msg, value)
      view.layer.masksToBounds = false
    end
  }
}

Teacup.handler UIView, :sizeToFit { |view, truthy|
  view.sizeToFit if truthy
}

# you would think this should be on UIImageView, but you can't subclass
# UIImageView, and any subclass of UIView that has an image will find this
# handler helpful.
Teacup.handler UIView, :image { |view, img|
  if img == nil
    image = nil
  else
    image = Sweettea.get_image_and_rect(view, img)
  end
  view.image = image
}

# Here again, tintColor is not actually defined on UIView, but it is defined on
# so many subclass that it just makes sense to me to have it everywhere.
Teacup.handler UIView, :tint, :tintColor { |view, color|
  view.tintColor = color.uicolor
}


# CALayer
#
Teacup.handler CALayer, :backgroundColor, :background { |view, color|
  if color && CFGetTypeID(color) != CGColorGetTypeID()
    color = color.uicolor.CGColor
  end
  view.backgroundColor = color
}

Teacup.handler CALayer, :borderColor, :border { |view, color|
  if color && CFGetTypeID(color) != CGColorGetTypeID()
    color = color.uicolor unless color.is_a?(UIColor)
    color = color.CGColor
  end
  view.borderColor = color
}


# UIActivityIndicatorView
#
Teacup.handler UIActivityIndicatorView, :color { |view, color|
  view.color = color.uicolor
}

Teacup.handler UIActivityIndicatorView, :animating, :isAnimating { |view, animating|
  if animating
    view.startAnimating
  else
    view.stopAnimating
  end
}

Teacup.handler UIActivityIndicatorView, :activityIndicatorViewStyle, :style { |view, style|
  style = style.uiactivityindicatorstyle unless style.is_a?(Fixnum)
  view.activityIndicatorViewStyle = style
}


# UIButton
#
Teacup.handler UIButton, :font { |view, font|
  view.titleLabel.font = font && font.uifont
}

# for backwards compatibility - Teacup defines this *without* the UIColor
# coercion.
Teacup.handler UIButton, :titleColor { |target, color|
  target.setTitleColor(color.uicolor, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :normal { |view, values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {normal: image} handler is deprecated in favor of normal: { image: image }")
    values = { image: values }
  end
  Sweettea.uibutton_state_handler(view, values, :normal)
}

Teacup.handler UIButton, :disabled { |view, values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {disabled: image} handler is deprecated in favor of disabled: { image: image }")
    values = { image: values }
  end
  Sweettea.uibutton_state_handler(view, values, :disabled)
}

Teacup.handler UIButton, :selected { |view, values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {selected: image} handler is deprecated in favor of selected: { image: image }")
    values = { image: values }
  end
  Sweettea.uibutton_state_handler(view, values, :selected)
}

Teacup.handler UIButton, :highlighted { |view, values|
  unless values.is_a?(Hash)
    NSLog("SWEETTEA WARNING: The {highlighted: image} handler is deprecated in favor of highlighted: { image: image }")
    values = { image: values }
  end
  Sweettea.uibutton_state_handler(view, values, :highlighted)
}

Teacup.handler UIButton, :textColor, :color { |view, color|
  # this one is too handy to be deprecated.
  Sweettea.uibutton_state_handler(view, { color: color }, :normal)
}

Teacup.handler UIButton, :image { |view, img|
  # this one is too handy to be deprecated.
  Sweettea.uibutton_state_handler(view, { image: img }, :normal)
}

Teacup.handler UIButton, :bg_image { |view, img|
  # this one is too handy to be deprecated.
  Sweettea.uibutton_state_handler(view, { bg_image: img }, :normal)
}

Teacup.handler UIButton, :pushed { |view, img|
  NSLog("SWEETTEA WARNING: The :pushed handler is deprecated in favor of highlighted: { image: img }")
  Sweettea.uibutton_state_handler(view, { image: img }, :highlighted)
}

Teacup.handler UIButton, :bg_pushed { |view, img|
  NSLog("SWEETTEA WARNING: The :bg_pushed handler is deprecated in favor of highlighted: { bg_image: img }")
  Sweettea.uibutton_state_handler(view, { bg_image: img }, :highlighted)
}

Teacup.handler UIButton, :bg_highlighted { |view, img|
  NSLog("SWEETTEA WARNING: The :bg_highlighted handler is deprecated in favor of highlighted: { bg_image: img }")
  Sweettea.uibutton_state_handler(view, { bg_image: img }, :highlighted)
}

Teacup.handler UIButton, :bg_selected { |view, img|
  NSLog("SWEETTEA WARNING: The :bg_selected handler is deprecated in favor of selected: { bg_image: img }")
  Sweettea.uibutton_state_handler(view, { bg_image: img }, :selected)
}

Teacup.handler UIButton, :bg_disabled { |view, img|
  NSLog("SWEETTEA WARNING: The :bg_disabled handler is deprecated in favor of disabled: { bg_image: img }")
  Sweettea.uibutton_state_handler(view, { bg_image: img }, :disabled)
}

Teacup.handler UIButton, :titlePadding { |target, padding|
  target.setTitleEdgeInsets(padding) # padding can be a UIEdgeInset or an array of four numbers
}

# UIDatePicker
#
Teacup.handler UIDatePicker, :mode, :datePickerMode { |view, mode|
  mode = mode.uidatepickermode if mode.is_a? Symbol
  view.setDatePickerMode(mode)
}


# UIImageView
#
# image is handled by UIView, so that it can be used by subclasses of UIView
# that take an image

# UILabel
#
Teacup.alias UILabel, :autoshrink => :adjustsFontSizeToFitWidth
Teacup.alias UILabel, :minimumSize => :minimumFontSize

Teacup.handler UILabel, :shadowColor { |view, color|
  view.shadowColor = color.uicolor
}

Teacup.handler UILabel, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UILabel, :font { |view, font|
  view.font = font && font.uifont
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

# UINavigationBar
#
Teacup.handler UINavigationBar, :backgroundImage { |view, styles|
  styles.each do |metric, image|
    metric = metric.uibarmetrics if metric.is_a? Symbol
    view.setBackgroundImage(image && image.uiimage, forBarMetrics:metric)
  end
}


# UITableView
#
Teacup.handler UITableView, :separatorStyle, :separator { |view, separator|
  separator = separator.uitablecellseparatorstyle if separator.is_a? Symbol
  view.separatorStyle = separator
}


# UITableViewCell
#
Teacup.handler UITableViewCell, :selectionStyle { |view, selection|
  selection = selection.uitablecellselectionstyle if selection.is_a? Symbol
  view.selectionStyle = selection
}


# UITextField
#
Teacup.alias UITextField, :secure => :secureTextEntry

Teacup.handler UITableView, :separatorStyle, :separator { |view, separator|
  separator = separator.uitablecellseparatorstyle if separator.is_a? Symbol
  view.separatorStyle = separator
}

Teacup.handler UITextField, :keyboardType, :keyboard { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType(type)
}

Teacup.handler UITextField, :returnKeyType, :returnKey, :returnkey { |view, type|
  type = type.uireturnkey if type.is_a? Symbol
  view.setReturnKeyType(type)
}

Teacup.handler UITextField, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UITextField, :font { |view, font|
  view.font = font && font.uifont
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
  view.background = image && image.uiimage
}


# UITextView
#
Teacup.alias UITextView, :secure => :secureTextEntry

Teacup.handler UITextView, :keyboardType, :keyboard { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType(type)
}

Teacup.handler UITextView, :returnKeyType, :returnKey, :returnkey { |view, type|
  type = type.uireturnkey if type.is_a? Symbol
  view.setReturnKeyType(type)
}

Teacup.handler UITextView, :textColor, :color { |view, color|
  view.textColor = color.uicolor
}

Teacup.handler UITextView, :font { |view, font|
  view.font = font && font.uifont
}

Teacup.handler UITextView, :textAlignment, :alignment { |view, alignment|
  alignment = alignment.uitextalignment if alignment.is_a? Symbol
  view.textAlignment = alignment
}
