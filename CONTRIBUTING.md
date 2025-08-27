# Contributing to Polkadart

Thank you for your interest in contributing to Polkadart! We welcome contributions from developers of all skill levels. This guide will help you get started with contributing to the project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Testing Guidelines](#testing-guidelines)
- [Code Style](#code-style)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Issues](#reporting-issues)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). We are committed to providing a welcoming and inspiring community for all.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Dart SDK**: Version 3.0.0 or higher
- **Flutter** (optional): If working on Flutter-specific features
- **Git**: For version control
- **Melos**: For monorepo management (`dart pub global activate melos`)

### Fork and Clone

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/polkadart.git
   cd polkadart
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/leonardocustodio/polkadart.git
   ```

## Development Setup

### 1. Install Dependencies

Since this is a monorepo managed by Melos, run:

```bash
# Install melos globally if you haven't already
dart pub global activate melos

# Bootstrap the project (installs dependencies for all packages)
melos bootstrap
```

### 2. Verify Setup

Run the test suite to ensure everything is working:

```bash
# Run all tests
melos test

# Or test a specific package
cd packages/polkadart
dart test
```

## Project Structure

```
polkadart/
├── packages/           # Core packages
│   ├── polkadart/     # Main SDK
│   ├── polkadart_cli/ # CLI tool
│   ├── polkadart_keyring/ # Key management
│   ├── polkadart_scale_codec/ # SCALE codec
│   ├── substrate_metadata/ # Metadata parsing
│   ├── substrate_bip39/ # Mnemonic generation
│   ├── sr25519/       # SR25519 cryptography
│   ├── secp256k1_ecdsa/ # ECDSA implementation
│   ├── ss58/          # Address encoding
│   ├── ink_abi/       # ink! ABI support
│   └── ink_cli/       # ink! CLI tool
├── apps/              # Example applications
│   └── examples/      # Usage examples
├── docs/              # Documentation website
├── chain/             # Chain test data
└── README.md          # Project overview
```

## How to Contribute

### 🐛 Reporting Bugs

1. **Check existing issues** to avoid duplicates
2. **Create a new issue** with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (Dart version, OS, etc.)
   - Code examples if applicable

### 💡 Suggesting Features

1. **Check existing proposals** in issues and discussions
2. **Open a discussion** for major features
3. **Create an issue** with:
   - Use case and motivation
   - Proposed API/implementation
   - Alternative solutions considered

### 🔧 Contributing Code

#### Finding Issues to Work On

- Look for issues labeled `good first issue` for beginners
- Check `help wanted` labels for priority items
- Comment on an issue to claim it before starting work

#### Creating a Feature Branch

```bash
# Update your local main branch
git checkout main
git pull upstream main

# Create a feature branch
git checkout -b feature/your-feature-name
# Or for bug fixes
git checkout -b fix/issue-description
```

## Development Workflow

### 1. Make Your Changes

- **Write clean, readable code** following Dart conventions
- **Add/update tests** for your changes
- **Update documentation** as needed
- **Keep changes focused** - one feature/fix per PR

### 2. Run Local Tests

```bash
# Run tests for specific package
cd packages/your_package
dart test

# Run all tests across monorepo
melos test

# Run analyzer
melos analyze

# Format code
melos format
```

### 3. Test with Examples

If your changes affect the API, test with the example apps:

```bash
cd apps/examples
dart run lib/your_example.dart
```

## Testing Guidelines

### Writing Tests

- **Unit tests** for individual functions/classes
- **Integration tests** for API interactions
- **Example code** demonstrating usage

### Test Structure

```dart
void main() {
  group('FeatureName', () {
    setUp(() {
      // Setup code
    });

    test('should do something specific', () {
      // Arrange
      final input = createTestInput();
      
      // Act
      final result = functionUnderTest(input);
      
      // Assert
      expect(result, expectedValue);
    });

    tearDown(() {
      // Cleanup code
    });
  });
}
```

### Coverage Requirements

- Aim for **>80% test coverage** for new code
- Run coverage locally:
  ```bash
  dart test --coverage=coverage
  dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
  ```

## Code Style

### Dart Style Guide

Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

- Use `dart format` to format code
- Follow naming conventions:
  - `lowerCamelCase` for variables and functions
  - `UpperCamelCase` for types
  - `lowercase_with_underscores` for libraries and file names

### Additional Guidelines

- **Keep lines under 80 characters** when possible
- **Use meaningful variable names**
- **Add dartdoc comments** for public APIs:
  ```dart
  /// Connects to a Substrate-based blockchain.
  ///
  /// [uri] The WebSocket URI of the node.
  /// Returns a [Provider] instance.
  Future<Provider> connect(Uri uri) async {
    // Implementation
  }
  ```
- **Prefer composition over inheritance**
- **Use `final` for immutable variables**

## Commit Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Test additions or changes
- **chore**: Maintenance tasks
- **perf**: Performance improvements

### Examples

```bash
# Feature
git commit -m "feat(keyring): add support for hardware wallets"

# Bug fix
git commit -m "fix(scale-codec): correct encoding of Option<T> types"

# Documentation
git commit -m "docs(readme): update installation instructions"

# Breaking change
git commit -m "feat(api)!: redesign Provider interface

BREAKING CHANGE: Provider.connect() now returns Future<Provider>"
```

## Pull Request Process

### Before Submitting

1. **Update from upstream**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run all checks**:
   ```bash
   melos test
   melos analyze
   melos format
   ```

3. **Update documentation** if needed

### Creating a Pull Request

1. **Push your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open a PR** on GitHub with:
   - **Clear title** following commit conventions
   - **Description** of changes and motivation
   - **Link to related issues** using "Fixes #123"
   - **Screenshots/examples** if applicable
   - **Breaking changes** clearly marked

### PR Review Process

- **Maintainers will review** your PR within a few days
- **Address feedback** promptly
- **Keep PR updated** with main branch
- **Be patient** - thorough review ensures quality

### After Merge

- **Delete your feature branch**
- **Update your local main**:
  ```bash
  git checkout main
  git pull upstream main
  git push origin main
  ```

## Reporting Issues

### Security Issues

For security vulnerabilities, please email security@polkadart.dev directly instead of creating a public issue.

### Bug Reports

Create an issue with:

```markdown
## Description
Clear description of the bug

## Steps to Reproduce
1. Step one
2. Step two
3. ...

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- Polkadart version:
- Dart SDK version:
- Operating System:
- Flutter version (if applicable):

## Additional Context
Any other relevant information
```

## Documentation

### Types of Documentation

1. **API Documentation**: Dartdoc comments in code
2. **README Files**: Package-specific documentation
3. **Guides**: Tutorial-style documentation in `/docs`
4. **Examples**: Working code in `/apps/examples`

### Writing Documentation

- **Be clear and concise**
- **Include code examples**
- **Explain the "why"** not just the "how"
- **Keep it up to date** with code changes

### Building Documentation Site

```bash
cd docs
npm install
npm run dev  # Development server
npm run build  # Production build
```

## Community

### Getting Help

- **Matrix Chat**: [#polkadart:matrix.org](https://matrix.to/#/%23polkadart:matrix.org)
- **GitHub Discussions**: For questions and ideas
- **Stack Overflow**: Tag questions with `polkadart`

### Staying Updated

- **Watch** the repository for updates
- **Join** our Matrix channel for discussions

## Recognition

Contributors are recognized in our README through the [All Contributors](https://all-contributors.github.io/all-contributors/) specification. Your contributions will be acknowledged!

## License

By contributing to Polkadart, you agree that your contributions will be licensed under the Apache 2.0 License.

---

Thank you for contributing to Polkadart! Your efforts help make blockchain development more accessible to the Dart and Flutter community. 🚀

If you have any questions, don't hesitate to ask in our [Matrix channel](https://matrix.to/#/%23polkadart:matrix.org) or open a discussion on GitHub.