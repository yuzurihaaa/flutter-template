1. Run `make init` to initialize this project.

# {{appName}} 

A new Flutter project.

## Architecture

- `lib` - main directory for the project
- `lib/components/<widgets.dart>` - shared widget accross all app
- `lib/modules` - business logic related to the feature/module
- `lib/modules/\<module>/components/<widgets.dart>` - shared widget specific for the feature/module
- `lib/modules/\<module>/components/<widgets.dart>` - shared widget specific for the feature/module
- `lib/modules/\<module>/components/<module_model.dart>` - shared model specific for the feature/module
- `lib/modules/\<module>/components/<module_query.dart>` - shared query / logic specific for the feature/module
- `lib/modules/\<module>/components/<module_repository.dart>` - shared repository / data logic specific for the feature/module
- `lib/pages` - screens widget
- `lib/services` - IO logics. Typically native / library features that needs to be encapsulated.
- `lib/utils` - utilities for the app (for module specific utilities, use `lib/modules/\<module>` instead)
- Unit test is expected to follow directory structures as in `lib/`
