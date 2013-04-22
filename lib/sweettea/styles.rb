Teacup::Stylesheet.new :sweettea do

  style :label,
    font: :system.uifont(17),
    numberOfLines: 1,
    minimumFontSize: 10,
    autoshrink: true,
    baseline: :alignbaselines,
    lineBreakMode: :tailtruncation,
    alignment: :left,
    color: :black,
    opaque: false,
    backgroundColor: :clear

  style :input,
    font: :system.uifont(14),
    color: :black,
    border: :rounded,
    alignment: :left,
    opaque: false,
    backgroundColor: :clear

  style :name_input, extends: :input,
    keyboardType: UIKeyboardTypeDefault,
    autocapitalizationType: UITextAutocapitalizationTypeWords,
    autocorrectionType: UITextAutocorrectionTypeNo,
    spellCheckingType: UITextSpellCheckingTypeNo

  style :ascii_input, extends: :input,
    keyboardType: UIKeyboardTypeASCIICapable

  style :email_input, extends: :input,
    keyboardType: UIKeyboardTypeEmailAddress,
    autocapitalizationType: UITextAutocapitalizationTypeNone,
    autocorrectionType: UITextAutocorrectionTypeNo,
    spellCheckingType: UITextSpellCheckingTypeNo

  style :url_input, extends: :input,
    keyboardType: UIKeyboardTypeURL,
    autocapitalizationType: UITextAutocapitalizationTypeNone,
    autocorrectionType: UITextAutocorrectionTypeNo,
    spellCheckingType: UITextSpellCheckingTypeNo

  style :number_input, extends: :input,
    keyboardType: UIKeyboardTypeNumberPad

  style :phone_input, extends: :input,
    keyboardType: UIKeyboardTypePhonePad

  style :secure_input, extends: :input,
    secureTextEntry: true

  # button images from http://nathanbarry.com/designing-buttons-ios5/
  # thanks, nathan!
  style :tan_button,
    normal: { bg_image: 'tanButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'tanButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :black_button,
    normal: { bg_image: 'blackButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'blackButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :green_button,
    normal: { bg_image: 'greenButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'greenButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :orange_button,
    normal: { bg_image: 'orangeButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'orangeButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :blue_button,
    normal: { bg_image: 'blueButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'blueButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :white_button,
    normal: { bg_image: 'whiteButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'whiteButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

  style :gray_button,
    normal: { bg_image: 'greyButton'.uiimage.stretchable([18, 18, 18, 18]) },
    highlighted: { bg_image: 'greyButtonHighlight'.uiimage.stretchable([18, 18, 18, 18]) }

end
