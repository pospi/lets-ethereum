/**
 * Deal with parent dir includes
 *
 * @author:  pospi <sam.pospi@consensys.net>
 * @since:   2018-04-06
 * @flow
 */

const path = require('path')
const getConfig = require('metro-bundler-config-yarn-workspaces')

module.exports = getConfig(__dirname, {
    nodeModules: path.resolve(__dirname, '..')
})
