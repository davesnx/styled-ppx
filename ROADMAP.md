# ROADMAP

The idea is to create a tool that makes styling inside Reason and OCaml a great experience.

The tool that we use to keep track of all of this is Github Projects: [styled-ppx/projects](https://github.com/davesnx/styled-ppx/projects)

Currently we have 3 fronts:

### Main: Creates the APIs needed for supporting all emotion functionality, such as:
- dynamic components
- reference other components
- define any html tag
https://github.com/davesnx/styled-ppx/projects/1

### Support all CSS Properties: An effort to sync with bs-emotion and bs-css to make all css type-safe
- fallback to `unsafe` for unsupported CSS props
https://github.com/davesnx/styled-ppx/projects/3

### External: Some other needs that would make the enviroment much better
- Fully support VSCode (there is a syntax highlight bug)
- Create Editor alias, such as VSCode
- CSS highlight in VSCode
- Explore React Native or Revery
