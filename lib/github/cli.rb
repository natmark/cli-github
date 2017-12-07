require 'thor'
require 'json'
require 'net/http'
require 'uri'
require 'highline'

module Github
    class ConfigManager
        @@JSON_FILE_PATH = 'config.json'
        def self.load
            ConfigManager.save({'token' => ''}) unless File.exist?(@@JSON_FILE_PATH)

            config = open(@@JSON_FILE_PATH) do |io|
                JSON.load(io)
            end
        end

        def self.save(config)
            open(@@JSON_FILE_PATH, 'w') do |io|
                JSON.dump(config, io)
            end
        end
    end

    class CLI < Thor

        desc 'search [query]', 'open https://github.com/search?q=[query]'
        def search(query)
            exec("open https://github.com/search?q=#{query}")
        end

        desc 'open', 'open repository'
        def open()
            `
            if test -z $(git remote get-url --push origin 2> /dev/null); then
                open 'https://github.com'
            else
                open $(git remote get-url --push origin 2> /dev/null)
            fi
            `
        end

        desc 'create [repo_name]', 'create repository on GitHub'
        def create(repo_name)
            config = ConfigManager.load()

            uri = URI.parse("https://api.github.com/user/repos")
            https = Net::HTTP.new(uri.host, uri.port)

            https.use_ssl = true
            req = Net::HTTP::Post.new(uri.request_uri)

            req["Content-Type"] = "application/json"
            req["Authorization"] = "token #{config['token']}"


            cli = HighLine.new
            description = cli.ask("A short description of the repository: ")

            private = cli.agree("Create a private repository? [Y/n]")
            auto_init = cli.agree("Create an initial commit with empty README? [Y/n]")

            gitignore_template = cli.ask("Use the name of the template without the extension. (https://github.com/github/gitignore)") {|q| q.default = 'C++' }
            license_template = cli.ask("Choose an open source license template that best suits your needs. (https://help.github.com/articles/licensing-a-repository/#searching-github-by-license-type)") {|q| q.default = 'mit' }

            payload = {
                "name" => repo_name,
                "description" => description,
                "private" => private,
                "auto_init" => auto_init,
                "gitignore_template" => gitignore_template,
                "license_template" => license_template
            }.to_json

            req.body = payload
            res = https.request(req)
            json = JSON.parse(res.body)

            if res.code.to_i.between?(200,300)
                puts "==========SUCCESS=========="
                puts "repo_name: #{json["full_name"]}"
                puts "html_url: #{json["html_url"]}"
                puts "git_url: #{json["git_url"]}"
                puts "isPrivate: #{json["private"]}"
                puts "description: #{json["description"]}"  if json["description"] != nil
            else
                puts "ERROR: " + json["errors"][0]["message"]
            end
        end

        option :token, type: :string, default: nil
        option :user_name, type: :string, default: nil

        desc 'config [set|get]', 'config'
        def config(command)
            config = ConfigManager.load()
            case command
                when 'set' then
                    config['token'] = options[:token] if options[:token] != nil
                    ConfigManager.save(config)

                when 'get' then
                    puts 'token: ' + config['token']
            end
        end
    end
end
