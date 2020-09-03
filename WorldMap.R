library(tidyverse)
library(sf)
library(rnaturalearth)

# NOTE: May need to install "rgeos" and "rnaturalearthdata" the first time you use the code.
install.packages("rgeos")
install.packages("rnaturalearthdata")

robCRS <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
lonlatCRS <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

# Download and process world outline
world <- ne_countries(scale = "medium", returnclass = "sf") %>% # Load world outline as sf
  st_transform(crs = st_crs(robCRS)) # Convert to different CRS

# You could add the ocean as a different colour background
# ocean <- ne_download(scale = "medium", type = "ocean", category = "physical", returnclass = "sf") %>%
  # st_transform(ocean, crs = st_crs(robCRS)) # Convert to different CRS

df <- tibble(lat = c(-34, -42, 20, 0), lon = c(156, 100, -20, -160), weight = c(1, 2, 3, 4)) %>%  # Create some dummy data
  st_as_sf(coords = c("lon", "lat"), crs = st_crs(lonlatCRS)) %>% # Convert to an sf object
  st_transform(df_sf, crs = st_crs(robCRS)) # Convert to different CRS

gg <- ggplot() +
  # geom_sf(data = ocean, fill = "lightblue") +
  geom_sf(data = df, aes(colour = weight)) +
  geom_sf(data = world, size = 0.05, fill = "grey20") +
  ggtitle("World Map with Robinson Projection") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(panel.background = element_blank())

gg
