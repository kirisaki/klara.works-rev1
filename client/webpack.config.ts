import path from 'path'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import * as webpack from 'webpack'

const config: webpack.Configuration = {
  output: {
    path: path.join(__dirname, '/dist'),
    publicPath: '/assets/',
  },
  resolve: {
    extensions: ['.ts', '.tsx', '.js', '.jsx']
  },
  devServer:{
    host: '0.0.0.0',
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
export default config
