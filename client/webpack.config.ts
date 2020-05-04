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
  publicPath: args.mode === 'production' ? '/assets/' : '/',
})

const resolve: Resolve = {
  extensions: ['.ts', '.tsx', '.js', '.jsx'],
}

const devServer: WebpackDevServer.Configuration = {
  host: '0.0.0.0',
  historyApiFallback: true,
  proxy: {
    '/api': 'http://localhost:8000',
    '/assets/thumbnails': 'http://localhost:8000',
    '/assets/works': 'http://localhost:8000',
  },
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

const fileRule = (args: CliConfigOptions): Rule => ({
  test: /\.(png|jpg|svg|ico)$/,
  loader: 'file-loader',
  options: {
    name: args.mode === 'production' ? '[name].[ext]' : 'assets/[name].[ext]'
  },
})

const modules = (args: CliConfigOptions): Module => ({
  rules: [
    tsxRule,
    cssRule,
    fileRule(args),
  ]
})

const config: ConfigurationFactory = (_, args) => {
  return ({
    output: output(args),
    resolve,
    devServer,
    module: modules(args),
    plugins: [
      new HtmlWebpackPlugin({
        template: "./src/index.html"
      })
    ]
  })
}
export default config
