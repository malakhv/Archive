# Modules and Packages

This article describes naming conventions for app's modules and packages. Following these conventions is mandatory for all project parts (except website).

## Packages
The main app's package should have following prefix: `com.devlear.apps` or `com.devlear`.

The module's package name should construct like package in Android, but we should use `com.devlear` or `com.malakhv` instead of `android`. For example:
- `android.app.*` -> `com.devlear.app.*` (`com.devlear.app.MyApp`)
- `android.util.*` -> `com.malakhv.util.*` (`com.malakhv.util.LogCat`)
- `android.widget.*` -> `com.devlear.widget.*` (`com.devlear.widget.InfoCard`)

## Modules:
- `app` - common app's components
- `beer` - the main app's module (other names: hub/app)
- `crypto` - wrapper for external native CryptoPro library
- `utils` - any common utilities
- `widgets` - any common ui elements (widgets)

### Module - beer
The module's package is` com.devlear.beerhub`. Packages inside module:
- `billing` - all things about payments
- `content` - app’s content (content manager, external app resources, etc)
- `data` - app’s database and related data structures
- `map` - app’s map engine
- `model` - app’s data model and related classes
- `settings` - app’s settings
- `test` - test infrastructure
- `user` - all about user interface (activities, fragments, etc) except common view/widgets classes.
- `util` - some independent utilities (candidates to move to separate external library).

### Module - crypto
The module's package is `com.devlear.libs.crypto`.

### Module - utils
Module with some independent utilities (candidates to move to separate external library). The module's package is `com.devlear.util`.

### Module - widgets
The module's package is `com.devlear.widgets`.
