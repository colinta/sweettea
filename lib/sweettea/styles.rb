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

end
