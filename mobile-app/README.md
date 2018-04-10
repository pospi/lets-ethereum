<!-- MarkdownTOC -->

- [About](#about)
- [Setting up / quickstart](#setting-up--quickstart)
- [Using the app](#using-the-app)
- [Other commands](#other-commands)
- [TODO](#todo)
    - [Customizing App Display Name and Icon](#customizing-app-display-name-and-icon)
    - [Writing and Running Tests](#writing-and-running-tests)
    - [Environment Variables](#environment-variables)
        - [Configuring Packager IP Address](#configuring-packager-ip-address)
    - [Adding Flow](#adding-flow)
    - [Wrap up commands](#wrap-up-commands)
- [Troubleshooting](#troubleshooting)
    - [Networking](#networking)
    - [iOS Simulator won't open](#ios-simulator-wont-open)
    - [QR Code does not scan](#qr-code-does-not-scan)

<!-- /MarkdownTOC -->

## About

This project was bootstrapped with [Create React Native App](https://github.com/react-community/create-react-native-app). The most recent version of the RN app guide is available [here](https://github.com/react-community/create-react-native-app/blob/master/react-native-scripts/template/README.md).

## Setting up / quickstart

- Install packages: `npm i`
- Install the [Expo app](https://expo.io) to your Android or iOS phone and connect to the same network as your dev machine
- Run `npm start` to bring up development server
- Scan the QR code with the app & away you go!

Sometimes you may need to reset or clear the React Native packager's cache. To do so, you can pass the `--reset-cache` flag to the start script:
<!-- :TODO: define "sometimes" -->

```
npm start --reset-cache
# or
yarn start --reset-cache
```

## Using the app

Primary design goals of this application are to be as frictionless to use as possible, and to work in remote areas of poor network coverage. In practical terms we've designed a system which requires only 1 data transmission in order to verify an exchange "securely-enough" in the absence of internet connectivity.

We thus made the choice to put this onus on the payee; it is their incentive as the ones receiving a credit to "cash the check", as it were.

Prior to engaging, the buyer may optionally scan token prices for goods / services on sale, to avoid having to manually enter a credit value. But this initial scan is for convenience only and is not required to trade.

Once the buyer and seller have agreed upon a value, the exchange system works as follows:

- The buyer inputs the number of credits to release to the seller
- The buyer's device generates a nonce and signs an "approve" transaction authorizing anyone holding the nonce to spend the specified amount of their tokens
- The seller scans the buyer's device, receiving the signed approval transaction and nonce for claiming the payment
- It is now the responsibility of the seller to return to normal network coverage and broadcast the buyer's transaction to the network, as well as a subsequent transaction of their own to claim the released funds. The buyer's device may also synchronise their half of the transaction ahead of time.
- *"Would you like a receipt?"* is the normal social contract whereby the seller would have the buyer scan their device a second time, such that each party now holds both transactions ready for broadcast to the network.

## Other commands

- `npm test`  
    Runs the [jest](https://github.com/facebook/jest) test runner on your tests.
- `npm run ios`: run in iOS simulator on OSX. See RN app guide docs for more info.
- `npm run android`: run in Android AVD. See RN app guide docs for more info.







## TODO

### Customizing App Display Name and Icon

You can edit `app.json` to include [configuration keys](https://docs.expo.io/versions/latest/guides/configuration.html) under the `expo` key.

To change your app's display name, set the `expo.name` key in `app.json` to an appropriate string.

To set an app icon, set the `expo.icon` key in `app.json` to be either a local path or a URL. It's recommended that you use a 512x512 png file with transparency.

### Writing and Running Tests

This project is set up to use [jest](https://facebook.github.io/jest/) for tests. You can configure whatever testing strategy you like, but jest works out of the box. Create test files in directories called `__tests__` or with the `.test` extension to have the files loaded by jest. See the [the template project](https://github.com/react-community/create-react-native-app/blob/master/react-native-scripts/template/App.test.js) for an example test. The [jest documentation](https://facebook.github.io/jest/docs/en/getting-started.html) is also a wonderful resource, as is the [React Native testing tutorial](https://facebook.github.io/jest/docs/en/tutorial-react-native.html).

### Environment Variables

You can configure some of Create React Native App's behavior using environment variables.

#### Configuring Packager IP Address

When starting your project, you'll see something like this for your project URL:

```
exp://192.168.0.2:19000
```

The "manifest" at that URL tells the Expo app how to retrieve and load your app's JavaScript bundle, so even if you load it in the app via a URL like `exp://localhost:19000`, the Expo client app will still try to retrieve your app at the IP address that the start script provides.

In some cases, this is less than ideal. This might be the case if you need to run your project inside of a virtual machine and you have to access the packager via a different IP address than the one which prints by default. In order to override the IP address or hostname that is detected by Create React Native App, you can specify your own hostname via the `REACT_NATIVE_PACKAGER_HOSTNAME` environment variable:

Mac and Linux:

```
REACT_NATIVE_PACKAGER_HOSTNAME='my-custom-ip-address-or-hostname' npm start
```

Windows:
```
set REACT_NATIVE_PACKAGER_HOSTNAME='my-custom-ip-address-or-hostname'
npm start
```

The above example would cause the development server to listen on `exp://my-custom-ip-address-or-hostname:19000`.

### Adding Flow

- Setup via eslint.
- Enforce strictest ruleset by default

### Wrap up commands

- bootstrap contract deployment to testnet
- run dev chain & RN app simultaneously




## Troubleshooting

### Networking

If you're unable to load your app on your phone due to a network timeout or a refused connection, a good first step is to verify that your phone and computer are on the same network and that they can reach each other. Create React Native App needs access to ports 19000 and 19001 so ensure that your network and firewall settings allow access from your device to your computer on both of these ports.

Try opening a web browser on your phone and opening the URL that the packager script prints, replacing `exp://` with `http://`. So, for example, if underneath the QR code in your terminal you see:

```
exp://192.168.0.1:19000
```

Try opening Safari or Chrome on your phone and loading

```
http://192.168.0.1:19000
```

and

```
http://192.168.0.1:19001
```

If this works, but you're still unable to load your app by scanning the QR code, please open an issue on the [Create React Native App repository](https://github.com/react-community/create-react-native-app) with details about these steps and any other error messages you may have received.

If you're not able to load the `http` URL in your phone's web browser, try using the tethering/mobile hotspot feature on your phone (beware of data usage, though), connecting your computer to that WiFi network, and restarting the packager. If you are using a VPN you may need to disable it.

### iOS Simulator won't open

If you're on a Mac, there are a few errors that users sometimes see when attempting to `npm run ios`:

* "non-zero exit code: 107"
* "You may need to install Xcode" but it is already installed
* and others

There are a few steps you may want to take to troubleshoot these kinds of errors:

1. Make sure Xcode is installed and open it to accept the license agreement if it prompts you. You can install it from the Mac App Store.
2. Open Xcode's Preferences, the Locations tab, and make sure that the `Command Line Tools` menu option is set to something. Sometimes when the CLI tools are first installed by Homebrew this option is left blank, which can prevent Apple utilities from finding the simulator. Make sure to re-run `npm/yarn run ios` after doing so.
3. If that doesn't work, open the Simulator, and under the app menu select `Reset Contents and Settings...`. After that has finished, quit the Simulator, and re-run `npm/yarn run ios`.

### QR Code does not scan

If you're not able to scan the QR code, make sure your phone's camera is focusing correctly, and also make sure that the contrast on the two colors in your terminal is high enough. For example, WebStorm's default themes may [not have enough contrast](https://github.com/react-community/create-react-native-app/issues/49) for terminal QR codes to be scannable with the system barcode scanners that the Expo app uses.

If this causes problems for you, you may want to try changing your terminal's color theme to have more contrast, or running Create React Native App from a different terminal. You can also manually enter the URL printed by the packager script in the Expo app's search bar to load it manually.
