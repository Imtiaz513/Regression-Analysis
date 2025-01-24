########
# Removing the first two rows
remove(data)
data<-responses_1_
# Remove the first column
data <- data[, -1]
# Remove the last column
data <- data[, -ncol(data)]
str(data)
library(dplyr)
library(stringr)

# Assuming `data` is your dataset

# Step 1: Store original variable names as labels
labels <- colnames(data)

# Step 2: Programmatically shorten variable names
# Remove spaces, special characters, and make concise names
shortened_names <- labels %>%
  str_replace_all("\\s+", "_") %>%  # Replace spaces with underscores
  str_replace_all("[^[:alnum:]_]", "") %>%  # Remove non-alphanumeric characters
  str_sub(1, 30)  # Limit to 30 characters for brevity

# Step 3: Rename variables and add labels
data <- data %>%
  rename_with(~ shortened_names, everything())

# Step 4: Add a `label` column to store original names
data_labels <- tibble(
  variable = shortened_names,
  label = labels
)

# View updated data and labels
print(data)
print(data_labels)

