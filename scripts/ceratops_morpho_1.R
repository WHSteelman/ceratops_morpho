# install required packages if necessary
# install.packages("geomorph")
# install.packages("StereoMorph")

# Load packages
library(StereoMorph)
library(geomorph)

# Digitize images
digitizeImages(image.file = "ceratops_images", shapes.file = "ceratops_shapes", landmarks.ref = "landmarks.txt", curves.ref = "curves.txt")

# Read the landmark data 
landmark_data <- readShapes("ceratops_shapes")

# Extract the landmark points only
landmark_array <- landmark_data$landmarks.scaled

# Conduct Generalized Procrustes Analysis
landmark_gpa <- gpagen(landmark_array)

# Plot the results
plot(landmark_gpa)
mtext("GPA")

# Conduct Principle Component Analysis
landmark_pca <- gm.prcomp(landmark_gpa$coords)

# Plot the results
specimens <- dimnames(landmark_array)[[3]]
plot(landmark_pca)
text(landmark_pca, labels = specimens, pos = 1)
mtext("PCA")



M <- mshape(landmark_gpa$coords)

par(mfrow=c(1,2))
plotRefToTarget(M,landmark_gpa$coords[,,2])
mtext("TPS")

par(mfrow=c(1,1))

par(mfrow=c(1,2))
plotRefToTarget(M,landmark_gpa$coords[,,2], method="vector", mag=3)
mtext("Vector Displacements")

