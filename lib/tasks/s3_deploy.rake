task :deploy => [:environment] do
  pid = nil
  begin
    # port = find_free_port_number
    port = 3010
    Bundler.with_clean_env do
      system("rm -rf out")
      puts 'spawn'
      pid = spawn("bundle exec rails s --port=#{port} --environment=production --pid=tmp/pids/deploy.pid")
      retries = 20
      loop do
        puts 'checking...'
        break if page_ready?(port)
        sleep 1
        retries -= 1
        raise 'Not ready' if retries <= 0
      end
      paths = []
      paths << '/'
      paths << '/feeds/audiobooks.rss'
      paths << '/random-book-review'
      paths << routes.category_path('all', format: :atom)
      urls = paths.map { |p| "http://localhost:#{port}#{p}" }.join(' ')
      # --no-clobber
      # --mirror: --recursive --timestamping --level=inf --no-remove-listing
      cmd = %W[
        wget
        --mirror
        --convert-links
        --no-host-directories
        --page-requisites
        --adjust-extension
        --no-verbose
        -e robots=off
        --header 'Host: antulik.com'
        --directory-prefix=./out
        #{urls}
      ]
      system(cmd.join(' '))
      cmd = %w[
      find ./out/ -type f -name '*.html' -exec sed -i '' -e 's/http:\/\/localhost:3010/https:\/\/antulik.com/g' {} +
      ]
      system(cmd.join(' '))
      dirs = [
        Dir['posts/*/'],
        'public/'
      ].flatten
      dirs.each do |folder|
        puts "copying folder #{folder}"
        system('cp', '-c', '-n', '-R', folder, 'out/')
      end
      system("s3_website push")
    end
  ensure
    Process.kill('INT', pid)
  end
end
