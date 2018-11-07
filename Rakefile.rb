@success = true

def run_tests platform, browser, version, junit_dir, html_dir
  system("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" parallel_cucumber features -o \"--format junit --out #{junit_dir} --format html --out #{html_dir}.html --format pretty\" -n 20") do |success, _exit_code|
    @success &= success
  end
end

task :default => [:windows_10_edge_14]

task :windows_10_edge_14 do
  run_tests('Windows 10', 'edge', '14.14393', 'test_out/junit_reports/windows_10_edge_14', 'test_out/html_reports/windows_10_edge_14')
end