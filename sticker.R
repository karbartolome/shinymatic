library(hexSticker)
library(showtext)
font_add_google("Sacramento", "shinymatic_font")
sticker("images/icon.png",	
        package = 'shinymatic',
        p_color = 'white',
        p_size = 150,
        p_family = 'shinymatic_font', 
        h_fill = "#34294d", 
        h_color = '#e0e0e0', 
        s_width=0.7,
        s_x = 1,
        s_y = 0.9,
        dpi=2000,
        filename = "man/figures/logo.png")

usethis::use_build_ignore(
  c("images/icon.png", "sticker.R", "sticker.png"))
