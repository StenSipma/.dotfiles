paru -S --needed astromatic-sextractor
paru -S --needed astromatic-swarp

# Dependency for scamp
# Maybe instead of lapacke, need atlas-lapack ?
sudo pacman -S --needed lapacke 
paru -S --needed plplot
paru -S --needed astromatic-scamp

# Add theli when it works (now in Project/Theli-install)
# sudo pacman -S --needed libraw
# paru -S --needed theli
