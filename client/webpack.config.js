const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  output: {
    path: path.join(__dirname, '/dist'),
    publicPath: '/assets/',
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
      {
        test: /\.(png|jpg|svg|ico)$/,
        loader: 'file-loader',
        options: {
          name: '[name].[ext]'
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html"
    })
  ]
}
