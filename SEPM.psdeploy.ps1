Deploy "SEPM" {
    By PSGalleryModule {
        FromSource "$PSScriptRoot\_output\SEPM"
        To "SFGallery"
    }
}
