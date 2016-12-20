module.exports = {
  target: 'node',
  entry: './lib/js/src/main.js',
  output: {
    path: 'dist',
    filename: 'main.js',
    library: 'main',
    libraryTarget: 'commonjs2',
  },
}
