library(httpuv)

library(shinylive)

fs::dir_delete("docs")

fs::dir_create("docs")

shinylive::export(appdir = "dateselect",
                  destdir = "docs",
                  subdir = "")

httpuv::runStaticServer("docs")









