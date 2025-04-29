import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import partytown from '@astrojs/partytown';
import sitemap from '@astrojs/sitemap';
import icon from 'astro-icon';
import starlightDocSearch from '@astrojs/starlight-docsearch';
import { loadEnv } from 'vite';

const { ALGOLIA_APP_ID, ALGOLIA_API_KEY, ALGOLIA_INDEX_NAME } = loadEnv(
	process.env.NODE_ENV,
	process.cwd(),
	''
);

export default defineConfig({
	server: {
		allowedHosts: ['41a74fcd29ea.ngrok.app']
	},
	site: 'https://polkadart.dev',
	prefetch: {
		prefetchAll: true,
	},
	integrations: [
		partytown({
			config: {
				forward: ['dataLayer.push'],
			},
		}),
		sitemap(),
		icon(),
		starlight({
			title: 'Polkadart',
			description:
				'Polkadart is a Dart & Flutter library for interacting with Polkadot-based blockchains. It provides a simple and easy-to-use API to interact with the Polkadot network.',
			social: [
				{ icon: 'matrix', label: 'Matrix', href: 'https://matrix.to/#/#polkadart:matrix.org' },
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/leonardocustodio/polkadart' },
			],
			logo: {
				light: './src/assets/logo-black.png',
				dark: './src/assets/logo-white.png',
				replacesTitle: true,
			},
			expressiveCode: {
				themes: ['dark-plus', 'github-light'],
			},
			editLink: {
				baseUrl: 'https://github.com/polkadart/docs/edit/main',
			},
			tableOfContents: {
				maxHeadingLevel: 4,
			},
			lastUpdated: true,
			sidebar: [
				{
					label: 'Introduction',
					items: [{ label: 'Overview', slug: 'intro' }],
				},
				{
					label: 'Getting started',
					items: [
						{ label: 'Installation', slug: 'getting-started/installation' },
						{ label: 'Type generator', slug: 'getting-started/type-generator' },
						{ label: 'Connecting', slug: 'getting-started/connecting' },
						{ label: 'Decoding data', slug: 'getting-started/decoding' },
					],
				},
				{
					label: 'Polkadart API',
					items: [
						{ label: 'Overview', slug: 'api/overview' },
						{ label: 'State API', slug: 'api/state' },
						{ label: 'System API', slug: 'api/system' },
						{ label: 'Chain API', slug: 'api/chain' },
						{ label: 'Author API', slug: 'api/author' },
					],
				},
				{
					label: 'Blockchain API',
					items: [
						{ label: 'Overview', slug: 'metadata/overview' },
						{ label: 'Extrinsics', slug: 'metadata/extrinsics' },
						{ label: 'Constants', slug: 'metadata/constants' },
					],
				},
				{
					label: 'Keyring & Signer',
					items: [
						{ label: 'Overview', slug: 'keyring-signer/overview' },
						{ label: 'Keypair', slug: 'keyring-signer/keypair' },
						{ label: 'SS58 format', slug: 'keyring-signer/ss58' },
						{ label: 'Sign & Verify', slug: 'keyring-signer/sign-verify' },
					],
				},
				{
					label: 'ink! Smart Contracts',
					items: [
						{ label: 'Overview', slug: 'ink/overview' },
						{ label: 'ABI', slug: 'ink/ink_abi' },
						{ label: 'CLI', slug: 'ink/ink_cli' },
					],
				},
				{
					label: 'Guides',
					autogenerate: { directory: 'guides' },
				},
				{
					label: 'Support & Community',
					items: [
						{ label: 'Built with Polkadart', slug: 'support-community' },
						{
							label: 'Matrix',
							link: 'https://matrix.to/#/#polkadart:matrix.org',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'GitHub',
							link: 'https://github.com/leonardocustodio/polkadart',
							attrs: { target: '_blank', class: 'external' },
						},
					],
				},
				{
					label: 'References',
					items: [
						{
							label: 'polkadart',
							link: 'https://pub.dev/documentation/polkadart/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'polkadart_cli',
							link: 'https://pub.dev/documentation/polkadart_cli/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'polkadart_keyring',
							link: 'https://pub.dev/documentation/polkadart_keyring/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'polkadart_scale_codec',
							link: 'https://pub.dev/documentation/polkadart_scale_codec/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'secp256k1_ecdsa',
							link: 'https://pub.dev/documentation/secp256k1_ecdsa/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'sr25519',
							link: 'https://pub.dev/documentation/sr25519/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'ss58',
							link: 'https://pub.dev/documentation/ss58/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'substrate_bip39',
							link: 'https://pub.dev/documentation/substrate_bip39/latest',
							attrs: { target: '_blank', class: 'external' },
						},
						{
							label: 'substrate_metadata',
							link: 'https://pub.dev/documentation/substrate_metadata/latest',
							attrs: { target: '_blank', class: 'external' },
						},
					],
				},
			],
			plugins: [
				starlightDocSearch({
					appId: ALGOLIA_APP_ID,
					apiKey: ALGOLIA_API_KEY,
					indexName: ALGOLIA_INDEX_NAME,
				}),
			],
		}),
	],
});
