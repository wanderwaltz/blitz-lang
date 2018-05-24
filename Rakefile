desc "run vsh with Samples/main.volt"
task :default do
    sh "swift --version"
    sh "swift run -Xswiftc \"-target\" -Xswiftc \"x86_64-apple-macosx10.12\" vsh Samples/main.volt"
end

desc "run tests"
task :test do
    exit system("swift test")
end

desc "run code generation"
task :sourcery do
  configs = Dir["Sourcery/Configs/**/*.yml"]
  configs.each do |config|
    sh "bin/sourcery --config #{File.expand_path(config)}"
  end
end