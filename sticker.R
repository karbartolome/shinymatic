library(hexSticker)
library(desc)
library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Sacramento", "shinymatic_font")
font_add_google("Fredericka the Great", "shinymatic_font")
font_add_google("Quantico", "shinymatic_font")

## Automatically use showtext to render text for future devices
showtext_auto()

sticker("images/icon.png",	
        package = 'shinymatic',
        p_color = 'white',
        p_size = 150,
        p_family = 'shinymatic_font', 
        h_fill = "#636d80",# '#480a8a',
        h_color = 'white', 
        s_width=0.55,
        s_x = 1,
        s_y = 0.75,
        dpi=2000,
        filename = "sticker.png")

usethis::use_build_ignore(
  c("images/icon.png", "sticker.R", "sticker.png"))
