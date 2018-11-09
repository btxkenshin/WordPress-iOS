echo "Installing plugin"
cd cocoapods-repo-update/
gem build cocoapods-repo-update.gemspec
sudo gem install --local cocoapods-repo-update-0.0.1.gem
