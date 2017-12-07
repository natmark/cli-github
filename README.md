# cli-github
cli-github is useful GitHub command line tools

## Installation

Install it yourself as:

```
$ gem specific_install -l "git@github.com:natmark/cli-github.git"
```

## Usage
Execute `$ cli-github` and show all commands.

### Open repository
`$ cli-github open  # execute under git directory`

### Search repository
`$ cli-github search [query] # open https://github.com/search?q=[query]`

### Create repository
- Step1. Please set your github token.

`$ cli-github config set --token=[GITHUB_TOKEN_INPUT_HERE]`

#### Check your token
`$ cli-github config get # if you want to check your token`

- Step2. Create GitHub repo

`$ cli-github create [reponame]`

```
$ cli-github create sample

A short description of the repository: sample repository
Create a private repository? [Y/n]
Y
Create an initial commit with empty README? [Y/n]
Y
Use the name of the template without the extension. (https://github.com/github/gitignore)  |C++|
Ruby
Choose an open source license template that best suits your needs. (https://help.github.com/articles/licensing-a-repository/#searching-github-by-license-type)  |mit|

==========SUCCESS==========
repo_name: natmark/sample
url: https://api.github.com/repos/natmark/sample
git_url: git://github.com/natmark/sample.git
isPrivate: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/natmark/cli-github. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

