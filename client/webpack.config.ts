import path from 'path'
import HtmlWebpackPlugin from 'html-webpack-plugin'
import {
  CliConfigOptions,
  Output,
  ConfigurationFactory,
  Resolve,
  Module,
  Rule,
} from 'webpack'
import WebpackDevServer from 'webpack-dev-server'

const output = (args: CliConfigOptions): Output => ({
  path: path.join(__dirname, 'dist'),
  publicPath: args.mode == 'production' ? '/assets/' : '/',
})

const resolve: Resolve = {
  extensions: ['.ts', '.tsx', '.js', '.jsx'],
}

const devServer: WebpackDevServer.Configuration = {
  host: '0.0.0.0',
}


const tsxRule: Rule = {
  test: /\.tsx?$/,
  loader: 'ts-loader',
  options: {
    transpileOnly: true
  }
}

const cssRule: Rule = {
  test: /\.css$/,
  use: ['style-loader', 'css-loader?modules'],
}

const fileRule: Rule = {
  test: /\.(png|jpg|svg|ico)$/,
  loader: 'file-loader',
  options: {
    name: '[name].[ext]'
  },
}

const module: Module = {
  rules: [
    tsxRule,
    cssRule,
    fileRule,
  ]
}

const config: ConfigurationFactory = (_, args) => {
  return ({
    output: output(args),
    resolve,
    devServer,
    module,
    plugins: [
      new HtmlWebpackPlugin({
        template: "./src/index.html"
      })
    ]
  })
}
export default config
