require 'librarian/dsl'
require 'librarian/puppet/source'

module Librarian
  module Puppet
    class Dsl < Librarian::Dsl

      dependency :mod

      source :forge => Source::Forge
      source :git => Source::Git
      source :path => Source::Path
      source :github_tarball => Source::GitHubTarball
    end
  end
end

module Librarian
  class Dsl
    class Receiver
      def modulefile
        File.read('Modulefile').lines.each do |line|
          /^dependency/ =~ line && instance_eval(line)
        end
      end

      #alias_method won't work as mod has yet to be defined
      def dependency(*args); mod *args; end
    end
  end
end
