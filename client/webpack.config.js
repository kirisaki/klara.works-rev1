const path = require('path')

module.exports = {
  output: {
    path: path.join(__dirname, '/dist'),
    publicPath: '/scripts/',
  },
  devServer:{
    contentBase: path.join(__dirname, '/dist')
  },
  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        loader: 'ts-loader',
        options: {
          transpileOnly: true
        }
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader?modules'],
      },
    ],
  },
}
