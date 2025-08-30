# Contributing to Ledge

First off, thanks for taking the time to contribute! 🎉

The following is a set of guidelines for contributing to Ledge, which is hosted on GitHub. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to project maintainers.

## What should I know before I get started?

### Project Overview

Ledge is a sophisticated Flutter expense tracking application that embodies Vercel's minimalist design philosophy. It features:

- Clean, minimalist UI with monochrome aesthetic
- Vibrant data visualizations for expense tracking
- Offline-first architecture with local storage
- Light/dark theme support
- Multi-currency support

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
├── providers/                # State management
├── screens/                  # Main screens
├── widgets/                  # Reusable components
└── services/                 # Business logic
```

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for Ledge. Following these guidelines helps maintainers and the community understand your report, reproduce the behavior, and find related reports.

Before creating bug reports, please check the issue tracker as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title** for the issue to identify the problem.
- **Describe the exact steps which reproduce the problem** in as many details as possible.
- **Provide specific examples to demonstrate the steps**. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples.
- **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
- **Explain which behavior you expected to see instead and why.**
- **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem.
- **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for Ledge, including completely new features and minor improvements to existing functionality.

Before creating enhancement suggestions, please check the issue tracker as you might find out that you don't need to create one. When you are creating an enhancement suggestion, please include as many details as possible:

- **Use a clear and descriptive title** for the issue to identify the suggestion.
- **Provide a step-by-step description of the suggested enhancement** in as many details as possible.
- **Provide specific examples to demonstrate the steps**.
- **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
- **Include screenshots and animated GIFs** which help you demonstrate the steps or point out the part of Ledge which the suggestion is related to.
- **Explain why this enhancement would be useful** to most Ledge users.

### Your First Code Contribution

Unsure where to begin contributing to Ledge? You can start by looking through these `beginner` and `help-wanted` issues:

- **Beginner issues** - issues which should only require a few lines of code, and a test or two.
- **Help wanted issues** - issues which should be a bit more involved than `beginner` issues.

### Pull Requests

The process described here has several goals:

- Maintain Ledge's quality
- Fix problems that are important to users
- Engage the community in working toward the best possible Ledge
- Enable a sustainable system for Ledge's maintainers to review contributions

Please follow these steps to have your contribution considered by the maintainers:

1. Follow all instructions in [the template](.github/PULL_REQUEST_TEMPLATE.md)
2. Follow the [styleguides](#styleguides)
3. After you submit your pull request, verify that all [status checks](https://help.github.com/articles/about-status-checks/) are passing

While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.

## Styleguides

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line
- When only changing documentation, include `[ci skip]` in the commit title

### Dart Styleguide

All Dart code must adhere to [Flutter's official style guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).

### Documentation Styleguide

- Use [Markdown](https://daringfireball.net/projects/markdown).
- Reference methods and classes in markdown with inline code formatting (single backticks).
- When referring to a method or class that is in the same package, add a link to the API docs.

## Additional Notes

### Issue and Pull Request Labels

This section lists the labels we use to help us track and manage issues and pull requests.

- `bug` - Issues that are bugs.
- `enhancement` - Issues that are feature requests.
- `documentation` - Issues or pull requests related to documentation.
- `good first issue` - Good for newcomers.
- `help wanted` - Extra attention is needed.
- `beginner` - Less complex issues which would be good first issues.
- `duplicate` - This issue or pull request already exists.
- `invalid` - This doesn't seem right.
- `wontfix` - This will not be worked on.

## Getting Started

1. Fork the repository on GitHub
2. Clone the forked repository to your machine
3. Create a new branch for your feature or bug fix
4. Make your changes
5. Write tests if applicable
6. Run the existing test suite to ensure nothing is broken
7. Commit your changes using clear, descriptive commit messages
8. Push your changes to your fork
9. Submit a pull request to the main repository

Thank you for contributing to Ledge!