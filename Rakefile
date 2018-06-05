BIN_DIR = "bin"
SOURCERY_ZIP = "#{BIN_DIR}/sourcery.zip"
SOURCERY_BINARY = "#{BIN_DIR}/bin/sourcery"

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
task :sourcery => SOURCERY_BINARY do
  configs = Dir["Sourcery/Configs/**/*.yml"]
  configs.each do |config|
    sh "#{SOURCERY_BINARY} --config \"#{File.expand_path(config)}\""
  end
end

directory BIN_DIR

file SOURCERY_BINARY => SOURCERY_ZIP do
  sh "unzip -o -a #{SOURCERY_ZIP} -d #{BIN_DIR}"
  touch SOURCERY_BINARY
end

file SOURCERY_ZIP => BIN_DIR do
  sh "curl -L https://github.com/krzysztofzablocki/Sourcery/releases/download/0.13.1/Sourcery-0.13.1.zip --output #{SOURCERY_ZIP}"
end
