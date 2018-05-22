task :default do
    sh "swift --version"
    sh "swift run -Xswiftc \"-target\" -Xswiftc \"x86_64-apple-macosx10.12\" vsh Samples/main.volt"
end

task :test do
    exit system("swift test")
end
