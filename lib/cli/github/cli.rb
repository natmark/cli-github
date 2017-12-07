require 'thor'

module Github
    class CLI < Thor
        desc "hello NAME", "say hello to NAME"
        option :from, type: :string, default: "none"

        def hello(name)
            puts "Hello #{name} from #{options[:from]}"
        end
    end
end
