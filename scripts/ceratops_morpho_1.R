# install required packages if necessary
# install.packages("geomorph")
# install.packages("StereoMorph")

# Load packages
library(StereoMorph)
library(geomorph)

# Digitize images
digitizeImages(image.file = "ceratops_images", shapes.file = "ceratops_shapes", landmarks.ref = "landmarks.txt", curves.ref = "curves.txt")

# Read the landmark data 
#landmark_data <- read.csv("ceratops_landmarks.csv")
landmark_data <- readShapes("ceratops_shapes")

# Define the species names
#species_names <- c("Triceratops", "Protoceratops")
# Add row names to the matrix
#rownames(landmark_data) <- species_names

# Print matrix
print(landmark_data)

# Convert the data into a 3D array
landmark_array <- arrayspecs(landmark_data, 22, 2)

# Print array
print(landmark_array)

# Write the data into a .tps format for future use
# writeland.tps(landmark_array, "ceratops_landmarks.tps")

# Conduct Generalized Procrustes Analysis
landmark_gpa <- gpagen(landmark_array)

summary(landmark_gpa)

attributes(landmark_gpa)

# Plot the results
plot(landmark_gpa)
mtext("GPA")

# Conduct Principle Component Analysis
landmark_pca <- gm.prcomp(landmark_gpa$coords)

summary(landmark_pca)

attributes(landmark_pca)

# Plot the results
plot(landmark_pca)



M <- mshape(landmark_gpa$coords)

par(mfrow=c(1,2))
plotRefToTarget(M,landmark_gpa$coords[,,2])
mtext("TPS")

par(mfrow=c(1,1))

par(mfrow=c(1,2))
plotRefToTarget(M,landmark_gpa$coords[,,2], method="vector", mag=3)
mtext("Vector Displacements")




# Load packages
library(StereoMorph)
library(geomorph)

# Digitize images
digitizeImages(image.file = "Data/ceratops_images", shapes.file = "Data/ceratops_shapes", landmarks.ref = "Data/landmarks.txt", curves.ref = "Data/curves.txt")
