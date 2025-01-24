# Load necessary libraries
library(dplyr)

# Calculate constructs and their percentage impacts
constructs_summary <- data %>%
  group_by(resident_bedstuy) %>% # Group by resident status
  summarise(
    # Greenery
    Greenery = mean(c(safe_space, cultural_connect_space, belong_space), na.rm = TRUE),
    
    # Seating
    Seating = mean(c(comfort_enter_garden, likely_use_space), na.rm = TRUE),
    
    # Barriers
    Barriers = mean(c(safe_enter_garden, comfort_enter_garden), na.rm = TRUE),
    
    # Pathways
    Pathways = mean(c(easy_enter_garden, easy_move_space), na.rm = TRUE),
    
    # Lighting
    Lighting = mean(c(safe_space, good_space_use), na.rm = TRUE),
    
    # Signage
    Signage = mean(c(belong_space, cultural_connect_space), na.rm = TRUE),
    
    # Hazards
    Hazards = mean(c(safe_enter_space_2, likely_use_space_2), na.rm = TRUE),
    
    # Buildings Visible
    Buildings_Visible = mean(c(outside_comfortable_space, outside_good_space_use), na.rm = TRUE),
    
    # Street Visible
    Street_Visible = mean(c(safe_space_3, good_interact_space_3), na.rm = TRUE),
    
    # Transition
    Transition = mean(c(cultural_connect_space_3, safe_space_3), na.rm = TRUE)
  ) %>%
  mutate(
    # Calculate total impact for each group
    Total = rowSums(across(Greenery:Transition), na.rm = TRUE),
    
    # Calculate percentage impact for each construct
    Greenery_Percent = Greenery / Total * 100,
    Seating_Percent = Seating / Total * 100,
    Barriers_Percent = Barriers / Total * 100,
    Pathways_Percent = Pathways / Total * 100,
    Lighting_Percent = Lighting / Total * 100,
    Signage_Percent = Signage / Total * 100,
    Hazards_Percent = Hazards / Total * 100,
    Buildings_Visible_Percent = Buildings_Visible / Total * 100,
    Street_Visible_Percent = Street_Visible / Total * 100,
    Transition_Percent = Transition / Total * 100
  )

# View the summary table
print(constructs_summary)
# Convert constructs_summary to a flextable
summary_table_ft <- flextable(constructs_summary)

# Create a Word document and add the flextable
doc <- read_docx() %>% 
  body_add_flextable(summary_table_ft) %>% 
  body_add_par("Constructs Summary Table", style = "heading 1") %>% 
  print(target = "constructs_summary.docx")

# Output message
cat("The constructs summary table has been exported to 'constructs_summary.docx'.")
