# LETS (Local Energy Trading System) app

A LETS currency system and mobile application built for Ethereum-like networks.

<!-- MarkdownTOC -->

- [Installation](#installation)
- [How to use](#how-to-use)
- [Modules](#modules)
- [File structure](#file-structure)
- [Future](#future)
- [License](#license)

<!-- /MarkdownTOC -->

## Installation

- Ensure you are using node `v8.11.1` or higher. Use [nvm](https://github.com/creationix/nvm) when configuring for development to avoid version conflicts with other projects.
- If you don't have the latest version of [yarn](https://yarnpkg.com): `npm i -g yarn`
- run `yarn install` at the toplevel folder to install dependencies.

## How to use

- `npm run dev` brings up the mobile app server and gives you an Expo app QR code. See [App &rarr; Setting up / quickstart](mobile-app/README.md#setting-up--quickstart).

See the README file in each module folder for more indepth information on its operation.

## Modules

This package provides the following modules. Click on the name to view each individual readme file for further information.

- [`lets-contracts`](lets-contracts/README.md): Smart contracts describing a LETS system
- [`maleny-lets-views`](maleny-lets-views): View layer / design system for app interface; themed specifically to local LETS chapter
- [`mobile-app`](mobile-app/README.md): [React Native](https://facebook.github.io/react-native/) app for interacting with the blockchain




## File structure

This repo uses [Yarn workspaces](https://yarnpkg.com/lang/en/docs/workspaces/) to manage dependencies. This results in a nice clean dev setup where all repositories are automatically linked and can be managed as a single codebase.

There are problems with this- see https://github.com/viewstools/yarn-workspaces-cra-crna for workarounds currently employed.

## Future

Something to keep in mind- this app will eventually need to be 'ejected' from Expo in order to run a fully native layer so that we can sync pending blockchain transactions in the background when 3G connectivity is restored to the device.




## License

MIT
