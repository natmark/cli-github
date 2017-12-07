require 'thor'
require 'json'

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
        # option :from, type: :string, default: "none"
        # def hello(name)
        #     puts "Hello #{name} from #{options[:from]}"
        # end

        desc 'search QUERY', 'open github.com/search'
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

        desc 'create github repo', 'create repository on GitHub'
        def create(repo_name)
            config = ConfigManager.load()
            exec("curl -H 'Authorization: token #{config['token']}' https://api.github.com/user/repos -d '{\"name\":\"#{repo_name}\"}'")
        end


        # option :from, type: :string, default: "none"
        # def hello(name)
        #     puts "Hello #{name} from #{options[:from]}"
        # end
        option :token, type: :string, default: nil
        option :user_name, type: :string, default: nil

        desc 'config (set|get)', 'config'
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
