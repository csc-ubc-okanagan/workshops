# export images to 1272px x 764px for the newsletter
# csc logo is positioned after the fact left aligned
# offset by 75px and centered vertically
# csc logo is UBCO-CSC-Icon-Colour.png
# from https://github.com/csc-ubc-okanagan/communications/blob/main/csc-media-assets/UBCO-CSC-Icon-Colour.png

library(ggplot2)

colours = c("#B8CDE6",
            "#8CACD4",
            "#6785AB",
            "#2E4C6D",
            "#002145")

my_data <- data.frame(
  x = c(1, 5, 10, 5, 1),
  y = factor(c("a", "b", "c", "d", "e"))
)

ggplot(my_data, aes(x = y, y = x, fill = y)) +
  geom_col() +
  scale_fill_manual(values = colours) +
  theme_void() +
  theme(
    legend.position = "none"
  )
