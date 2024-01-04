# export images to 1272px x 764px for the newsletter
# csc logo is positioned after the fact left aligned
# offset by 75px and centered vertically
# csc logo is UBCO-CSC-Icon-Colour.png
# from https://github.com/csc-ubc-okanagan/communications/blob/main/csc-media-assets/UBCO-CSC-Icon-Colour.png

library(gapminder)
library(ggplot2)

colours = c("#B8CDE6",
            "#8CACD4",
            "#6785AB",
            "#2E4C6D",
            "#002145")

ggplot(gapminder) +
  geom_point(aes(x = log10(gdpPercap), y = lifeExp, colour = continent, size = pop), alpha = 0.7) +
  coord_flip() +
  scale_colour_manual(values = colours) +
  scale_size(range = c(1,18)) +
  theme_void() +
  theme(
    legend.position = "none"
  )
