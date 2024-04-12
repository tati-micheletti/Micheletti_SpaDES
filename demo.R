# Available at: https://tinyurl.com/webinarEFI

# Before Starting:

# 1. Install/Update R: 4.3.2

# 2. Make sure you have the support for the spatial package 'terra'. Depending on 
# your system, you will need to install GDAL libraries and Rcpp before running the 
# script, in other cases, 'terra' will take care of it.
# Please see details for installing these here: https://rspatial.github.io/terra/

# 3. Setting the project's directory. A folder named integratingSpaDESmodules will be created in it with all project elements
setwd("~") # here please set the home folder where the demo should live. 

# /!\ IMPORTANT /!\  Please Make sure the current file is saved in the folder specified above
message(paste0("Please Make sure the current file is saved in the folder specified above (",getwd(),")"))

# 4. Run the code:

##################### PART I: Install the installers

getOrUpdatePkg <- function(p, minVer = "0") {
  if (!isFALSE(try(packageVersion(p) < minVer, silent = TRUE) )) {
    repo <- c("predictiveecology.r-universe.dev", getOption("repos"))
    install.packages(p, repos = repo)
  }
}

getOrUpdatePkg("remotes")

remotes::install_github("PredictiveEcology/Require", ref = "a2c60495228e3a73fa513435290e84854ca51907", upgrade = FALSE)

getOrUpdatePkg("SpaDES.project", "0.0.8.9040")




##################### PART II: Download the modules and install the needed packages

Setup <- SpaDES.project::setupProject(
  
  paths = list(projectPath = "integratingSpaDESmodules",
               modulePath = "SpaDES_Modules",
               outputPath = "outputs"),
  
  modules = c("tati-micheletti/speciesAbundance@main",
              "tati-micheletti/temperature@main",
              "tati-micheletti/speciesAbundTempLM@main"),
  
  times = list(start = 2013,
               end = 2032),
  
  Restart = TRUE
)



##################### PART III: Run SpaDES

results <- do.call(SpaDES.core::simInitAndSpades, Setup)
