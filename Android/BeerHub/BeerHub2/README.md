# BeerHub
The world wide beer guide!

## The project directory structure

Please follow rules on this section and do not create new directories in the root of the project.

The project directory structure:
- `apps` - main code base (except external tools, libs and web) for all supported platform.
    - `android` - source code of Android app
    - `ios` - source code of iOS app
    - `mac` - source code of Mac app
    - `shared` - shared source code
    - `win` - source code of Windows app
- `content` - the app's content and tools to its generation.
    - `source` - the app's content source files. All these files will be included in app.
- `data` - the app's database and related tools.
- `dev` - some development tools, templates, manuals, etc.
    - `templates` - any templates for development
- `external` - some external (our own and another) prebuilt tools, libs, etc.
- `help` - the user manual and related tools.
- `media` - any common media files (project logo, for example).
- `store` - any files for application stores
    - `apple` - files for Apple AppStore
    - `google` - files for Google PlayStore
- `tools` - some tools external for this project.
- `web` - source code of project web site.
- `README.MD` - this file includes project description and information about project directory structure.
