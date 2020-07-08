cask 'ashpodman' do
    version '0.0.1'
    sha256 'caa6d43c799b29daac152c86bb753e27f91405b223488abdfa992f375a8a21bf'
  
    url "https://github.com/ashley-cui/homebrew-test/releases/download/v#{version}/podman-remote-release-darwin.zip"
    appcast 'https://github.com/containers/libpod/releases.atom'
    name 'podman'
    homepage 'https://github.com/containers/libpod/'
  
    binary 'podman'

  
    postflight do
        man1 = Dir["#{staged_path}/docs/*.1"]
        FileUtils.mv(man1, "#{HOMEBREW_PREFIX}/share/man/man1/")

        FileUtils.mkdir_p "#{ENV['HOME']}/.config/containers"
        FileUtils.mv("#{staged_path}/containers.conf", "#{ENV['HOME']}/.config/containers/containers.conf") unless File.exist?("#{ENV['HOME']}/.config/containers/containers.conf")
    end

    uninstall_postflight do
        man1 = Dir["#{HOMEBREW_PREFIX}/share/man/man1/podman*.1"]
        FileUtils.rm(man1)
      end

    zap trash: "#{ENV['HOME']}/.config/containers"
  
  end