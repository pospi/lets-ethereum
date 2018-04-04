# LETS (Local Energy Trading System) app

A LETS currency system and mobile application built for Ethereum-like networks.

<!-- MarkdownTOC -->

- [Installation](#installation)
- [Modules](#modules)
- [File structure](#file-structure)

<!-- /MarkdownTOC -->

## Installation

- Ensure you are using node `v8.11.1` or higher. Use [nvm](https://github.com/creationix/nvm) when configuring for development to avoid version conflicts with other projects.
- If you don't have the latest version of [yarn](https://yarnpkg.com): `npm i -g yarn`
- run `yarn install` at the toplevel folder to install dependencies.

## Modules

This package provides the following modules. Click on the name to view each individual readme file for further information.

- [`lets-contracts`](lets-contracts/README.md): Smart contracts describing a LETS system
- [`mobile-app`](mobile-app/README.md): [React Native](https://facebook.github.io/react-native/) app for interacting with the blockchain

## File structure

This repo uses [Yarn workspaces](https://yarnpkg.com/lang/en/docs/workspaces/) to manage dependencies. This results in a nice clean dev setup where all repositories are automatically linked and can be managed as a single codebase.
