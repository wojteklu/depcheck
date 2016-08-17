# Depcheck

`Depcheck` is a dependency analyzer tool for Swift projects. `Depcheck` reports dependencies per class, allowing you to easily detect classes that have too many dependencies. `Depcheck` can also report how many dependants a class have. Therefore you can spot the most used and unused classes.

<img src="https://github.com/wojteklu/depcheck/blob/master/example/analyze.png?raw=true">

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'depcheck'
```

And then execute:

```sh
$ bundle
```

Or install the gem:

```sh
gem install depcheck
```

## Usage

`Analyze` command reports dependencies per classes. `Usage` command reports how many dependants a class have.

Build your project, and then run:

```sh
$ depcheck analyze --project path/to/project.xcodeproj

```

If you use a workspace in Xcode you need to specify it:

```sh
$ depcheck analyze --workspace path/to/workspace.xcworkspace --scheme YourXcodeSchemeName
```

## Contributing

I’d love to see your ideas for improving this library! The best way to contribute is by submitting a pull request. I’ll do my best to respond to your patch as soon as possible. You can also submit a [new GitHub issue](https://github.com/wojteklu/depcheck/issues/new) if you find bugs or have questions.

## License

This project is licensed under the terms of the MIT license. See the LICENSE file.
