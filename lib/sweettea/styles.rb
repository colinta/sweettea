Teacup::Stylesheet.new :sweettea do
  style :UILabel,
    font: :system.uifont(17),
    numberOfLines: 1,
    minimumFontSize: 10,
    autoshrink: true,
    baseline: :alignbaselines,
    lineBreakMode: :tailtruncation.uilinebreakmode,
    alignment: :left.uialignment,
    text:
    color: :black,
    backgroundColor: :clear

end
