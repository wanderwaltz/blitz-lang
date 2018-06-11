BIN_DIR = "bin"
SOURCERY_ZIP = "#{BIN_DIR}/sourcery.zip"
SOURCERY_BINARY = "#{BIN_DIR}/bin/sourcery"

desc "run bsh with Samples/main.blitz"
task :default do
    sh "swift --version"
    sh "swift run -Xswiftc \"-target\" -Xswiftc \"x86_64-apple-macosx10.12\" bsh Samples/main.blitz"
end

desc "run tests"
task :test do
    exit system("swift test")
end

desc "run code generation"
task :sourcery => SOURCERY_BINARY do
    templates = Dir["**/_sourcery/*.ejs"]

    templates.each do |path_to_ejs|
        file_name = File.basename(path_to_ejs).ext("swift")
        dir = File.dirname(path_to_ejs)
        generated_file_dir = File.join(dir, "..", file_name)
        common_templates_path = Pathname.new("_sourcery-common").relative_path_from(Pathname.new(dir)).to_s + "/"

        command = [
            SOURCERY_BINARY,
            "--templates \"#{path_to_ejs}\"",
            "--sources \".\"",
            "--args common_templates_path=#{common_templates_path}",
            "--output \"#{generated_file_dir}\""
        ].join(" ")

        sh command
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
