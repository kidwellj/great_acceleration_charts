# Install and load necessary libraries --------------------------------------
library(readxl)
library(ggplot2)
library(gridExtra)

# Set up paths in case they haven't already been created for our workspace --------------------------------------

if (dir.exists("data") == FALSE) {
  dir.create("data")
}

# Import Excel file with various sheets into R --------------------------------------

file_path <- ('data/IGBPGreatAccelerationdatacollection_clean.xlsx')
sheet_names <- excel_sheets(file_path)
all_sheets <- lapply(sheet_names, function(sheet) read_excel(file_path, sheet = sheet, col_names = c("Year", "X"), skip = 1))
names(all_sheets) <- sheet_names

# Create line charts for each sheet --------------------------------------
plots <- lapply(sheet_names, function(sheet) {
  ggplot(all_sheets[[sheet]], aes(x = Year, y = X)) +
    geom_line() +
    labs(title = paste(sheet), x = "", y = "") +
    theme_minimal(base_size = 9)
})

# Arrange the plots as a faceted chart --------------------------------------
plot <- grid.arrange(grobs = plots, ncol = 6)  # Adjust the number of columns as needed

# Save chart to PNG file --------------------------------------
ggsave("great_acceleration.png", plot, width = 2400, height = 1200, dpi = 150, units = "px", )
