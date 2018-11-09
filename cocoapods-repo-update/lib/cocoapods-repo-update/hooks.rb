module CocoaPodsRepoUpdate
  # Registers for CocoaPods plugin hooks
  module Hooks
    Pod::HooksManager.register(CocoapodsRepoUpdate::NAME, :pre_install) do |installer_context, options|
      analyser = Pod::Installer::Analyzer.new(installer_context.sandbox, installer_context.podfile, installer_context.lockfile)
      begin
        analyser.analyze
        UI.puts "Not updating local specs repo."
      rescue Pod::Informative
        UI.puts "At least one Pod is not in the local specs repo. Updating the repo..."

        repos_dir = Pathname.new("~/.cocoapods/repos").expand_path

        source_manager = Pod::Source::Manager.new(repos_dir)
        source_manager.update(nil, false)
      end
    end
  end
end
