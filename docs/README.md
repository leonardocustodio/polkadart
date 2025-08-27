# Polkadart Documentation

Welcome to the Polkadart documentation website! This site is built with [Astro](https://astro.build/) and [Starlight](https://starlight.astro.build/), providing a modern, fast, and accessible documentation experience.

## 🚀 Quick Start

### Prerequisites

- **Node.js**: Version 18.14.1 or higher
- **pnpm**: Version 8 or higher (install with `npm install -g pnpm`)
- **Git**: For version control

### Installation

1. **Navigate to the docs directory**:
   ```bash
   cd docs
   ```

2. **Install dependencies**:
   ```bash
   pnpm install
   ```

3. **Start the development server**:
   ```bash
   pnpm dev
   ```

   The site will be available at `http://localhost:4321/`

## 📁 Project Structure

```
docs/
├── src/
│   ├── content/          # Documentation content
│   │   ├── docs/         # Main documentation pages
│   │   │   ├── api/      # API reference docs
│   │   │   ├── getting-started/  # Getting started guides
│   │   │   ├── guides/   # How-to guides
│   │   │   ├── ink/      # ink! smart contract docs
│   │   │   ├── intro/    # Introduction pages
│   │   │   ├── keyring-signer/  # Keyring & signing docs
│   │   │   └── metadata/ # Metadata documentation
│   │   └── config.ts     # Content configuration
│   ├── assets/           # Images and icons
│   ├── components/       # Custom Astro components
│   │   ├── dartpad/      # DartPad integration
│   │   ├── landing/      # Landing page components
│   │   ├── polkadart/    # Project-specific components
│   │   └── starlight/    # Starlight overrides
│   ├── pages/            # Custom pages
│   ├── styles/           # CSS styles
│   └── layouts/          # Page layouts
├── public/               # Static assets
├── astro.config.mjs      # Astro configuration
├── package.json          # Dependencies and scripts
└── tsconfig.json         # TypeScript configuration
```

## 🛠️ Available Scripts

### Development

```bash
# Start development server with hot reload
pnpm dev
# or
pnpm start

# Check TypeScript and build for production
pnpm build

# Preview production build locally
pnpm preview

# Format all files with Prettier
pnpm format

# Check formatting without making changes
pnpm format:check
```

## 📝 Writing Documentation

### Adding New Pages

1. **Create a new `.mdx` file** in the appropriate directory under `src/content/docs/`
2. **Add frontmatter** at the top of the file:

   ```mdx
   ---
   title: Your Page Title
   description: Brief description of the page content
   ---

   Your content here...
   ```

3. **Update navigation** in `astro.config.mjs` if needed (sidebar configuration)

### Content Guidelines

#### File Naming
- Use lowercase with hyphens: `getting-started.mdx`, `api-reference.mdx`
- Be descriptive but concise

#### Frontmatter Fields
- `title` (required): Page title shown in navigation
- `description` (required): SEO description
- `sidebar`:
  - `order`: Number to control sidebar position
  - `label`: Custom sidebar label (if different from title)
  - `hidden`: Hide from sidebar
  - `badge`: Add a badge (e.g., "New", "Beta")

#### MDX Features

You can use React components in MDX files:

```mdx
import { Tabs, TabItem } from '@astrojs/starlight/components';
import { Card, CardGrid } from '@astrojs/starlight/components';

<Tabs>
  <TabItem label="Dart">
    ```dart
    final api = await ApiPromise.create(provider);
    ```
  </TabItem>
  <TabItem label="Flutter">
    ```dart
    final api = await ApiPromise.create(provider);
    ```
  </TabItem>
</Tabs>
```

#### Code Blocks

Use triple backticks with language identifiers:

````markdown
```dart
// Dart code example
final provider = Provider.fromUri(Uri.parse('wss://rpc.polkadot.io'));
```

```bash
# Shell commands
pnpm add polkadart
```
````

#### Callouts

Use Starlight's built-in callout syntax:

```mdx
:::note
Important information for users
:::

:::tip
Helpful tips and best practices
:::

:::caution
Things to be careful about
:::

:::danger
Critical warnings
:::
```

## 🎨 Customization

### Styling

- **Custom CSS**: Add styles to `src/styles/custom.css`
- **Tailwind CSS**: Available for utility classes
- **Theme colors**: Configured in `astro.config.mjs`

### Components

Create custom components in `src/components/`:

```astro
---
// src/components/MyComponent.astro
const { title } = Astro.props;
---

<div class="my-component">
  <h3>{title}</h3>
  <slot />
</div>
```

Use in MDX:

```mdx
import MyComponent from '@/components/MyComponent.astro';

<MyComponent title="Example">
  Content goes here
</MyComponent>
```

## 🔍 Search Configuration

The site uses Algolia DocSearch. To configure:

1. **Set environment variables** in `.env`:
   ```bash
   ALGOLIA_APP_ID=your_app_id
   ALGOLIA_API_KEY=your_api_key
   ALGOLIA_INDEX_NAME=your_index_name
   ```

2. **Update configuration** in `astro.config.mjs` if needed

## 🚀 Deployment

### Building for Production

```bash
# Build the site
pnpm build

# Preview the build locally
pnpm preview
```

The built site will be in the `dist/` directory.

### GitHub Actions

The documentation automatically deploys when changes are pushed to the main branch. See `.github/workflows/docs_build.yml` for the deployment configuration.

## 📚 Resources

### Documentation
- [Astro Documentation](https://docs.astro.build/)
- [Starlight Documentation](https://starlight.astro.build/)
- [MDX Documentation](https://mdxjs.com/)

### Starlight Features
- [Components](https://starlight.astro.build/guides/components/)
- [Sidebar Navigation](https://starlight.astro.build/guides/sidebar/)
- [Internationalization](https://starlight.astro.build/guides/i18n/)
- [Search](https://starlight.astro.build/guides/site-search/)

## 🤝 Contributing

### Documentation Improvements

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b docs/your-improvement`
3. **Make your changes** following the guidelines above
4. **Test locally**: `pnpm build && pnpm preview`
5. **Submit a pull request**

### Best Practices

- **Keep it simple**: Write clear, concise documentation
- **Use examples**: Include code examples wherever possible
- **Test your changes**: Always build and preview before submitting
- **Check links**: Ensure all links work correctly
- **Follow style guide**: Use consistent formatting and structure

## 📄 License

The documentation is part of the Polkadart project and follows the same Apache 2.0 license.

---

For more help, visit our [Matrix channel](https://matrix.to/#/%23polkadart:matrix.org) or open an issue on [GitHub](https://github.com/leonardocustodio/polkadart/issues).
