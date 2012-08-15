# please organize by hierarchy and alphabetically, double spaces between classes

Teacup.handler UIView, :backgroundColor { |view, color|
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
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :highlighted { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :disabled { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setImage(image, forState: UIControlStateDisabled)
}

Teacup.handler UIButton, :bg_normal, :bg_image { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setBackgroundImage(image, forState: UIControlStateNormal)
}

Teacup.handler UIButton, :bg_highlighted { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setBackgroundImage(image, forState: UIControlStateHighlighted)
}

Teacup.handler UIButton, :bg_disabled { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
  end
  view.setBackgroundImage(image, forState: UIControlStateDisabled)
}

Teacup.handler UIButton, :returnKeyType, :returnkey { |view, type|
  type = type.uireturnkey if type.is_a? Symbol
  view.setReturnKeyType(type)
}


Teacup.handler UIImageView, :image { |view, img|
  if img == nil
    image = nil
  else
    image = img.uiimage
    if not image
      NSLog("WARN: Could not find #{img.inspect}")
      return
    end
    raise "Expected UIImage in Teacup handler, not #{image.inspect}" unless image.is_a?(UIImage)

    if SugarCube::CoreGraphics::Size(view.frame.size) == [0, 0]
      view.frame = SugarCube::CoreGraphics::Rect(view.frame.origin, image.size)
    end
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


Teacup.handler UITextField, :keyboardType { |view, type|
  type = type.uikeyboardtype unless type.is_a?(Fixnum)
  view.setKeyboardType type
}
