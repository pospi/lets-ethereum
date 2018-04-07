/**
 * Create-React-Native-App entrypoint file to bind to Expo runtime
 *
 * Copied from https://raw.githubusercontent.com/react-community/create-react-native-app/master/react-native-scripts/src/bin/crna-entry.js
 * for reasons outlined in https://github.com/viewstools/yarn-workspaces-cra-crna
 *
 * @package: LETS Mobile
 * @author:  pospi <sam.pospi@consensys.net>
 * @since:   2018-04-07
 * @flow
 */

import Expo from 'expo';
import App from './App';
import React, { Component } from 'react';
import { View } from 'react-native';

if (process.env.NODE_ENV === 'development') {
  Expo.KeepAwake.activate();
}

Expo.registerRootComponent(App);
