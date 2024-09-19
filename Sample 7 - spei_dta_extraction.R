# Install and load the necessary package
install.packages("ncdf4")
library(ncdf4)

# Open the NetCDF file
nc_file <- nc_open("path_to/spei01.nc")

# Print the file summary to see the variables and dimensions
print(nc_file)

# Extract the variables
spei <- ncvar_get(nc_file, "spei")

lon <- ncvar_get(nc_file, "lon")
lat <- ncvar_get(nc_file, "lat")
time <- ncvar_get(nc_file, "time")

# Close the NetCDF file
nc_close(nc_file)

# Convert the extracted data to a data frame
spei_data <- data.frame(
  time = rep(time, each = length(lat) * length(lon)),
  lat = rep(rep(lat, each = length(lon)), times = length(time)),
  lon = rep(lon, times = length(lat) * length(time)),
  spei = as.vector(spei)
)

# Preview the data frame
head(spei_data)

# Save the data frame as a CSV file
write.csv(spei_data, "path_to/spei_data.csv", row.names = FALSE)

# Confirm that the file has been saved
cat("CSV file saved successfully.")